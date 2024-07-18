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

      homeManagerModules.default = import ./nix/home;

      packages = forAllSystems (
        pkgs:
        let
          overlayPackages = lib.removeAttrs (builtins.attrNames (self.overlays.default null null)) [ "lib" ];
        in
        # re-export all packages created in the overlay
        lib.attrsets.getAttrs overlayPackages pkgs // { docs = import ./nix/docs.nix pkgs; }
      );

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);
    };
}
