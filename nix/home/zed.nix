{ name, ... }:
{
  config,
  pkgs,
  lib,
  ...
}:
{
  options."${name}".themes.zed.enable = lib.mkEnableOption "installing ${name} themes to zed";
  config = lib.mkIf config."${name}".themes.zed.enable {
    xdg.configFile = {
      "zed" = {
        source = pkgs."${name}-zed";
        recursive = true;
      };
    };
  };
}
