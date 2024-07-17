self:
{ lib, config, ... }:
{
  options = {
    carburetor = {
      enable = lib.mkEnableOption "all themes";
      accent = lib.mkOption {
        type = with lib.types; uniq str;
        default = "blue";
        description = "Global accent color to use. Any catppuccin accent is valid";
      };
      variant = lib.mkOption {
        type = with lib.types; uniq str;
        default = "regular";
        description = "Global variant to use (regular, warm, or cool)";
      };
    };
  };
  imports = [
    ./webcord.nix
    ./wezterm.nix
  ];
  config = lib.mkIf config.carburetor.enable {
    programs.webcord.carburetor = {
      inherit (config.carburetor) accent variant;
      enable = true;
    };
    programs.wezterm.carburetor.enable = true;
  };
}
