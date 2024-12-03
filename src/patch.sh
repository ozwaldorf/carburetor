#!/usr/bin/env bash
flavor=$1
transparent=$2
path=$3
if [[ -z "$flavor" || -z "$transparent" || -z "$path" ]]; then
  echo "Usage: $0 <all|mocha|macchiato|frappe> <true|false> <source dir>"
  exit 1
fi

patch () {
  echo "Patching $flavor colors with carburetor $1"

  ARGS=()
  for r in "${COLORS[@]}"; do
    ARGS+=("-e s/$r/Ig")
  done

  # shellcheck disable=SC20.7
  find "$path" -type f -exec sed -i ${ARGS[@]} {} +
}

case "$flavor" in
  all)
    $0 mocha "$2" "$3"
    $0 macchiato "$2" "$3"
    $0 frappe "$2" "$3"
    ;;

  mocha)
    # Carburetor
    export COLORS=(
      "#f5e0dc/#fed7d9"
      "#f2cdcd/#ffb3b8"
      "#f5c2e7/#ff7eb6"
      "#cba6f7/#d4bbff"
      "#f38ba8/#fa4d56"
      "#eba0ac/#ff8389"
      "#fab387/#fe832b"
      "#f9e2af/#fddc69"
      "#a6e3a1/#42be65"
      "#94e2d5/#3ddbd9"
      "#89dceb/#82cffe"
      "#74c7ec/#78a9ff"
      "#89b4fa/#4589ff"
      "#b4befe/#be95ff"
      "#cdd6f4/#f4f4f4"
      "#bac2de/#e0e0e0"
      "#a6adc8/#c6c6c6"
      "#9399b2/#a8a8a8"
      "#7f849c/#8d8d8d"
      "#6c7086/#6f6f6f"
    )
    if [ "$transparent" != "true" ]; then
      COLORS+=(
        "#585b70/#525252"
        "#45475a/#393939"
        "#313244/#262626"
        "#1e1e2e/#161616"
        "#181825/#0b0b0b"
        "#11111b/#000000"
      )
    else
      COLORS+=(
        "#585b70/rgba(82,82,82,0.70)"
        "#45475a/rgba(57,57,57,0.70)"
        "#313244/rgba(38,38,38,0.70)"
        "#1e1e2e/rgba(22,22,22,0.70)"
        "#181825/rgba(11,11,11,0.70)"
        "#11111b/rgba(0,0,0,0.70)"
      )
    fi
    patch;;

  # Carburetor Cool
  macchiato)
    export COLORS=(
      "#f4dbd6/#fed7d9"
      "#f0c6c6/#ffb3b8"
      "#f5bde6/#ff7eb6"
      "#c6a0f6/#d4bbff"
      "#ed8796/#fa4d56"
      "#ee99a0/#ff8389"
      "#f5a97f/#fe832b"
      "#eed49f/#fddc69"
      "#a6da95/#42be65"
      "#8bd5ca/#3ddbd9"
      "#91d7e3/#82cffe"
      "#7dc4e4/#78a9ff"
      "#8aadf4/#4589ff"
      "#b7bdf8/#be95ff"
      "#cad3f5/#f2f4f8"
      "#b8c0e0/#dde1e6"
      "#a5adcb/#c1c7cd"
      "#939ab7/#a2a9b0"
      "#8087a2/#878d96"
      "#6e738d/#697077"
    )
    if [ "$transparent" != "true" ]; then
      COLORS+=(
        "#5b60.7/#4d5358"
        "#494d64/#343a3f"
        "#363a4f/#21272a"
        "#24273a/#121619"
        "#1e2030/#090b0c"
        "#181926/#000000"
      )
    else
      COLORS+=(
        "#626880/rgba(77,83,88,0.70)"
        "#51576d/rgba(52,58,63,0.70)"
        "#414559/rgba(33,39,42,0.70)"
        "#303446/rgba(18,22,25,0.70)"
        "#292c3c/rgba(9,11,12,0.70)"
        "#232634/rgba(0,0,0,0.70)"
      )
    fi
    patch;;

  # Carburetor Warm
  frappe)
    export COLORS=(
      "#f2d5cf/#fed7d9"
      "#eebebe/#ffb3b8"
      "#f4b8e4/#ff7eb6"
      "#ca9ee6/#d4bbff"
      "#e78284/#fa4d56"
      "#ea999c/#ff8389"
      "#ef9f76/#fe832b"
      "#e5c890/#fddc69"
      "#a6d189/#42be65"
      "#81c8be/#3ddbd9"
      "#99d1db/#82cffe"
      "#85c1dc/#78a9ff"
      "#8caaee/#4589ff"
      "#babbf1/#be95ff"
      "#c6d0f5/#f7f3f2"
      "#b5bfe2/#e5e0df"
      "#a5adce/#cac5c4"
      "#949cbb/#ada8a8"
      "#838ba7/#8f8b8b"
      "#737994/#726e6e"
    )
    if [ "$transparent" != "true"  ]; then
      COLORS+=(
        "#626880/#565151"
        "#51576d/#3c3838"
        "#414559/#272525"
        "#303446/#171414"
        "#292c3c/#0b0a0a"
        "#232634/#000000"
      )
    else
      COLORS+=(
        "#626880/rgba(86,81,81,0.70)"
        "#51576d/rgba(60,56,56,0.70)"
        "#414559/rgba(39,37,37,0.70)"
        "#303446/rgba(23,20,20,0.70)"
        "#292c3c/rgba(11,10,10,0.70)"
        "#232634/rgba(0,0,0,0.70)"
      )
    fi
    patch;;

  *)
    echo "invalid flavor argument $flavor"
    ;;
esac
