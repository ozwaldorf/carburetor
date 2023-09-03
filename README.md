# Carburetor

An IBM Carbon inspired colorscheme. 

![image](https://github.com/ozwaldorf/carburetor/assets/8976745/fa15c369-5f7b-4196-b863-496583beac96)

![image](https://github.com/ozwaldorf/carburetor/assets/8976745/c58ed141-858a-4422-aea4-24ce89625fd1)

## Colors

The current form of this scheme is as a direct patch for [catppuccin](https://github.com/catppuccin/catppuccin) ports.

```lua
-- Carburetor
mocha = {
  rosewater = "#ffd7d9",
  flamingo = "#ffb3b8",
  pink = "#ff7eb6",
  mauve = "#d4bbff",
  red = "#fa4d56",
  maroon = "#ff8389",
  peach = "#ff832b",
  yellow = "#fddc69",
  green = "#42be65",
  teal = "#3ddbd9",
  sky = "#82cfff",
  sapphire = "#78a9ff",
  blue = "#4589ff",
  lavender = "#be95ff",
  text = "#ffffff",
  subtext1 = "#f4f4f4",
  subtext0 = "#e0e0e0",
  overlay2 = "#c6c6c6",
  overlay1 = "#a8a8a8",
  overlay0 = "#8d8d8d",
  surface2 = "#6f6f6f",
  surface1 = "#525252",
  surface0 = "#393939",
  base = "#262626",
  mantle = "#161616",
  crust = "#000000"
},
-- Carburetor Cool
macchiato = {
  rosewater = "#ffd7d9",
  flamingo = "#ffb3b8",
  pink = "#ff7eb6",
  red = "#fa4d56",
  maroon = "#ff8389",
  peach = "#ff832b",
  yellow = "#fddc69",
  green = "#42be65",
  teal = "#3ddbd9",
  sky = "#82cfff",
  sapphire = "#78a9ff",
  blue = "#4589ff",
  lavender = "#be95ff",
  mauve = "#d4bbff",
  text = "#ffffff",
  subtext1 = "#f2f4f8",
  subtext0 = "#dde1E6",
  overlay2 = "#c1c7cd",
  overlay1 = "#a2a9b0",
  overlay0 = "#878d96",
  surface2 = "#697077",
  surface1 = "#4d5358",
  surface0 = "#343a3f",
  base = "#21272a",
  mantle = "#121619",
  crust = "#000000"
},
-- Carburetor Warm
frappe = {
  rosewater = "#ffd7d9",
  flamingo = "#ffb3b8",
  pink = "#ff7eb6",
  mauve = "#d4bbff",
  red = "#fa4d56",
  maroon = "#ff8389",
  peach = "#ff832b",
  yellow = "#fddc69",
  green = "#42be65",
  teal = "#3ddbd9",
  sky = "#82cfff",
  sapphire = "#78a9ff",
  blue = "#4589ff",
  lavender = "#be95ff",
  text = "#ffffff",
  subtext1 = "#f7f3f2",
  subtext0 = "#e5e0df",
  overlay2 = "#cac5c4",
  overlay1 = "#ada8a8",
  overlay0 = "#8f8b8b",
  surface2 = "#726e6e",
  surface1 = "#565151",
  surface0 = "#3c3838",
  base = "#272525",
  mantle = "#171414",
  crust = "#000000"
}
```

## Usage 

### Generic Patch Tool

There is a simple bash script for patching an existing catppuccin port's hex colors to carburetor.

```bash
./patch.sh <all|mocha|macchiato|frappe> <directory path>
```

### Example Configs

The [src](src) directory contains copy and paste-able configs for different things. 

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
