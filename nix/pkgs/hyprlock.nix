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
    rev = "480c46f1f3fa9dd175f8f9611c0d4378324378a7";
    hash = "sha256-Fisxyg5Q5C3dlZdIpgVDEpOUJYrqRMT6HJ+46XUVwI0=";
  };
in
stdenvNoCC.mkDerivation {
  inherit src;
  name = "${name}-hyprlock";
  version = "0-unstable-2024-06-17";
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
