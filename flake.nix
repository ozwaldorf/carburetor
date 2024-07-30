{
  description = "Carburetor's theme and customized tooling flake";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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

      # Standalone home manager usage example
      homeConfigurations.example =
        (builtins.getFlake "github:nix-community/home-manager/e1391fb22e18a36f57e6999c7a9f966dc80ac073")
        .lib.homeManagerConfiguration
          {
            pkgs = import nixpkgs {
              system = "x86_64-linux";
              overlays = [ self.overlays.default ];
            };
            modules = [
              self.homeManagerModules.default
              {
                home = {
                  username = "example";
                  homeDirectory = "/home/example";
                  stateVersion = "24.05";
                };

                carburetor = {
                  config = {
                    variant = "regular";
                    accent = "blue";
                  };
                  themes = {
                    gtk = {
                      enable = true;
                      transparency = true;
                      icon = true;
                      # size = "compact";
                      # tweaks = "float";
                      # gnomeShellTheme = true;
                    };
                    hyprland.enable = true;
                    hyprlock.enable = true;
                    webcord = {
                      enable = true;
                      transparency = true;
                    };
                    wezterm.enable = true;
                    zed.enable = true;
                  };
                };
              }
            ];
          };

      # `nix fmt`
      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);
    };
}
