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
  #       defaultAccent = "mauve";
  #       whiskersJson = ./path/to/whiskers.json;
  #     })
  #   ];
  # }
  # ```
  mkCustomThemeOverlay = args: import ./pkgs args;

  # Create a custom home manager module to install themes with.
  # Must be paired with `mkCustomThemeOverlay`, using identical input,
  # for the packages to be accessable.
  #
  # ```nix
  # imports = [
  #   (inputs.carburetor.lib.mkCustomHomeManagerModule {
  #     name = "foo-theme";
  #     variantNames = {
  #       mocha = "darker";
  #       macchiato = "dark";
  #       frappe = "medium";
  #       latte = "light";
  #     };
  #     defaultAccent = "mauve";
  #     whiskersJson = ./path/to/whiskers.json;
  #   })
  # ];
  #
  # foo-theme = {
  #   config.variant = "darker"
  #   themes = {
  #     wezterm.enable = true;
  #     zed.enable = true;
  #   };
  # };
  # ```
  mkCustomHomeManagerModule = args: import ./home/default.nix args;

  mkDocs = homeModule: pkgs: import ./docs.nix homeModule pkgs;
}
