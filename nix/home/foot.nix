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
  options.${name}.themes.foot.enable = lib.mkEnableOption "installing ${name} for hyprland";
  config = lib.mkIf cfg.enable {
    programs.foot.settings.main.include = pkgs.${name}.foot + "/themes/${name}-${options.variant}.ini";
  };
}
