{ name, ... }:
{ pkgs, fetchFromGitHub, ... }:
pkgs."${name}".tools.mkWhiskersDerivation {
  pname = "zed";
  version = "0.2.24-unstable-2025-11-10";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "zed";
    rev = "471eb7e5a432f694c272ee8b17ba56c05c6a99b0";
    hash = "sha256-/sIx1WoYNsP+D/kla0x09e0z6kqpLyskp1f9eH1aNAU=";
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
