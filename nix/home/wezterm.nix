{ name, ... }:
{ config, lib, ... }:
{
  options.${name}.themes.wezterm.enable = lib.mkEnableOption "installing ${name} themes to wezterm";
  config = lib.mkIf config.${name}.themes.wezterm.enable {
    xdg.configFile."wezterm/colors" = {
      source = ../../src/wezterm;
      recursive = true;
    };
  };
}
