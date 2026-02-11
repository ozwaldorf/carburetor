{ name, ... }:
{ pkgs, fetchFromGitHub, ... }:
pkgs."${name}".tools.mkWhiskersDerivation {
  pname = "termux";
  version = "0-unstable-2024-07-20";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "termux";
    rev = "c3eefc676552720c0ad624cb576cdb6864d6c5f6";
    hash = "sha256-w9cLOul59sBVKG7lGLhaD056Cso46Ip0R92eryxzVPg=";
  };
}
