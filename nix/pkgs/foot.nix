{ name, ... }:
{ pkgs, fetchFromGitHub, ... }:
pkgs."${name}".tools.mkWhiskersDerivation {
  pname = "foot";
  version = "0-unstable-2026-04-25";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "foot";
    rev = "99384a83ee9246cd0a38aeee07d8300367724602";
    hash = "sha256-lFa5EpoLkrZcC80YDHyVOTnwYOCNybznlD80NkgVLYs=";
  };
}
