{
  description = "Overlay and modules for carburetor themes";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
      packages = forAllSystems (pkgs: {
        inherit (pkgs)
          carburetor-patch
          carburetor-gtk
          carburetor-papirus-folders
          carburetor-discord
          ;
      });
      homeManagerModules = {
        webcord = import ./nix/home/webcord.nix self;
        wezterm = import ./nix/home/wezterm.nix self;
        default = import ./nix/home self;
      };
    };
}
