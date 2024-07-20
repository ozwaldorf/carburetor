{
  name,
  variantNames,
  defaultAccent,
  ...
}:
{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.${name}.themes.gtk = {
    enable = lib.mkEnableOption "installing and configuring gtk themes";
    icon = lib.mkEnableOption "installing patched papirus icons";
    gnomeShellTheme = lib.mkEnableOption "installing gtk theme for GNOME Shell";
    size = lib.mkOption {
      type = lib.types.enum [
        "standard"
        "compact"
      ];
      default = "standard";
      description = "Size variant for gtk";
    };
    tweaks = lib.mkOption {
      type = lib.types.listOf (
        lib.types.enum [
          "black"
          "rimless"
          "normal"
          "float"
        ]
      );
      default = [ ];
      description = "Tweaks for gtk";
    };

  };

  config =
    let
      cfg = config.${name}.themes.gtk;
      options = config.${name}.config;
    in
    lib.mkMerge [
      # Configure gtk theme
      (lib.mkIf cfg.enable {
        gtk.theme = {
          name = "${name}-${options.variant}-${options.accent}-${cfg.size}+${lib.concatStringsSep "," cfg.tweaks}";
          package = pkgs.catppuccin-gtk.override {
            inherit (cfg) size tweaks;
            accents = [ options.accent ];
            variant = options.flavor;
          };
        };
      })

      # Configure icon theme
      (lib.mkIf cfg.icon {
        gtk.iconTheme =
          let
            # use the light icon theme for latte variants
            polarity = if options.variant == variantNames.latte then "Light" else "Dark";
          in
          {
            name = "Papirus-${polarity}";
            package = pkgs.catppuccin-papirus-folders.override { inherit (cfg.icon) accent flavor; };
          };
      })

      # Configure gnome shell theme
      (lib.mkIf cfg.gnomeShellTheme {
        home.packages = [ pkgs.gnomeExtensions.user-themes ];

        dconf.settings = {
          "org/gnome/shell" = {
            disable-user-extensions = false;
            enabled-extensions = [ "user-theme@gnome-shell-extensions.gcampax.github.com" ];
          };
          "org/gnome/shell/extensions/user-theme" = {
            inherit (config.gtk.theme) name;
          };
          "org/gnome/desktop/interface" = {
            color-scheme = if options.variant == variantNames.latte then "default" else "prefer-dark";
          };
        };
      })
    ];
}
