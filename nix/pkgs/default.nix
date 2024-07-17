final: prev: {
  # Patch tool used to easily modify existing themes
  carburetor-patch = prev.stdenv.mkDerivation {
    name = "carburetor-patch";
    src = ../../.;
    installPhase = ''
      mkdir -p $out/bin
      cp ./patch.sh $out/bin/carburetor-patch
      chmod +x $out/bin/carburetor-patch
    '';
  };

  carburetor-discord = prev.callPackage ./discord.nix { };
  carburetor-gtk = prev.callPackage ./gtk.nix { };
  carburetor-papirus-folders = prev.callPackage ./papirus-folders.nix { };
}
