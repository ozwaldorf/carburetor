{
  name,
  variantNames,
  defaultAccent,
  ...
}:
{
  pkgs,
  lib,
  stdenvNoCC,
  catppuccin-papirus-folders,
  variant ? variantNames.mocha,
  accent ? defaultAccent,
  ...
}:
let
  flavor =
    {
      "${variantNames.mocha}" = "mocha";
      "${variantNames.macchiato}" = "macchiato";
      "${variantNames.frappe}" = "frappe";
      "${variantNames.latte}" = "latte";
    }
    ."${variant}";
in
stdenvNoCC.mkDerivation {
  name = "${name}-papirus-folders";
  src = (catppuccin-papirus-folders.override { inherit flavor accent; }).out;
  nativeBuildInputs = [ pkgs."${name}".tools.patch ];
  patchPhase = ''
    ${name}-patch ${flavor} false share/icons
  '';
  installPhase = ''
    mkdir -p $out/share
    cp -R share/icons $out/share
  '';
}
