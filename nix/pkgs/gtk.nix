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
  src = [
    (builtins.path {
      name = "src";
      path =
        (pkgs.catppuccin-gtk.override {
          inherit accents;
          variant = flavor;
        }).out;
    })
    ../../patch.sh
  ];
  unpackPhase = ''
    for srcFile in $src; do
      local tgt=$(echo $srcFile | cut --delimiter=- --fields=2-)
      cp $srcFile $tgt -r
      chmod -R ugo+rwx $tgt
    done
  '';
  installPhase = ''
    patchShebangs .
    ./patch.sh ${flavor} ${pkgs.lib.trivial.boolToString transparent} src
    mkdir -p $out/share/themes
    cp -R src/share/themes/catppuccin-*-standard $out/share/themes/carburetor
    cp -R src/share/themes/catppuccin-*-standard-hdpi $out/share/themes/carburetor-hdpi
    cp -R src/share/themes/catppuccin-*-standard-xhdpi $out/share/themes/carburetor-xhdpi
  '';
}
