args@{
  name,
  variantNames,
  whiskersJson,
  defaultAccent,
  ...
}:
final: prev: {
  # Theme namespace
  "${name}" =
    let
      mkThemePackage = module: prev.callPackage (import module args) { };
    in
    {
      # Tools used to create theme packages
      tools = {
        # Generic patching tool
        patch = prev.stdenvNoCC.mkDerivation {
          name = "${name}-patch";
          src = ../../.;
          nativeBuildInputs = [ prev.catppuccin-whiskers ];
          installPhase = ''
            mkdir -p $out/bin
            ${prev.lib.meta.getExe prev.catppuccin-whiskers} --dry-run --color-overrides ${whiskersJson} patch.tera > $out/bin/${name}-patch
            chmod +x $out/bin/${name}-patch
          '';
          meta = {
            mainProgram = "${name}-patch";
          };
        };

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
            mkDerivation ? prev.stdenvNoCC.mkDerivation,

            nativeBuildInputs ? [ ],
            ...
          }@inputs:
          mkDerivation (
            {
              name = theme + "-" + pname;
              nativeBuildInputs = nativeBuildInputs ++ [
                prev.tree
                prev.catppuccin-whiskers
              ];
              buildPhase = ''
                runHook preBuild

                CMD='${prev.lib.meta.getExe prev.catppuccin-whiskers}
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
                  -e 's/catppuccin/${theme}/gI' \
                  -e 's/soothing pastel theme/${theme} theme/gI' \
                  -e 's/mocha/${variantNames.mocha}/gI' \
                  -e 's/macchiato/${variantNames.macchiato}/gI' \
                  -e 's/é/e/g' \
                  -e 's/frappe/${variantNames.frappe}/gI' \
                  -e 's/latte/${variantNames.latte}/gI' \
                  {} \;

                runHook postBuild
              '';
              # Installation phase. By default; will iterate over `$files` whiskers output
              # and copy them to $out, and rename them to the `whiskersRename` option
              installPhase = ''
                runHook preInstall
                shopt -s nocasematch
                mkdir -p $out
                for output in "''${files[@]}"; do
                  echo "Renaming and copying $output"

                  RENAME=''${output/catppuccin/${theme}}
                  RENAME=''${RENAME/mocha/${variantNames.mocha}}
                  RENAME=''${RENAME/macchiato/${variantNames.macchiato}}
                  RENAME=''${RENAME/frappe/${variantNames.frappe}}
                  RENAME=''${RENAME/latte/${variantNames.latte}}
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

        toFlavor =
          variant:
          {
            "${variantNames.mocha}" = "mocha";
            "${variantNames.macchiato}" = "macchiato";
            "${variantNames.frappe}" = "frappe";
            "${variantNames.latte}" = "latte";
          }
          ."${variant}";

      };

      "base16" = mkThemePackage ./base16.nix;
      "discord" = mkThemePackage ./discord.nix;
      "foot" = mkThemePackage ./foot.nix;
      "gtk" = mkThemePackage ./gtk.nix;
      "hyprland" = mkThemePackage ./hyprland.nix;
      "hyprlock" = mkThemePackage ./hyprlock.nix;
      "papirus-folders" = mkThemePackage ./papirus-folders.nix;
      "zed" = mkThemePackage ./zed.nix;
    };
}
