{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.carburetor.webcord;
in
{
  options.carburetor.webcord = {
    enable = lib.mkEnableOption "carburetor";
    variant = lib.mkOption {
      type = with lib.types; uniq str;
      default = "regular";
      description = ''Variant to install. Options: "regular", "warm", or "cool"'';
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."WebCord/Themes/carburetor".source =
      pkgs.carburetor-webcord
      + "/carburetor"
      + (
        {
          regular = "";
          warm = "-warm";
          cool = "-cool";
        }
        ."${cfg.variant}"
      )
      + ".css";
  };
}
