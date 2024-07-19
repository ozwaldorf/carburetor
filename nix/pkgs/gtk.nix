{
  pkgs,
  variant ? "regular",
  accents ? [ "blue" ],
  transparent ? true,
  ...
}:
let
  flavor =
    {
      regular = "mocha";
      warm = "macchiato";
      cool = "frappe";
    }
    ."${variant}";
in
pkgs.stdenv.mkDerivation {
  name = "carburetor-gtk";
  src =
    (pkgs.catppuccin-gtk.override {
      inherit accents;
      variant = flavor;
    }).out;
  nativeBuildInputs = [ pkgs.lib.carburetor.patch ];
  installPhase = ''
    carburetor-patch ${flavor} ${pkgs.lib.trivial.boolToString transparent} .
    mkdir -p $out/share/themes
    cp -R share/themes/catppuccin-*-standard $out/share/themes/carburetor
    cp -R share/themes/catppuccin-*-standard-hdpi $out/share/themes/carburetor-hdpi
    cp -R share/themes/catppuccin-*-standard-xhdpi $out/share/themes/carburetor-xhdpi
  '';
}
