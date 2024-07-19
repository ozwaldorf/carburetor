{
  mkCustomThemeOverlay = args: (import ./pkgs args);
  mkCustomHomeManagerModule = args: (import ./home/default.nix) args;
}
