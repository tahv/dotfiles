---@type LazySpec[]
return {
  {
    -- Smart and powerful comment plugin for neovim.
    -- `gcc` - Toggles the current line using linewise comment.
    -- `gbc` - Toggles the current line using blockwise comment.
    "numToStr/Comment.nvim",
    event = "VeryLazy", -- { "BufReadPre", "BufNewFile" },
    ---@type CommentConfig
    opts = {},
  },
  {
    -- treesitter plugin for setting commentstring based on the cursor location.
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
}
