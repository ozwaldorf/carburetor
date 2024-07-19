args: final: prev:
(
  import ./tools.nix args prev
  // {
    ### Manual patches ###
    carburetor-discord = prev.callPackage ./discord.nix { };
    carburetor-gtk = prev.callPackage ./gtk.nix { };
    carburetor-papirus-folders = prev.callPackage ./papirus-folders.nix { };

    ### Whiskers themes ###
    carburetor-hyprland = prev.callPackage ./hyprland.nix { };
    carburetor-zed = prev.callPackage ./zed.nix { };
  }
)
