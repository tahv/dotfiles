return {
  'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
    require("onedark").setup({
      highlights = {
        -- Better display for vim-illuminate
        IlluminatedWordText = { bg = "$bg3" },
        IlluminatedWordRead = { bg = "$bg3" },
        IlluminatedWordWrite = { bg = "$bg3" },
      },
    })
    vim.cmd.colorscheme 'onedark'
  end,
}

