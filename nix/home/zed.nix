name:
{
  config,
  pkgs,
  lib,
  ...
}:
{
  options."${name}".zed.enable = lib.mkEnableOption "installing ${name} themes to zed";
  config = lib.mkIf config."${name}".zed.enable {
    xdg.configFile = {
      "zed" = {
        source = pkgs."${name}-zed";
        recursive = true;
      };
    };
  };
}
