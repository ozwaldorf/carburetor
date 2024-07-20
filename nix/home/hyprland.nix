{ name, ... }:
{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.${name}.themes.hyprland.enable = lib.mkEnableOption "installing ${name} for hyprland";
  config = lib.mkIf config.${name}.themes.hyprland.enable {
    xdg.configFile."hypr" = {
      source = pkgs.${name}.hyprland;
      recursive = true;
    };
  };
}
