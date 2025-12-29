---@type LazySpec[]
return {
  {
    -- Automatic indentation style detection for Neovim
    "nmac427/guess-indent.nvim",
    opts = {
      override_editorconfig = false, -- override settings set by .editorconfig
    },
  },
  {
    -- Automatically manage character pairs
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    version = "*",
    opts = {},
  },
  {
    -- Surround actions
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
  {
    -- Smart and powerful comment plugin for Neovim
    "numToStr/Comment.nvim",
    ---@type CommentConfig
    opts = {},
    keys = {
      "gc", -- Linewise comment
      "gb", -- Blockwise comment
    },
  },
  {
    -- Smoothly navigate between neovim and terminal multiplexer(s)
    "numToStr/Navigator.nvim",
    config = function(_, opts) require("Navigator").setup(opts) end,
    keys = {
      -- Navigate windows using <ctrl> hjkl keys
      { "<C-h>", "<CMD>NavigatorLeft<CR>", desc = "Go to left window" },
      { "<C-j>", "<CMD>NavigatorDown<CR>", desc = "Go to lower window" },
      { "<C-k>", "<CMD>NavigatorUp<CR>", desc = "Go to upper window" },
      { "<C-l>", "<CMD>NavigatorRight<CR>", desc = "Go to right window" },
    },
  },
  {
    -- Improve viewing Markdown files
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
    opts = {},
    dependencies = {
      "nvimq-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>tm", ":RenderMarkdown toggle<CR>", desc = "[T]oggle render [M]arkdown" },
    },
  },
  {
    -- Preview Markdown in browser with synchronised scrolling
    "iamcco/markdown-preview.nvim",
    enabled = true,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    -- https://github.com/iamcco/markdown-preview.nvim/issues/690
    build = ":call mkdp#util#install()",
  },
  {
    -- Displays a popup with possible keybindings of the command you started typing.
    "folke/which-key.nvim",
    event = "VeryLazy",
    ---@type wk.Opts
    opts = {
      preset = "helix",
      icons = {
        mappings = true,
      },
    },
    config = function(_, opts)
      require("which-key").setup(opts)
      require("which-key").add({
        { "<leader>b", group = "[b]uffer", icon = "󰈔" },
        { "<leader>c", group = "[c]ode", icon = "" },
        { "<leader>s", group = "[s]earch", icon = "" },
        { "<leader>t", group = "[t]oggle", icon = "" },
        -- ["<leader>u"] = { name = "+[U]i" },
        { "<leader>w", group = "[w]indow", icon = "" },
        { "<leader>g", group = "[g]it", icon = "" },
        { "gs", desc = "[s]urround" },
        { "grn", desc = "re[n]ame symbol" },
        { "gra", desc = "code [a]ction", mode = { "n", "v" } },
      })
    end,
  },
  {
    -- A neovim plugin that helps managing crates.io dependencies
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    tag = "stable",
    config = function() require("crates").setup({}) end,
  },
  {
    "MeanderingProgrammer/py-requirements.nvim",
    event = { "BufRead pyproject.toml" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- config = function() require("py-requirements").setup({}) end,
    opts = {
      index_url = "https://pypi.org/simple/",
      extra_index_url = nil, -- Fallback endpoint in case 'index_url' fails to find a package
    },
  },
}
