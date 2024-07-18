{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.carburetor.webcord.enable = lib.mkEnableOption "installing carburetor for webcord";
  config = lib.mkIf config.carburetor.webcord.enable (
    let
      suffix =
        {
          regular = "";
          warm = "-warm";
          cool = "-cool";
        }
        ."${config.carburetor.variant}";
    in
    {
      xdg.configFile."WebCord/Themes/carburetor${suffix}".source =
        pkgs.carburetor-discord + "/carburetor${suffix}.css";
    }
  );
}
