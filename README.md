# Carburetor

An IBM Carbon inspired colorscheme. 

## Table of Contents

1. [Previews](#previews)
2. [Usage](#usage)
    1. [Generic Patch Tool](#generic-patch-tool)
    2. [Example Configs](#example-configs)
        1. [Nvim](#nvim)
        2. [Wezterm](#wezterm)
        3. [Discord](#discord)
        4. [Userstyles](#userstyles)
3. [Honorable Mentions](#honorable-mentions)

## Previews

![image](https://github.com/ozwaldorf/carburetor/assets/8976745/485c15d7-bf52-4558-ba72-72bde8ce9a96)

![image](https://github.com/ozwaldorf/carburetor/assets/8976745/c58ed141-858a-4422-aea4-24ce89625fd1)

## Usage 

The current form of this scheme is as a direct patch for [catppuccin](https://github.com/catppuccin/catppuccin) ports.

### Generic Patch Tool

There is a simple bash script for patching any existing catppuccin port's hex colors to carburetor. Note that some ports use a css pre-processor to create variations of colors, so they will need to be patched beforehand and then compiled, like [discord](#discord).

```bash
./patch.sh <all|mocha|macchiato|frappe> <directory path>
```

### Example Configs

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
../patch.sh all node_modules/@catppuccin/palette

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
