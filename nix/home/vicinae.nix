{ name, variantNames, whiskersJson, ... }:
{
  config,
  lib,
  options,
  ...
}:
let
  cfg = config.${name}.themes.vicinae;
  userConfig = config.${name}.config;
  palettes = builtins.fromJSON (builtins.readFile whiskersJson);
  themeName =
    variant:
    if variantNames.${variant} == "regular" then name else "${name}-${variantNames.${variant}}";
  mkTheme =
    variant: p:
    let
      hex = c: "#${p.${c}}";
    in
    {
      meta = {
        version = 1;
        name = themeName variant;
        description = "${name} ${variantNames.${variant}}";
        variant = "dark";
      };
      colors = {
        core = {
          background = hex "base";
          foreground = hex "text";
          secondary_background = hex "surface0";
          border = hex "surface1";
          accent = hex userConfig.accent;
        };
        accents = {
          blue = hex "blue";
          green = hex "green";
          magenta = hex "pink";
          orange = hex "peach";
          purple = hex "mauve";
          red = hex "red";
          yellow = hex "yellow";
          cyan = hex "teal";
        };
      };
    };
  theme = {
    settings.theme.dark.name = if userConfig.variant == "regular" then name else "${name}-${userConfig.variant}";
    themes = lib.mapAttrs' (v: p: lib.nameValuePair (themeName v) (mkTheme v p)) palettes;
  };
in
{
  options.${name}.themes.vicinae.enable = lib.mkEnableOption "installing ${name} for vicinae";
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (lib.optionalAttrs (options ? services.vicinae) { services.vicinae = theme; })
      (lib.optionalAttrs (options ? programs.vicinae) { programs.vicinae = theme; })
    ]
  );
}
