{ pkgs, ... }:
let
  src = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "discord";
    rev = "c34b767d222ddba4345a858cfdb513fd44e3b0ec";
    hash = "sha256-WQTdLqu9sbu8yJiwZABc4aM9rbLcvNcd0hhGhL3Hjkg=";
  };
  deps = pkgs.mkYarnPackage {
    inherit src;
    name = "catppuccin-discord-modules";
    nativeBuildInputs = [ pkgs.carburetor-patch ];
    postBuild = ''
      carburetor-patch all false node_modules/@catppuccin/palette
    '';
  };
in
pkgs.stdenvNoCC.mkDerivation {
  inherit src;
  name = "carburetor-webcord";
  nativeBuildInputs = [ pkgs.yarn ];
  buildPhase = ''
    mkdir node_modules
    find ${deps}/libexec/catppuccin-discord/{,deps/catppuccin-discord/}node_modules -mindepth 1 -maxdepth 1 -exec ln -vs "{}" node_modules/ ';'
    yarn build
  '';
  installPhase = ''
    mkdir $out
    cp dist/dist/catppuccin-mocha.theme.css $out/carburetor
    cp dist/dist/catppuccin-macchiato.theme.css $out/carburetor-warm
    cp dist/dist/catppuccin-frappe.theme.css $out/carburetor-cool
  '';
}
