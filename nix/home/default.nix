{ lib, config, ... }:
{
  imports = [
    ./webcord.nix
    ./wezterm.nix
    ./zed.nix
  ];

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

  config = lib.mkIf config.carburetor.enable {
    carburetor.webcord = {
      inherit (config.carburetor) variant;
      enable = true;
    };
    carburetor.wezterm.enable = true;
  };
}
