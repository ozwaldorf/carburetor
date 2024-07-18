{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.carburetor.webcord.enable = lib.mkEnableOption "carburetor";
  config = lib.mkIf config.carburetor.webcord.enable {
    xdg.configFile."WebCord/Themes/carburetor".source =
      pkgs.carburetor-webcord
      + "/carburetor"
      + (
        {
          regular = "";
          warm = "-warm";
          cool = "-cool";
        }
        ."${config.carburetor.variant}"
      )
      + ".css";
  };
}
