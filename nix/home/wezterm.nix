{ config, lib, ... }:
let
  cfg = config.carburetor.wezterm;
in
{
  options.carburetor.wezterm = {
    enable = lib.mkEnableOption "installing carburetor themes to wezterm";
    colorsDir = lib.mkOption {
      type = with lib.types; uniq str;
      default = "wezterm/colors";
      description = "Directory to install color theme files to";
    };
  };

  config = lib.mkIf cfg.enable { xdg.configFile."${cfg.colorsDir}".source = ../../src/wezterm; };
}
