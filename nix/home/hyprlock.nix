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
    xdg.configFile."hypr/hyprlock.conf".source =
      pkgs.${name}.hyprlock.override { inherit (config.${name}.config) variant accent; }
      + "/hyprlock.conf";
  };
}
