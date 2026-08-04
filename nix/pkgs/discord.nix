{ name, variantNames, ... }:
{
  pkgs,
  stdenvNoCC,
  fetchFromGitHub,
  fetchurl,
  dart-sass,

  transparency ? false,
  ...
}:
let
  palette = fetchurl {
    url = "https://registry.yarnpkg.com/@catppuccin/palette/-/palette-1.7.1.tgz";
    hash = "sha256-P+v8jjt+Lww94n4n9zHVbn8XPpF+hXBFit0qBU7GScQ=";
  };
  highlightjs = fetchurl {
    url = "https://registry.yarnpkg.com/@catppuccin/highlightjs/-/highlightjs-1.0.1.tgz";
    hash = "sha256-sTq0vlb+3s4bbpEV0GCFHnnogI2EaQRk9Gqum1G+AMM=";
  };
in
stdenvNoCC.mkDerivation {
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "discord";
    rev = "70acffa079429bc4a0290d6699b66471c3ec4fd3";
    hash = "sha256-oyVZxdr4UacRMOCDdjSl2B/X5ySYTOD5iCOq0MLSxD4=";
  };
  name = "${name}-discord";
  version = "0-unstable-2024-10-02";
  nativeBuildInputs = [
    dart-sass
    pkgs.${name}.tools.patch
  ];
  buildPhase = ''
    mkdir -p node_modules/@catppuccin/{palette,highlightjs}
    tar xf ${palette} -C node_modules/@catppuccin/palette --strip-components=1
    tar xf ${highlightjs} -C node_modules/@catppuccin/highlightjs --strip-components=1
    chmod -R u+w node_modules

    ${name}-patch all ${pkgs.lib.trivial.boolToString transparency} node_modules/@catppuccin/palette

    mkdir -p dist/dist
    sass -I node_modules --no-charset --no-source-map src:dist/dist

    # Replace name and variant texts
    find . -type f -exec sed -i \
      -e 's:catppuccin/discord:ozwaldorf/carburetor:g' \
      -e 's:soothing pastel theme:Carburetor theme:gI' \
      -e 's/catppuccin/${name}/gI' \
      -e 's/mocha/${variantNames.mocha}/gI' \
      -e 's/macchiato/${variantNames.macchiato}/gI' \
      -e 's/é/e/g' \
      -e 's/frappe/${variantNames.frappe}/gI' \
      -e 's/latte/${variantNames.latte}/gI' \
      {} \;
  '';
  installPhase = ''
    mkdir $out
    cp dist/dist/catppuccin-mocha.theme.css $out/${name}-${variantNames.mocha}.css
    cp dist/dist/catppuccin-macchiato.theme.css $out/${name}-${variantNames.macchiato}.css
    cp dist/dist/catppuccin-frappe.theme.css $out/${name}-${variantNames.frappe}.css
    cp dist/dist/catppuccin-latte.theme.css $out/${name}-${variantNames.latte}.css
  '';
}
