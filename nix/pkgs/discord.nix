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
    rev = "c34b767d222ddba4345a858cfdb513fd44e3b0ec";
    hash = "sha256-WQTdLqu9sbu8yJiwZABc4aM9rbLcvNcd0hhGhL3Hjkg=";
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
  nativeBuildInputs = [ yarn ];
  buildPhase = ''
    mkdir node_modules
    find ${deps}/libexec/catppuccin-discord/{,deps/catppuccin-discord/}node_modules -mindepth 1 -maxdepth 1 -exec ln -vs "{}" node_modules/ ';'
    yarn build
  '';
  installPhase = ''
    mkdir $out
    cp dist/dist/catppuccin-mocha.theme.css $out/${name}-${variantNames.mocha}.css
    cp dist/dist/catppuccin-macchiato.theme.css $out/${name}-${variantNames.macchiato}.css
    cp dist/dist/catppuccin-frappe.theme.css $out/${name}-${variantNames.frappe}.css
    cp dist/dist/catppuccin-latte.theme.css $out/${name}-${variantNames.latte}.css
  '';
}
