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
pkgs.stdenvNoCC.mkDerivation {
  name = "carburetor-papirus-folders";
  src = (pkgs.catppuccin-papirus-folders.override { inherit flavor accent; }).out;
  nativeBuildInputs = with pkgs; [ carburetor-patch ];
  installPhase = ''
    carburetor-patch ${flavor} false share/icons
    mkdir -p $out/share
    cp -R share/icons $out/share
  '';
}
