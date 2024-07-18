{ config, lib, ... }:
{
  options.carburetor.wezterm.enable = lib.mkEnableOption "installing carburetor themes to wezterm";
  config = lib.mkIf config.carburetor.wezterm.enable {
    xdg.configFile."wezterm/colors".source = ../../src/wezterm;
  };
}
