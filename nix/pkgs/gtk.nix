{
  name,
  variantNames,
  defaultAccent,
  ...
}:
{
  pkgs,
  stdenvNoCC,
  catppuccin-gtk,
  variant ? variantNames.mocha,
  accents ? [ defaultAccent ],
  transparent ? true,
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
  name = "${name}-gtk";
  src =
    (catppuccin-gtk.override {
      inherit accents;
      variant = flavor;
    }).out;
  nativeBuildInputs = [ pkgs."${name}".tools.patch ];
  patchPhase = ''
    ${name}-patch ${flavor} ${pkgs.lib.trivial.boolToString transparent} share/themes
  '';
  installPhase = ''
    mkdir -p $out/share/themes
    cp -R share/themes/catppuccin-*-standard $out/share/themes/${name}
    cp -R share/themes/catppuccin-*-standard-hdpi $out/share/themes/${name}-hdpi
    cp -R share/themes/catppuccin-*-standard-xhdpi $out/share/themes/${name}-xhdpi
  '';
}
