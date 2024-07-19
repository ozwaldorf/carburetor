{
  description = "Carburetor's theme and customized tooling flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  nixConfig = {
    extra-substituters = [ "https://cache.garnix.io" ];
    extra-trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
  };
  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      forAllSystems =
        fun:
        lib.genAttrs lib.systems.flakeExposed (
          system:
          fun (
            import nixpkgs {
              inherit system;
              overlays = [ self.overlays.default ];
            }
          )
        );

      themeLib = import ./nix/lib.nix;
      carburetorTheme = {
        name = "carburetor";
        whiskersJson = ./whiskers.json;
        variantNames = {
          mocha = "regular";
          macchiato = "warm";
          frappe = "cool";
          latte = "light";
        };
        defaultAccent = "blue";
      };
      carburetorOverlay = themeLib.mkCustomThemeOverlay carburetorTheme;
      carburetorHomeModule = themeLib.mkCustomHomeManagerModule carburetorTheme;
    in
    {
      # Nix library for custom catppuccin themes
      lib = themeLib;
      # Carburetor theme overlay
      overlays.default = carburetorOverlay;
      # Carburetor home manager module
      homeManagerModules.default = carburetorHomeModule;

      packages = forAllSystems (pkgs: {
        # Options doc generator
        docs = themeLib.mkDocs carburetorHomeModule pkgs;
        # `carburetor-patch`
        patch = pkgs.carburetor.tools.patch;
      });

      # `nix flake check`
      checks = forAllSystems (pkgs: lib.removeAttrs pkgs.carburetor [ "tools" ]);

      # `nix fmt`
      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);
    };
}
