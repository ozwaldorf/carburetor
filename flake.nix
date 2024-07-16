{
  description = "Overlay for carburetor patched catppuccin packages";

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
      overlays.default = final: prev: {
        carburetor-gtk = prev.callPackage ./nix/carburetor-gtk.nix { };
        carburetor-papirus-folders = prev.callPackage ./nix/carburetor-papirus-folders.nix { };
      };

      packages = forAllSystems (pkgs: {
        inherit (pkgs) carburetor-gtk carburetor-papirus-folders;
      });
    };
}
