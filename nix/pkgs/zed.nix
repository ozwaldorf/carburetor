{ name, ... }:
{ pkgs, fetchFromGitHub, ... }:
pkgs."${name}".tools.mkWhiskersDerivation {
  pname = "zed";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "zed";
    rev = "6ac674645711195d90f02876e74c79256848ff22";
    hash = "sha256-jOHCO4wBqm2oNwVSJ3S9npKE5Gsen6ai9TZd9IMuevc=";
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
