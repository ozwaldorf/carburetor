{ name, ... }:
{ pkgs, fetchFromGitHub, ... }:
pkgs."${name}".tools.mkWhiskersDerivation {
  pname = "hyprland";
  version = "2.0.0-unstable-2026-05-25";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "hyprland";
    rev = "9f03f26fc10a00e00ec6b2ac2a41e44d16297548";
    hash = "sha256-jGqBpSQa793phan9PeU2yXMX1nxzYClthQSeTwdqgEQ=";
  };
}
