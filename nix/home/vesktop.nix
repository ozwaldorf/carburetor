{ name, ... }:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.${name}.themes.vesktop;
in
{
  options.${name}.themes.vesktop = {
    enable = lib.mkEnableOption "installing ${name} themes for vesktop";
    transparency = lib.mkEnableOption "transparency in background colors";
  };
  config = lib.mkIf cfg.enable {
    xdg.configFile."vesktop/themes" = {
      source = pkgs.${name}.discord.override { inherit (cfg) transparency; };
      recursive = true;
    };
  };
}
