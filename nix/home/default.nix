{ lib, ... }:
{
  imports = [
    ./webcord.nix
    ./wezterm.nix
    ./zed.nix
  ];

  options = {
    carburetor = {
      accent = lib.mkOption {
        type = with lib.types; uniq str;
        default = "blue";
        description = "Global accent color to use. Any catppuccin accent is valid";
      };
      variant = lib.mkOption {
        type = with lib.types; uniq str;
        default = "regular";
        description = "Global variant to use. Values: regular, warm, cool";
      };
    };
  };
}
