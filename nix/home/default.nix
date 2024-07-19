name:
{ lib, ... }:
{
  imports = [
    (import ./webcord.nix name)
    (import ./wezterm.nix name)
    (import ./zed.nix name)
  ];

  options = {
    ${name} = {
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
