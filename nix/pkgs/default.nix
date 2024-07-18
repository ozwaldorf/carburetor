final: prev:
(
  import ./tools.nix prev
  // {
    carburetor-discord = prev.callPackage ./discord.nix { };
    carburetor-gtk = prev.callPackage ./gtk.nix { };
    carburetor-papirus-folders = prev.callPackage ./papirus-folders.nix { };
  }
)
