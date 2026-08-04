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
    rev = "ed42b541c0070d6deb3bf16de2d983aaccec9480";
    hash = "sha256-PDP4d+IaE8iYv3HnFuVScDt1iPe7qIepppwSgcm6iTY=";
  };
in
stdenvNoCC.mkDerivation {
  inherit src;
  name = "${name}-hyprlock";
  version = "0-unstable-2026-06-28";
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
