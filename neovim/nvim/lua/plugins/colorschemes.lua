---@type LazySpec[]
return {
  {
    -- Colorscheme based on Atom's One Dark and Light theme.
    "navarasu/onedark.nvim",
    enabled = false,
    priority = 1000,
    opts = {
      -- style = "warm",
      highlights = {
        -- Better display for vim-illuminate
        IlluminatedWordText = { bg = "$bg3" },
        IlluminatedWordRead = { bg = "$bg3" },
        IlluminatedWordWrite = { bg = "$bg3" },
      },
    },
  },
  {
    -- Soothing pastel theme.
    "catppuccin/nvim",
    enabled = false,
    name = "catppuccin",
    priority = 1000,
    opts = {},
  },
  {
    "AlexvZyl/nordic.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {},
    -- config = function() require("nordic").load() end,
  },
  {
    "rebelot/kanagawa.nvim",
    enabled = false,
  },
  {
    "mellow-theme/mellow.nvim",
    enabled = false,
  },
  {
    "sho-87/kanagawa-paper.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "rose-pine/neovim",
    enabled = false,
    name = "rose-pine",
    priority = 1000,
    opts = {},
  },
  {
    "folke/tokyonight.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    ---@class tokyonight.Config
    opts = {
      ---@param hl tokyonight.Highlights
      ---@param c ColorScheme
      on_highlights = function(hl, c)
        -- local util = require("tokyonight.util")
        -- local del_bg = util.darken(c.git.delete, 0.5)
        -- hl.GitSignsDeleteVirtLnInline = { bg = del_bg }
      end,
    },
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    enabled = false,
  },
  {
    "0xstepit/flow.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      fluo_color = "pink",
      mode = "desaturate",
      aggressive_spell = false,
    },
  },
  {
    "ramojus/mellifluous.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "serhez/teide.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {},
  },
}
