---@type LazySpec[]
return {
  {
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
  { "catppuccin/nvim", enabled = false, priority = 1000, name = "catppuccin" },
  { "AlexvZyl/nordic.nvim", enabled = false, priority = 1000 },
  -- { "zenbones-theme/zenbones.nvim", dependencies = "rktjmp/lush.nvim" },
  -- { "savq/melange-nvim", enabled = true },
  -- { "HoNamDuong/hybrid.nvim", priority = 1000 },
  -- { "rebelot/kanagawa.nvim", priority = 1000 },
  { "thesimonho/kanagawa-paper.nvim", priority = 1000 },
  -- { "mellow-theme/mellow.nvim", priority = 1000 },
  -- { "rose-pine/neovim", priority = 1000, name = "rose-pine" },
  { "folke/tokyonight.nvim", priority = 1000 },
  -- { "nyoom-engineering/oxocarbon.nvim", priority = 1000 } },
  -- { "ramojus/mellifluous.nvim", priority = 1000 },
  -- { "vague-theme/vague.nvim", priority = 1000 },
}
