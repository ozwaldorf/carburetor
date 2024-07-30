{ name, ... }:
{ pkgs, fetchFromGitHub, ... }:
pkgs."${name}".tools.mkWhiskersDerivation {
  pname = "zed";
  version = "0.2.10-unstable-2024-07-28";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "zed";
    rev = "b7de18fb6748312e6c5eaf6995e2759ae3c29455";
    hash = "sha256-r+0b1TOccCDT9Xzopy8tGB2hTQRL0yX+ZcYlBHC/Big=";
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
