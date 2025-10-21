{ name, ... }:
{ pkgs, fetchFromGitHub, ... }:
pkgs."${name}".tools.mkWhiskersDerivation {
  pname = "foot";
  version = "0-unstable-2025-07-20";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "foot";
    rev = "8d263e0e6b58a6b9ea507f71e4dbf6870aaf8507";
    hash = "sha256-bpGVDESE6Pr7kaFgfAWJ/5KC9mRPlv2ciYwRr6jcIKs=";
  };
}
