#!/bin/bash
flavor=$1
path=$2
if [[ -z "$flavor" || -z "$path" ]]; then 
  echo "Usage: $0 <mocha|macchiato|frappe> <source dir>"
  exit 1
fi

patch () {
  echo "patching $flavor colors"
  for index in ${!OLD[*]}; do
    regex="s/${OLD[$index]}/${NEW[$index]}/g"
    echo "$regex" && find "$path" -type f -exec sed -i "$regex" {} +
  done
}

case "$flavor" in
  "mocha")
    export OLD=( 
"#f5e0dc"
"#f2cdcd"
"#f5c2e7"
"#cba6f7"
"#f38ba8"
"#eba0ac"
"#fab387"
"#f9e2af"
"#a6e3a1"
"#94e2d5"
"#89dceb"
"#74c7ec"
"#89b4fa"
"#b4befe"
"#cdd6f4"
"#bac2de"
"#a6adc8"
"#9399b2"
"#7f849c"
"#6c7086"
"#585b70"
"#45475a"
"#313244"
"#1e1e2e"
"#181825"
"#11111b"
    )
    export NEW=(
"#ffd7d9"
"#ffb3b8"
"#ff7eb6"
"#d4bbff"
"#fa4d56"
"#ff8389"
"#ff832b"
"#fddc69"
"#42be65"
"#3ddbd9"
"#82cfff"
"#78a9ff"
"#4589ff"
"#be95ff"
"#ffffff"
"#f4f4f4"
"#e0e0e0"
"#c6c6c6"
"#a8a8a8"
"#8d8d8d"
"#6f6f6f"
"#525252"
"#393939"
"#262626"
"#161616"
"#000000"
    )
    ;;

  macchiato)
    export OLD=(
"#f4dbd6"
"#f0c6c6"
"#f5bde6"
"#c6a0f6"
"#ed8796"
"#ee99a0"
"#f5a97f"
"#eed49f"
"#a6da95"
"#8bd5ca"
"#91d7e3"
"#7dc4e4"
"#8aadf4"
"#b7bdf8"
"#cad3f5"
"#b8c0e0"
"#a5adcb"
"#939ab7"
"#8087a2"
"#6e738d"
"#5b6078"
"#494d64"
"#363a4f"
"#24273a"
"#1e2030"
"#181926"
    ) 
    export NEW=(
"#ffd7d9"
"#ffb3b8"
"#ff7eb6"
"#d4bbff"
"#fa4d56"
"#ff8389"
"#ff832b"
"#fddc69"
"#42be65"
"#3ddbd9"
"#82cfff"
"#78a9ff"
"#4589ff"
"#be95ff"
"#ffffff"
"#f2f4f8"
"#dde1E6"
"#c1c7cd"
"#a2a9b0"
"#878d96"
"#697077"
"#4d5358"
"#343a3f"
"#21272a"
"#121619"
"#000000"
    )
    ;;

  frappe)
    export OLD=(
"#f2d5cf"
"#eebebe"
"#f4b8e4"
"#ca9ee6"
"#e78284"
"#ea999c"
"#ef9f76"
"#e5c890"
"#a6d189"
"#81c8be"
"#99d1db"
"#85c1dc"
"#8caaee"
"#babbf1"
"#c6d0f5"
"#b5bfe2"
"#a5adce"
"#949cbb"
"#838ba7"
"#737994"
"#626880"
"#51576d"
"#414559"
"#303446"
"#292c3c"
"#232634"
    ) 
    export NEW=(
"#ffd7d9"
"#ffb3b8"
"#ff7eb6"
"#d4bbff"
"#fa4d56"
"#ff8389"
"#ff832b"
"#fddc69"
"#42be65"
"#3ddbd9"
"#82cfff"
"#78a9ff"
"#4589ff"
"#be95ff"
"#ffffff"
"#f7f3f2"
"#e5e0df"
"#cac5c4"
"#ada8a8"
"#8f8b8b"
"#726e6e"
"#565151"
"#3c3838"
"#272525"
"#171414"
"#000000"
    )
    ;;

  *)
    echo "invalid flavor argument $flavor"
    ;;
esac

patch
