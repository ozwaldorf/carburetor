{ name, ... }:
{
  config,
  pkgs,
  lib,
  ...
}:
{
  options."${name}".themes.webcord.enable = lib.mkEnableOption "installing ${name} for webcord";
  config = lib.mkIf config."${name}".themes.webcord.enable {
    xdg.configFile."WebCord/Themes/${name}".source =
      pkgs."${name}-discord" + "/${name}-${config."${name}".config.variant}.css";
  };
}
