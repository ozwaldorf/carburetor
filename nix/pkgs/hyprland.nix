{ name, ... }:
{ pkgs, fetchFromGitHub, ... }:
pkgs."${name}".tools.mkWhiskersDerivation {
  pname = "hyprland";
  version = "1.3-unstable-2024-06-19";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "hyprland";
    rev = "c388ac55563ddeea0afe9df79d4bfff0096b146b";
    hash = "sha256-xSa/z0Pu+ioZ0gFH9qSo9P94NPkEMovstm1avJ7rvzM=";
  };
}
