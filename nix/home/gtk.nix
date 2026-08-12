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
    enable = lib.mkEnableOption "installing and configuring gtk themes\. Also requires `gtk.enable = true;`";
    transparency = lib.mkEnableOption "transparency in background colors";
    icon = lib.mkEnableOption "installing patched papirus icons";
    gnomeShellTheme = lib.mkEnableOption "installing gtk theme for GNOME Shell";
    size = lib.mkOption {
      description = "Size variant for gtk";
      type = lib.types.enum [
        "standard"
        "compact"
      ];
      default = "standard";
    };
    tweaks = lib.mkOption {
      description = "Tweaks for gtk";
      type = lib.types.listOf (
        lib.types.enum [
          "black"
          "rimless"
          "float"
        ]
      );
      default = [ ];
    };
  };

  config =
    let
      cfg = config.${name}.themes.gtk;
      options = config.${name}.config;
      gtkName = "${name}-${options.variant}-${options.accent}-${cfg.size}${
        if cfg.tweaks != [ ] then "+" + lib.concatStringsSep "," cfg.tweaks else ""
      }";
    in
    lib.mkMerge [
      # Configure gtk theme
      (lib.mkIf cfg.enable {
        gtk.theme = {
          name = gtkName;
          package = pkgs.${name}.gtk.override {
            inherit (cfg) size tweaks transparency;
            inherit (options) variant;
            accents = [ options.accent ];
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
            package = pkgs.${name}.papirus-folders.override { inherit (options) accent variant; };
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
