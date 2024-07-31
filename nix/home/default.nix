args@{
  name,
  variantNames,
  defaultAccent,
  ...
}:
{ lib, ... }:
{
  imports = [
    (import ./gtk.nix args)
    (import ./hyprland.nix args)
    (import ./hyprlock.nix args)
    (import ./webcord.nix args)
    (import ./wezterm.nix args)
    (import ./vesktop.nix args)
    (import ./zed.nix args)
  ];

  options.${name}.config = {
    variant = lib.mkOption {
      description = "Theme variant to use";
      type = lib.types.enum (builtins.attrValues variantNames);
      default = variantNames.mocha;
    };
    accent = lib.mkOption {
      description = "Theme accent color to use";
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
    };
  };
}
