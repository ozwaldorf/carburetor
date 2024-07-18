{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.carburetor.webcord.enable = lib.mkEnableOption "installing carburetor for webcord";
  config = lib.mkIf config.carburetor.webcord.enable {
    xdg.configFile."WebCord/Themes/carburetor".source =
      pkgs.carburetor-discord
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
