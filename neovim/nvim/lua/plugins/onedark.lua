return {
  "navarasu/onedark.nvim",
  priority = 1000,
  opts = {
    highlights = {
      -- Better display for vim-illuminate
      IlluminatedWordText = { bg = "$bg3" },
      IlluminatedWordRead = { bg = "$bg3" },
      IlluminatedWordWrite = { bg = "$bg3" },
    },
  },
  config = function(_, opts)
    require("onedark").setup(opts)
    vim.cmd.colorscheme "onedark"
  end,
}
