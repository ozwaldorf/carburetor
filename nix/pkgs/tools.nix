pkgs: {
  # Patch tool used to easily modify existing themes
  carburetor-patch = pkgs.stdenvNoCC.mkDerivation {
    name = "carburetor-patch";
    src = ../../.;
    installPhase = ''
      mkdir -p $out/bin
      cp ./src/patch.sh $out/bin/carburetor-patch
    '';
  };

  lib = pkgs.lib // {
    carburetor = {
      # Utility to create a derivation based on a source that supports whiskers and provides a tera template.
      mkWhiskersDerivation =
        {
          # Theme name
          theme ? "carburetor",
          # Package name
          pname,

          # Glob is used by default to let bash find the tera file in the project root
          whiskersPath ? "*.tera",
          # Output format needed for the template
          whiskersOutput ? "json",
          # Overrides to pass
          whiskersOverrides ? "{}",
          # Color overrides file to pass
          whiskersColorOverrides ? ../../src/whiskers.json,

          # Inner mkDerivation function to use
          mkDerivation ? pkgs.stdenvNoCC.mkDerivation,

          nativeBuildInputs ? [ ],
          ...
        }@inputs:
        mkDerivation (
          {
            name = theme + "-" + pname;
            nativeBuildInputs = nativeBuildInputs ++ [ pkgs.catppuccin-whiskers ];
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

              runHook postBuild
            '';
            # Installation phase. By default; will iterate over `$files` whiskers output
            # and copy them to $out, and rename them to the `whiskersRename` option
            installPhase = ''
              runHook preInstall

              mkdir -p $out
              for output in "''${files[@]}"; do
                echo "Copying and renaming $output"
                cp -r --parents $output $out
                mv $out/$output $out/''${output/catppuccin/${theme}}
              done

              runHook postInstall
            '';
          }
          // inputs
        );
    };
  };
}
