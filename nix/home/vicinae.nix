{ name, ... }:
{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.${name}.themes.vicinae;
  options = config.${name}.config;
in
{
  options.${name}.themes.vicinae.enable = lib.mkEnableOption "installing ${name} for vicinae";
  config = lib.mkIf cfg.enable (
    lib.genAttrs [ "services" "programs" ] (
      source:
      lib.optionalAttrs (config.${source} ? vicinae) {
        vicinae.themes.carburetor = {
          meta = {
            version = "1.0";
            name = "carburetor";
            description = "High contrast theme based on IBM Carbon";
            variant = "dark";
            # icon = /path/to/icon.png;
            inherits = "vicinae-dark";
          };
          colors = {
            core = {
              background = "#161616";
              foreground = "#f4f4f4";
            };
            accents = {
              blue = "#4589ff";
              green = "#42be65";
              magenta = "#ff7eb6";
              orange = "#ff832b";
              purple = "#be95ff";
              red = "#fa4d56";
              yellow = "#fddc69";
              cyan = "#3ddbd9";
            };
          };
        };
      }
    )
  );
}
