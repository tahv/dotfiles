---@type LazySpec[]
return {
  {
    -- Colorscheme based on Atom's One Dark and Light theme.
    "navarasu/onedark.nvim",
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
    "rebelot/kanagawa.nvim",
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
    enabled = false,
    priority = 1000,
    opts = {},
  },
}
