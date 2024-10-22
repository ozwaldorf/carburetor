{ name, variantNames, ... }:
{
  pkgs,
  stdenvNoCC,
  fetchFromGitHub,
  mkYarnPackage,
  yarn,

  transparency ? false,
  ...
}:
let
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "discord";
    rev = "54199949330d69c179c04798b81a755a64828c63";
    hash = "sha256-QdwJk+pSZ2Z6MwZORSmGmMFlbGO3kF9mPxWxxWBCoHo=";
  };
  deps = mkYarnPackage {
    inherit src;
    name = "${name}-discord-modules";
    nativeBuildInputs = [ pkgs."${name}".tools.patch ];
    postBuild = ''
      ${name}-patch all ${pkgs.lib.trivial.boolToString transparency} node_modules/@catppuccin/palette
    '';
  };
in
stdenvNoCC.mkDerivation {
  inherit src;
  name = "${name}-discord";
  version = "0-unstable-2024-10-02";
  nativeBuildInputs = [ yarn ];
  buildPhase = ''
    mkdir node_modules
    find ${deps}/libexec/catppuccin-discord/{,deps/catppuccin-discord/}node_modules -mindepth 1 -maxdepth 1 -exec ln -vs "{}" node_modules/ ';'
    yarn build

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
