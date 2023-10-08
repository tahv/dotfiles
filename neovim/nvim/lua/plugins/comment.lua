-- Smart and powerful comment plugin for neovim.
-- `gcc` - Toggles the current line using linewise comment.
-- `gbc` - Toggles the current line using blockwise comment.
return {
  'numToStr/Comment.nvim',
  event = { "BufReadPre", "BufNewFile" },
  -- TODO: investigate "JoosepAlviste/nvim-ts-context-commentstring" for context comment
  config = function()
    require("Comment").setup()
  end,
}
