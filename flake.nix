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
      overlays.default = _: prev: {
        carburetor-patch = prev.stdenv.mkDerivation {
          name = "carburetor-patch";
          src = ./.;
          installPhase = ''
            mkdir -p $out/bin
            cp ./patch.sh $out/bin/carburetor-patch
            chmod +x $out/bin/carburetor-patch
          '';
        };
        carburetor-gtk = prev.callPackage ./nix/pkgs/gtk.nix { };
        carburetor-papirus-folders = prev.callPackage ./nix/pkgs/papirus-folders.nix { };
        carburetor-webcord = prev.callPackage ./nix/pkgs/webcord.nix { };
      };

      packages = forAllSystems (pkgs: {
        inherit (pkgs)
          carburetor-patch
          carburetor-gtk
          carburetor-papirus-folders
          carburetor-webcord
          ;
      });

      homeManagerModules = {
        webcord = import ./nix/modules/webcord.nix self;
      };
    };
}
