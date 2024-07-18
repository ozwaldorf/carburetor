# Carburetor

A functional and high contrast colorscheme inspired by IBM Carbon.

## Table of Contents

1. [Previews](#previews)
2. [Usage](#usage)
    1. [Nix](#nix)
    2. [Patch Tool](#patch-tool)
        1. [Discord](#discord)
    3. [Catppuccin Whiskers](#catppuccin-whiskers)
    4. [Config Examples](#config-examples)
        1. [Nvim](#nvim)
        2. [Wezterm](#wezterm)
        4. [Userstyles](#userstyles)
3. [Honorable Mentions](#honorable-mentions)

## Previews

![image](https://github.com/ozwaldorf/carburetor/assets/8976745/54bbafc8-cc3a-4fa0-a291-c54cdd49bfd8)

## Usage

The current form of this scheme is as a direct patch for [catppuccin](https://github.com/catppuccin/catppuccin) ports.

### Nix

#### Packages

Output packages are available through `carburetor.packages.${system}.*`, or as an overlay through `carburetor.overlays.default`:

- `carburetor-gtk` - patched gtk theme
- `carburetor-discord` - patched discord css
- `carburetor-papirus-folders` - patched papirus folders
- `carburetor-patch` - [patch.sh](./patch.sh)

#### Home Manager

> Note: nixpkgs overlay *MUST* be used for the home manager modules to work.

Several themes can be automatically installed and/or configured via home manager.

Simply import the default module to make all options available, or import individual modules for only their specific options:

```
imports [ inputs.carburetor.homeManagerModules.default ];
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

### Catppuccin `whiskers`

 Catppuccin has a tool called [whiskers](https://github.com/catppuccin/whiskers) which is used to create color schemes from template files. The [`whiskers.json`](examples/whiskers.json) file can be used to generate a Carburetor color scheme for any template file that works with `whiskers`.

A list of available catppuccin ports can be found at [arewewhiskersyet.com](https://arewewhiskersyet.com/).

#### Example: Zed
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

#### Wezterm

The wezterm color configs can be found [here](src/wezterm) can be copied into `~/.config/wezterm/colors/`.

You will then have the set of colorschemes available:

- `Carburetor`
- `Carburetor Cool`
- `Carburetor Warm`

#### Discord

To patch the [discord](https://github.com/catppuccin/discord) catppuccin port, run the following:

```bash
# Clone the port
git clone https://github.com/catppuccin/discord && cd discord

# Install dependencies
yarn install

# Patch each flavor
../patch.sh all false node_modules/@catppuccin/palette

# Build the port
yarn build

# Install a theme (webcord specific, for other projects check their docs)
# cp dist/dist/catppuccin-mocha.theme.css ~/.config/WebCord/Themes/carburator
# cp dist/dist/catppuccin-macchiato.theme.css ~/.config/WebCord/Themes/carburator-cool
# cp dist/dist/catppuccin-frappe.theme.css ~/.config/WebCord/Themes/carburator-warm
```

#### Userstyles

Most catppuccin [userstyle](https://github.com/catppuccin/userstyles/) ports use the same exact color definition, and are easily modified using the [userstyle example](src/userstyle.css).

## Honorable Mentions

Heavily inspired from [oxocarbon](https://github.com/nyoom-engineering/oxocarbon/).
