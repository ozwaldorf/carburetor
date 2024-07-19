{
  # Create a custom overlay for a theme.
  #
  # ```nix
  # pkgs = import nixpkgs {
  #   inherit system;
  #   overlays = [
  #     (inputs.carburetor.lib.mkCustomThemeOverlay {
  #       name = "foo-theme";
  #       variantNames = {
  #         mocha = "darker";
  #         macchiato = "dark";
  #         frappe = "medium";
  #         latte = "light";
  #       };
  #       whiskersJson = ./path/to/whiskers.json;
  #     })
  #   ];
  # }
  # ```
  mkCustomThemeOverlay = args: (import ./pkgs args);

  # Create a custom home manager module to install themes with.
  # Must be paired with `mkCustomThemeOverlay` for the packages to be available.
  #
  # ```nix
  # imports = [ (inputs.carburetor.lib.mkCustomHomeManagerModule "foo-theme") ];
  #
  # foo-theme = {
  #   wezterm.enable = true;
  #   zed.enable = true;
  # };
  # ```
  mkCustomHomeManagerModule = name: (import ./home/default.nix) name;
}
