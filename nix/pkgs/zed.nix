{ name, ... }:
{ pkgs, fetchFromGitHub, ... }:
pkgs."${name}".tools.mkWhiskersDerivation {
  pname = "zed";
  version = "0.2.25-unstable-2026-01-23";
  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "zed";
    rev = "b54cb81708d06912d50e6bb9fd2fd2103b9dda25";
    hash = "sha256-+SO9W98LQbG6Oz5YStzdgYpVgT77pGZHaTsH3HhZr60=";
  };
  patches = [
    (pkgs.writeText "current_line.patch" ''
      --- a/zed.tera
      +++ b/zed.tera
      @@ -108,3 +108,3 @@ whiskers:
                       "editor.subheader.background": "{{ c.mantle.hex }}",
      -                "editor.active_line.background": "{{ c.text | mod(opacity=0.07) | get(key="hex") }}",
      +                "editor.active_line.background": "{{ c.text | mod(opacity=0.02) | get(key="hex") }}",
                       "editor.highlighted_line.background": null,
    '')
  ];
}
