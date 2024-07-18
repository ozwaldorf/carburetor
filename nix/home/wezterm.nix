self:
{ config, lib, ... }:
let
  cfg = config.programs.wezterm;
in
{
  options = {
    programs.wezterm.carburetor = {
      enable = lib.mkEnableOption "installing carburetor themes to wezterm";
      colorsDir = lib.mkOption {
        type = with lib.types; uniq str;
        default = "wezterm/colors";
        description = "Directory to install color theme files to";
      };
    };
  };

  config = lib.mkIf cfg.carburetor.enable {
    xdg.configFile."${cfg.carburetor.colorsDir}".source = ../../src/wezterm;
  };
}
