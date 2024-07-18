{
  description = "Overlay and modules for carburetor themes";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
    in
    {
      overlays.default = import ./nix/pkgs;

      packages = forAllSystems (
        pkgs:
        # re-export all packages created in the overlay
        lib.attrsets.getAttrs (builtins.attrNames (self.overlays.default null null)) pkgs
        // {
          docs = import ./nix/docs.nix pkgs;
        }
      );

      homeManagerModules = {
        default = import ./nix/home;
        webcord = import ./nix/home/webcord.nix;
        wezterm = import ./nix/home/wezterm.nix;
      };
    };
}
