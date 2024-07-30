# Carburetor

A functional and high contrast colorscheme inspired by IBM Carbon.

## Table of Contents

1. [Previews](#previews)
2. [Usage](#usage)
    1. [Nix](#nix)
        1. [Overlay](#overlay)
        2. [Home Manager](#home-manager)
        3. [Making your own themes!](#making-your-own-themes)
    2. [Patch Tool](#patch-tool)
        1. [Discord](#discord)
    3. [Catppuccin Whiskers](#catppuccin-whiskers)
        1. [Zed](#zed)
    4. [Config Examples](#config-examples)
        1. [Nvim](#nvim)
        2. [Wezterm](#wezterm)
        3. [Userstyles](#userstyles)
        4. [Base16](#base16)
3. [Honorable Mentions](#honorable-mentions)

## Previews

![image](https://github.com/ozwaldorf/carburetor/assets/8976745/54bbafc8-cc3a-4fa0-a291-c54cdd49bfd8)

## Usage

The current form of this scheme is as a direct patch for [catppuccin](https://github.com/catppuccin/catppuccin) ports.

### Nix

Add carburetor flake to your inputs:

```nix
inputs = {
    carburetor.url = "github:ozwaldorf/carburetor";
}
```

#### Overlay

Add the overlay to your nixpkgs to insert the theme's package set:

```nix
pkgs = import nixpkgs {
  inherit system;
  overlays = [ inputs.carburetor.overlays.default ];
};
```

This provides the following raw theme packages:

- `pkgs.carburetor.base16` - whiskers base16 config
- `pkgs.carburetor.gtk` - patched gtk theme
- `pkgs.carburetor.hyprland` - whiskers hyprland themes
- `pkgs.carburetor.hyprlock` - patched hyprlock config
- `pkgs.carburetor.discord` - patched discord css
- `pkgs.carburetor.papirus-folders` - patched papirus folders
- `pkgs.carburetor.zed` - whiskers zed theme

And the following tools:

- `pkgs.carburetor.tools.patch` - [src/patch.sh](./src/patch.sh)
- `pkgs.carburetor.tools.mkWhiskersDerivation` - Create a derivation from a source's whiskers template and output the files

#### Home Manager

> Note: The theme's nixpkgs overlay *MUST* be used for the home manager modules to work.

Example home configuration:

```nix
# import the carburetor module
imports = [ inputs.carburetor.homeManagerModules.default ];

# configure carburetor theme installation
carburetor = {
  config = {
    variant = "regular";
    accent = "blue";
  };
  themes = {
    gtk = {
      enable = true;
      transparency = true;
      icon = true;
      # size = "compact";
      # tweaks = "float";
      # gnomeShellTheme = true;
    };
    hyprland.enable = true;
    hyprlock.enable = true;
    webcord = {
      enable = true;
      transparency = true;
    };
    wezterm.enable = true;
    zed.enable = true;
  };
};
```

Detailed documentation on options is available at [docs/home.md](./docs/home.md).
A complete standalone home configuration example can be found in the main flake.nix, under `homeConfigurations.example`.

#### Making your own themes!

Carburetor's nix flake can be used as a library to implement an overlay and home module for a custom catppuccin based theme, based on a color override file for whiskers. Usage is exactly the same as above, but tailored to the themes name and custom variants. Anywhere `carburetor` is referenced, `your-theme` will be used instead.

These custom themes can be defined and used directly in a nixos/home manager derivation, or used in a popular colorscheme's flake to provide theming for nix users:

```nix
{
  description = "Example theme flake";
  inputs.carburetor.url = "github:ozwaldorf/carburetor";
  outputs = { self, carburetor }:
  let
    # Configuration for the custom theme
    exampleTheme = {
      # Theme name used in all packages and configuration options.
      name = "example-theme";
      # Variant names to replace with
      variantNames = {
        mocha = "darker";
        macchiato = "dark";
        frappe = "medium";
        latte = "light";
      };
      # Default accent to select in configuration options
      defaultAccent = "pink";
      # Path to a whiskers color override file for the theme
      whiskersJson = ./path/to/whiskers.json;
    };
    # Create an overlay for the theme packages
    exampleThemeOverlay = carburetor.lib.mkCustomThemeOverlay exampleTheme;
    # Create a home manager module for configuring the themes
    exampleThemeHomeModule = carburetor.lib.mkCustomHomeManagerModule exampleTheme;
  in
  {
    # Output the overlay and module for flake consumers
    overlays.default = exampleThemeOverlay;
    homeManagerModules.default = exampleThemeHomeModule;
  };
};
```

---

### Patch Tool

There is a simple bash script for patching any existing catppuccin port's hex colors to carburetor. Note that some ports use a css pre-processor to create variations of colors, so they will need to be patched beforehand and then compiled, like [discord](#discord).

```bash
./patch.sh <FLAVOR> <TRANSPARENCY> <directory path>

Options:
  FLAVOR: all | mocha | macchiato | frappe
  TRANSPARENCY: true | false
```

#### Discord

To patch the [discord](https://github.com/catppuccin/discord) catppuccin port, run the following:

```bash
# Clone the port
git clone https://github.com/catppuccin/discord && cd discord

# Install dependencies
yarn install

# Patch each flavor
../src/patch.sh all false node_modules/@catppuccin/palette

# Build the port
yarn build

# Install a theme (webcord specific, for other projects check their docs)
# cp dist/dist/catppuccin-mocha.theme.css ~/.config/WebCord/Themes/carburator
# cp dist/dist/catppuccin-macchiato.theme.css ~/.config/WebCord/Themes/carburator-cool
# cp dist/dist/catppuccin-frappe.theme.css ~/.config/WebCord/Themes/carburator-warm
```

---

### Catppuccin `whiskers`

 Catppuccin has a tool called [whiskers](https://github.com/catppuccin/whiskers) which is used to create color schemes from template files. The [`whiskers.json`](examples/whiskers.json) file can be used to generate a Carburetor color scheme for any template file that works with `whiskers`.

A list of available catppuccin ports can be found at [arewewhiskersyet.com](https://arewewhiskersyet.com/).

#### Zed

The same process should apply for whichever program you would like to create a Carburetor color scheme for.

1. [Install whiskers](https://github.com/catppuccin/whiskers?tab=readme-ov-file#installation)
2. Download the [template file for Zed](https://github.com/catppuccin/zed/blob/main/zed.tera)
3. (Optional) customize the template file as you like (e.g. changing the names of color schemes, etc.). Documentation for the template syntax `whiskers` uses is available [here](https://github.com/catppuccin/whiskers?tab=readme-ov-file#template).
4. Run (customizing the input filename and output format for your template):
  ```
  whiskers --color-overrides whiskers.json zed.tera
  ```
5. `whiskers` should generate one or more color scheme files, dependent on the template. For Zed, it generates a `themes` directory with color scheme files for each accent color.
6. Install your color scheme!

---

### Config Examples

#### Nvim

[catppuccin.nvim](https://github.com/catppuccin/nvim) can be easily configured to use carburetor colors, shown [here](src/nvim.lua).

#### Userstyles

Catppuccin [userstyle](https://github.com/catppuccin/userstyles/) ports use the same exact color definitions, and can be easily patched by replacing them with the [userstyle colors](src/userstyle.css).

#### Wezterm

The wezterm color configs can be found [here](src/wezterm) and can be copied into `~/.config/wezterm/colors/`.

You will then have the set of colorschemes available:

- `Carburetor`
- `Carburetor Cool`
- `Carburetor Warm`

#### Base16

A set of base16 configuration files for carburetor can be found at [src/base16](./src/base16)

## Honorable Mentions

Heavily inspired from [oxocarbon](https://github.com/nyoom-engineering/oxocarbon/).

## Development

```bash
# check packages
nix flake check

# generate docs
nix build .\#docs && cp -L result/* docs

# generate patch tool
whiskers --dry-run --color-overrides ./whiskers.json patch.tera > src/patch.sh
```
