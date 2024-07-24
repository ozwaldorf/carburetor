{ name, ... }:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.${name}.themes.webcord;
  options = config.${name}.config;
in
{
  options.${name}.themes.webcord = {
    enable = lib.mkEnableOption "installing ${name} for webcord";
    transparency = lib.mkEnableOption "transparency in background colors";
  };
  config = lib.mkIf cfg.enable {
    xdg.configFile."WebCord/Themes/${name}".source =
      pkgs.${name}.discord.override { inherit (cfg) transparency; } + "/${name}-${options.variant}.css";
  };
}
