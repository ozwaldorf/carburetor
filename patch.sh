#!/bin/bash
flavor=$1
path=$2
if [[ -z "$flavor" || -z "$path" ]]; then 
  echo "Usage: $0 <all|mocha|macchiato|frappe> <source dir>"
  exit 1
fi

patch () {
  echo "Patching $flavor colors with carburetor $1"

  ARGS=()
  for r in "${COLORS[@]}"; do
    ARGS+=("-e s/$r/Ig")
  done

  # shellcheck disable=SC2068
  find "$path" -type f -exec sed -i ${ARGS[@]} {} +
}

case "$flavor" in
  all)
    $0 mocha "$2"
    $0 macchiato "$2"
    $0 frappe "$2"
    ;;

  mocha)
    # Carburetor
    export COLORS=( 
      "#f5e0dc/#ffd7d9"
      "#f2cdcd/#ffb3b8"
      "#f5c2e7/#ff7eb6"
      "#cba6f7/#d4bbff"
      "#f38ba8/#fa4d56"
      "#eba0ac/#ff8389"
      "#fab387/#ff832b"
      "#f9e2af/#fddc69"
      "#a6e3a1/#42be65"
      "#94e2d5/#3ddbd9"
      "#89dceb/#82cfff"
      "#74c7ec/#78a9ff"
      "#89b4fa/#4589ff"
      "#b4befe/#be95ff"
      "#cdd6f4/#ffffff"
      "#bac2de/#f4f4f4"
      "#a6adc8/#e0e0e0"
      "#9399b2/#c6c6c6"
      "#7f849c/#a8a8a8"
      "#6c7086/#8d8d8d"
      "#585b70/#6f6f6f"
      "#45475a/#525252"
      "#313244/#393939"
      "#1e1e2e/#262626"
      "#181825/#161616"
      "#11111b/#000000"
    )
    patch "regular";;

  # Carburetor Cool
  macchiato)
    export COLORS=(
      "#f4dbd6/#ffd7d9"
      "#f0c6c6/#ffb3b8"
      "#f5bde6/#ff7eb6"
      "#c6a0f6/#d4bbff"
      "#ed8796/#fa4d56"
      "#ee99a0/#ff8389"
      "#f5a97f/#ff832b"
      "#eed49f/#fddc69"
      "#a6da95/#42be65"
      "#8bd5ca/#3ddbd9"
      "#91d7e3/#82cfff"
      "#7dc4e4/#78a9ff"
      "#8aadf4/#4589ff"
      "#b7bdf8/#be95ff"
      "#cad3f5/#ffffff"
      "#b8c0e0/#f2f4f8"
      "#a5adcb/#dde1E6"
      "#939ab7/#c1c7cd"
      "#8087a2/#a2a9b0"
      "#6e738d/#878d96"
      "#5b6078/#697077"
      "#494d64/#4d5358"
      "#363a4f/#343a3f"
      "#24273a/#21272a"
      "#1e2030/#121619"
      "#181926/#000000"
    )
    patch "cool";;

  # Carburetor Warm
  frappe)
    export COLORS=(
      "#f2d5cf/#ffd7d9"
      "#eebebe/#ffb3b8"
      "#f4b8e4/#ff7eb6"
      "#ca9ee6/#d4bbff"
      "#e78284/#fa4d56"
      "#ea999c/#ff8389"
      "#ef9f76/#ff832b"
      "#e5c890/#fddc69"
      "#a6d189/#42be65"
      "#81c8be/#3ddbd9"
      "#99d1db/#82cfff"
      "#85c1dc/#78a9ff"
      "#8caaee/#4589ff"
      "#babbf1/#be95ff"
      "#c6d0f5/#ffffff"
      "#b5bfe2/#f7f3f2"
      "#a5adce/#e5e0df"
      "#949cbb/#cac5c4"
      "#838ba7/#ada8a8"
      "#737994/#8f8b8b"
      "#626880/#726e6e"
      "#51576d/#565151"
      "#414559/#3c3838"
      "#303446/#272525"
      "#292c3c/#171414"
      "#232634/#000000"
    )
    patch "warm";;

  *)
    echo "invalid flavor argument $flavor"
    ;;
esac
