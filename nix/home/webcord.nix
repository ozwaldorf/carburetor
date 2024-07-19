name:
{
  pkgs,
  config,
  lib,
  ...
}:
{
  options."${name}".webcord.enable = lib.mkEnableOption "installing ${name} for webcord";
  config = lib.mkIf config."${name}".webcord.enable (
    let
      suffix =
        {
          regular = "";
          warm = "-warm";
          cool = "-cool";
        }
        ."${config."${name}".variant}";
    in
    {
      xdg.configFile."WebCord/Themes/${name}${suffix}".source =
        pkgs."${name}-discord" + "/${name}${suffix}.css";
    }
  );
}
