{ config, lib, ... }:
{
  options.carburetor.wezterm.enable = lib.mkEnableOption "installing carburetor themes to wezterm";
  config = lib.mkIf config.carburetor.wezterm.enable {
    xdg.configFile."wezterm/colors/carburetor.toml".source = ../../src/wezterm/carburetor.toml;
    xdg.configFile."wezterm/colors/carburetor-cool.toml".source = ../../src/wezterm/carburetor-warm.toml;
    xdg.configFile."wezterm/colors/carburetor-warm.toml".source = ../../src/wezterm/carburetor-warm.toml;
  };
}
