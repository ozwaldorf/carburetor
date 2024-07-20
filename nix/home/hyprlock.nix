{ name, ... }:
{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.${name}.themes.hyprlock.enable = lib.mkEnableOption "installing ${name} for hyprlock";
  config = lib.mkIf config.${name}.themes.hyprlock.enable {
    xdg.configFile."hypr" = {
      source = pkgs.${name}.hyprlock.override { inherit (config.${name}.config) variant accent; };
      recursive = true;
    };
  };
}
