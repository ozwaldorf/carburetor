{
  description = "Overlay and modules for carburetor themes";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
    }:
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
        docs = import ./nix/docs.nix pkgs;
      });
      homeManagerModules = {
        webcord = import ./nix/home/webcord.nix;
        wezterm = import ./nix/home/wezterm.nix;
        default = import ./nix/home;
      };
    };
}
