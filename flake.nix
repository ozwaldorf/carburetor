{
  description = "Overlay for carburetor patched catppuccin packages";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:
    let
      forAllSystems =
        function:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
          system: function nixpkgs.legacyPackages.${system}
        );
    in
    {
      overlays.default = final: prev: {
        carburetor-gtk = import ./nix/carburetor-gtk.nix { pkgs = prev; };
      };

      packages = forAllSystems (pkgs: {
        inherit (pkgs) carburetor-gtk;
      });
    };
}
