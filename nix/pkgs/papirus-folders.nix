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
  inherit (pkgs."${name}") tools;
  flavor = tools.toFlavor variant;
in
stdenvNoCC.mkDerivation {
  name = "${name}-papirus-folders";
  src = (catppuccin-papirus-folders.override { inherit flavor accent; }).out;
  nativeBuildInputs = [ tools.patch ];
  patchPhase = ''
    ${name}-patch ${flavor} false share/icons
  '';
  installPhase = ''
    mkdir -p $out/share
    cp -R share/icons $out/share
  '';
}
