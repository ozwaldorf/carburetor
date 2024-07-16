{
  pkgs,
  variant ? "regular",
  accent ? "blue",
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
  name = "carburetor-papirus-folders";
  src = [
    (builtins.path {
      name = "src";
      path = (pkgs.catppuccin-papirus-folders.override { inherit flavor accent; }).out;
    })
    ../patch.sh
  ];
  unpackPhase = ''
    for srcFile in $src; do
      local tgt=$(echo $srcFile | cut --delimiter=- --fields=2-)
      cp $srcFile $tgt -r
      chmod -R ugo+rwx $tgt
    done
  '';
  installPhase = ''
    patchShebangs ./patch.sh
    ./patch.sh ${flavor} false src
    ls src/share/icons
    mkdir -p $out/share
    cp -R src/share/icons $out/share
  '';
}
