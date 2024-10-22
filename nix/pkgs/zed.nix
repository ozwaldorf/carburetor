{ name, ... }:
{ pkgs, fetchFromGitHub, ... }:
pkgs."${name}".tools.mkWhiskersDerivation {
  pname = "zed";
  version = "0.2.11-unstable-2024-09-09";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "zed";
    rev = "ba6aa143158585ca92294cf994ac8cfbe74b56c7";
    hash = "sha256-T+f/sM5BYz+hLc3RVVhn38C+Sfr0XHtsRWzTd5JPVTI=";
  };
  patches = [
    (pkgs.writeText "current_line.patch" ''
      --- a/zed.tera
      +++ b/zed.tera
      @@ -79,3 +79,3 @@ whiskers:
                       "editor.subheader.background": "#{{c.mantle.hex}}",
      -                "editor.active_line.background": "#{{ c.text | mod(opacity=0.05) | get(key="hex") }}",
      +                "editor.active_line.background": "#{{ c.text | mod(opacity=0.02) | get(key="hex") }}",
                       "editor.highlighted_line.background": null,
    '')
  ];
}
