---@type LazySpec[]
return {
  {
    -- Remove buffers
    "echasnovski/mini.bufremove",
    enabled = false,
    version = "*",
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "[b]uffer [d]elete" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "[b]uffer [D]elete (force)" },
    },
  },
  {
    -- Highlighting other uses of the word under cursor using LSP, Tree-sitter, or regex.
    "RRethy/vim-illuminate",
    enabled = false, -- Handled by snacks
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      large_file_cutoff = 2000, -- number of lines at which to use large_file_overrides
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts) require("illuminate").configure(opts) end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    enabled = false,
    event = "VeryLazy", -- Or `LspAttach`
    opts = {},
  },
  {
    "dgagn/diagflow.nvim",
    --TODO: Wait for fix: https://github.com/dgagn/diagflow.nvim/issues/55
    enabled = false,
    event = "LspAttach",
    opts = {},
  },
  {
    "esmuellert/vscode-diff.nvim",
    enabled = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    keys = {
      { "<leader>gd", ":CodeDiff<CR>", desc = "git [d]iff" },
    },
  },
  {
    "m4xshen/hardtime.nvim",
    enabled = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },
  {
    "fredrikaverpil/pydoc.nvim",
    enabled = false,
    dependencies = {
      { "folke/snacks.nvim" },
      {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "markdown" } },
      },
    },
    cmd = { "PyDoc" },
    opts = {
      picker = {
        type = "snacks",
      },
    },
    keys = {
      { "<leader>sp", "<cmd>PyDoc<cr>", desc = "[s]earch [p]ydoc" },
    },
  },
}
