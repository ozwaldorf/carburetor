{ name, ... }:
{ pkgs, fetchFromGitHub, ... }:
pkgs."${name}".tools.mkWhiskersDerivation {
  pname = "foot";
  version = "0-unstable-2024-09-24";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "foot";
    rev = "962ff1a5b6387bc5419e9788a773a080eea5f1e1";
    hash = "sha256-eVH3BY2fZe0/OjqucM/IZthV8PMsM9XeIijOg8cNE1Y=";
  };
}
