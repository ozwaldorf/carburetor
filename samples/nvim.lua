-- Packer.nvim example config

use({
  "catppuccin/nvim",
  as = "catppuccin",
  config = function()
    require("catppuccin").setup({
      color_overrides = {
        mocha = {
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
          crust = "#000000",
        },
      }
    })
  end
})
