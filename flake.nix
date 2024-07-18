{
  description = "Overlay and modules for carburetor themes";
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
    in
    {
      overlays.default = import ./nix/pkgs;

      homeManagerModules.default = import ./nix/home;

      packages = forAllSystems (
        pkgs:
        let
          # re-export all packages created in the overlay
          overlayList = builtins.attrNames (self.overlays.default null null);
          overlayPkgs = lib.removeAttrs (lib.attrsets.getAttrs overlayList pkgs) [ "lib" ];
        in
        overlayPkgs // { docs = import ./nix/docs.nix pkgs; }
      );

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);
    };
}
