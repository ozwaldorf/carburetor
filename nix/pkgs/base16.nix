{ name, ... }:
{ pkgs, fetchFromGitHub, ... }:
pkgs."${name}".tools.mkWhiskersDerivation {
  pname = "base16";
  version = "0-unstable-2024-04-10";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "base16";
    rev = "99aa911b29c9c7972f7e1d868b6242507efd508c";
    hash = "sha256-HHodDRrlcBVWGE3MN0i6UvUn30zY/JFEbgeUpnZG5C0=";
  };
}
