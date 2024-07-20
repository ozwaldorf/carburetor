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
}@extraArgs:
let
  inherit (pkgs."${name}") tools;
  flavor = tools.toFlavor variant;
in
stdenvNoCC.mkDerivation {
  name = "${name}-gtk";
  src =
    (
      catppuccin-gtk.override {
        inherit accents;
        variant = flavor;
      }
      // extraArgs
    ).out;
  nativeBuildInputs = [ tools.patch ];
  patchPhase = ''
    ${name}-patch ${flavor} ${pkgs.lib.trivial.boolToString transparent} share/themes
    ls share/themes | while read output; do
      RENAME=''${output/catppuccin/${name}}
      RENAME=''${RENAME/mocha/${variantNames.mocha}}
      RENAME=''${RENAME/macchiato/${variantNames.macchiato}}
      RENAME=''${RENAME/frappe/${variantNames.frappe}}
      RENAME=''${RENAME/latte/${variantNames.latte}}
      if [ "$output" != "$RENAME" ]; then
        mv -v share/themes/$output share/themes/$RENAME
      fi
    done
  '';
  installPhase = ''
    mkdir -p $out
    cp -R share $out
  '';
}
