args@{
  name,
  variantNames,
  defaultAccent,
  ...
}:
{ lib, ... }:
{
  imports = [
    (import ./hyprland.nix args)
    (import ./hyprlock.nix args)
    (import ./webcord.nix args)
    (import ./wezterm.nix args)
    (import ./zed.nix args)
  ];

  options = {
    "${name}".config = {
      accent = lib.mkOption {
        type = lib.types.enum [
          "rosewater"
          "flamingo"
          "pink"
          "mauve"
          "red"
          "maroon"
          "peach"
          "yellow"
          "green"
          "teal"
          "sky"
          "sapphire"
          "blue"
          "lavender"
        ];
        default = defaultAccent;
        description = "Global accent color to use. Any catppuccin accent is valid";
      };
      variant = lib.mkOption {
        type = lib.types.enum (builtins.attrValues variantNames);
        default = variantNames.mocha;
        description = "Global variant to use";
      };
    };
  };
}
