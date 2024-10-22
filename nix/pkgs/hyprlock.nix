{
  name,
  variantNames,
  defaultAccent,
  ...
}:
{
  pkgs,
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  fetchurl,
  variant ? variantNames.mocha,
  accent ? defaultAccent,
  avatarPng ? fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png";
    hash = "sha256-A85wBdJ2StkgODmxtNGfbNq8PU3G3kqnBAwWvQXVtqo=";
  },
  backgroundPng ? "",
  ...
}:
let
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "hyprlock";
    rev = "958e70b1cd8799defd16dee070d07f977d4fd76b";
    hash = "sha256-l4CbAUeb/Tg603QnZ/VWxuGqRBztpHN0HLX/h8ndc5w=";
  };
in
stdenvNoCC.mkDerivation {
  inherit src;
  name = "${name}-hyprlock";
  version = "0-unstable-2024-08-06";
  patchPhase = ''
    sed -i \
      -e 's:mocha:${variant}:Ig' \
      -e 's:~/.face:${avatarPng}:Ig' \
      -e 's:~/.config/background:${backgroundPng}:Ig' \
      hyprlock.conf
  '';
  installPhase = ''
    mkdir -p $out
    cp hyprlock.conf $out
  '';
}
