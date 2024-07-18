# Carburetor

A functional and high contrast colorscheme inspired by IBM Carbon.

## Table of Contents

1. [Previews](#previews)
2. [Usage](#usage)
    1. [Nix](#nix)
    2. [Patch Tool](#patch-tool)
        1. [Discord](#discord)
    3. [Catppuccin Whiskers](#catppuccin-whiskers)
        1. [Zed](#zed)
    4. [Config Examples](#config-examples)
        1. [Nvim](#nvim)
        2. [Wezterm](#wezterm)
        3. [Userstyles](#userstyles)
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

#### Packages

Output packages are available through `carburetor.packages.${system}.*`, or as an overlay through `carburetor.overlays.default`:

- `carburetor-gtk` - patched gtk theme
- `carburetor-discord` - patched discord css
- `carburetor-papirus-folders` - patched papirus folders
- `carburetor-patch` - [src/patch.sh](./src/patch.sh)
- `carburetor-zed` - whiskers zed theme

#### Overlay

Add the overlay to your nixpkgs:

```nix
import nixpkgs {
  system = "x86_64-linux";
  overlays = [ inputs.carburetor.overlays.default ];
};
```

#### Home Manager

> Note: nixpkgs overlay *MUST* be used for the home manager modules to work.

Example:

```nix
# import the carburetor module
imports = [ inputs.carburetor.homeManagerModules.default ];

# configure carburetor theme installation
carburetor = {
    variant = "regular";
    accent = "blue";

    webcord.enable = true; # install and configure theme
    wezterm.enable = true; # installs all theme files, needs to be configured seperately
    zed.enable = true; # installs all theme files, needs to be configured seperately
}
```

Detailed documentation on options are available at [docs/home.md](./docs/home.md).

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
  whiskers zed.tera -o json --color-overrides whiskers.json
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

## Honorable Mentions

Heavily inspired from [oxocarbon](https://github.com/nyoom-engineering/oxocarbon/).

## Development

### Docs

Nix docs can be generated and copied to the repo via:

```bash
nix build .\#docs && cp -L result/* docs
```

