{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.carburetor.zed.enable = lib.mkEnableOption "installing carburetor themes to zed";
  config = lib.mkIf config.carburetor.zed.enable {
    xdg.configFile."zed/themes".source = pkgs.carburetor-zed + "/themes";
  };
}
