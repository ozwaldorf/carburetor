{ name, ... }:
{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.${name}.themes.foot;
  options = config.${name}.config;
in
{
  options.${name}.themes.vicinae.enable = lib.mkEnableOption "installing ${name} for vicinae";
  config = lib.mkIf cfg.enable {
    services.vicinae.themes.carburetor = {
      version = "1.0";
      appearance = "dark";
      # icon = /path/to/icon.png;
      name = "carburetor";
      description = "High contrast theme based on IBM Carbon";
      palette = {
        background = "#161616";
        foreground = "#f4f4f4";
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
