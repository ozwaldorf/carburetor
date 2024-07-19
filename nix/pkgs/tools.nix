{
  name,
  whiskersJson,
  variantNames,
  ...
}:
pkgs: {
  # Patch tool used to easily modify existing themes
  carburetor-patch = pkgs.stdenvNoCC.mkDerivation {
    name = "carburetor-patch";
    src = ../../.;
    nativeBuildInputs = [ pkgs.catppuccin-whiskers ];
    installPhase = ''
      mkdir -p $out/bin
      ls -lah
      ${pkgs.lib.meta.getExe pkgs.catppuccin-whiskers} --dry-run --color-overrides ${whiskersJson} patch.tera > $out/bin/carburetor-patch
      chmod +x $out/bin/carburetor-patch
    '';
  };

  lib = pkgs.lib // {
    carburetor = {
      # Utility to create a derivation based on a source that supports whiskers and provides a tera template.
      mkWhiskersDerivation =
        {
          # Theme name
          theme ? name,
          # Package name
          pname,

          # Glob is used by default to let bash find the tera file in the project root
          whiskersPath ? "*.tera",
          # Output format needed for the template
          whiskersOutput ? "json",
          # Overrides to pass
          whiskersOverrides ? "{}",
          # Color overrides file to pass
          whiskersColorOverrides ? whiskersJson,

          # Inner mkDerivation function to use
          mkDerivation ? pkgs.stdenvNoCC.mkDerivation,

          nativeBuildInputs ? [ ],
          ...
        }@inputs:
        mkDerivation (
          {
            name = theme + "-" + pname;
            nativeBuildInputs = nativeBuildInputs ++ [
              pkgs.tree
              pkgs.catppuccin-whiskers
            ];
            buildPhase = ''
              runHook preBuild

              CMD='${pkgs.lib.meta.getExe pkgs.catppuccin-whiskers}
                ${whiskersPath}
                -o ${whiskersOutput}
                --color-overrides ${whiskersColorOverrides}'

              $CMD

              # Perform a dry run and capture the list of output files
              IFS=$'\n' export files=($(
                $CMD --dry-run | awk -F 'into ' '{print $2}'
              ))

              # Replace name and variant texts
              find . -type f -exec sed -i \
                -e 's/catppuccin/${theme}/Ig' \
                -e 's/mocha/${variantNames.mocha}/Ig' \
                -e 's/macchiato/${variantNames.macchiato}/Ig' \
                -e 's/frapp(e|é)/${variantNames.frappe}/Ig' \
                -e 's/latte/${variantNames.latte}/Ig' \
                {} \;

              runHook postBuild
            '';
            # Installation phase. By default; will iterate over `$files` whiskers output
            # and copy them to $out, and rename them to the `whiskersRename` option
            installPhase = ''
              runHook preInstall

              mkdir -p $out
              for output in "''${files[@]}"; do
                echo "Renaming and copying $output"

                RENAME=''${output/catppuccin/${theme}}
                RENAME=''${RENAME/mocha/${variantNames.mocha}}
                RENAME=''${RENAME/macchiato/${variantNames.macchiato}}
                RENAME=''${RENAME/frappe/${variantNames.frappe}}
                RENAME=''${RENAME/latte/${variantNames.frappe}}
                if [ "$output" != "$RENAME" ]; then
                  cp $output $RENAME
                fi
                cp -r --parent $RENAME $out
              done

              runHook postInstall
            '';
          }
          // inputs
        );
    };
  };
}
