name:
{ config, lib, ... }:
{
  options."${name}".wezterm.enable = lib.mkEnableOption "installing ${name} themes to wezterm";
  config = lib.mkIf config."${name}".wezterm.enable {
    xdg.configFile."wezterm/colors" = {
      source = ../../src/wezterm;
      recursive = true;
    };
  };
}
