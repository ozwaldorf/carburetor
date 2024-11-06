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

      inherit (nixpkgs) lib;
      forSystem =
        system:
        import nixpkgs {
          inherit system;
          overlays = [ carburetorOverlay ];
        };
      forAllSystems = fun: lib.genAttrs lib.systems.flakeExposed (system: fun (forSystem system));
    in
    {
      # Nix library for custom catppuccin themes
      lib = themeLib;
      # Carburetor theme overlay
      overlays = rec {
        default = carburetorOverlay;
        # If experiencing nixpkgs errors, reuse the locked nixpkgs and just insert the package set
        insert =
          final: prev:
          (lib.attrsets.getAttrs (builtins.attrNames (default null null)) (forSystem final.system));
      };
      # Carburetor home manager module
      homeManagerModules.default = carburetorHomeModule;

      packages = forAllSystems (
        pkgs:
        # Export all raw theme packages
        lib.removeAttrs pkgs.carburetor [ "tools" ]
        // {
          # Patch tool
          inherit (pkgs.carburetor.tools) patch;
          # Home module documentation
          docs = themeLib.mkDocs carburetorHomeModule pkgs;
        }
      );

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
                    foot.enable = true;
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

      # `nix develop`
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            carburetor.tools.patch
            nix-update
          ];
        };
      });

      # `nix fmt`
      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);
    };
}
