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
    -- Smoothly navigate between neovim and terminal multiplexer(s)
    "numToStr/Navigator.nvim",
    enabled = false,
    opts = {},
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
    enabled = true,
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      enabled = false,
      render_modes = { "n", "c", "t" },
      -- completions = { lsp = { enabled = true } },
    },
    dependencies = {
      "nvimq-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>tm", ":RenderMarkdown toggle<CR>", desc = "toggle render [m]arkdown" },
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
        -- default LSP keymaps
        { "grn", desc = "LSP re[n]ame", mode = "n" },
        { "gra", desc = "LSP code [a]ction", mode = { "n", "x" } },
        { "grr", desc = "LSP [r]eferences", mode = "n" },
        { "gri", desc = "LSP [i]implementation", mode = "n" },
        { "grt", desc = "LSP [t]ype definition", mode = "n" },
        { "gO", desc = "LSP document symb[O]ls", mode = "n" },
        { "<C-S>", desc = "[s]ignature help", mode = { "i", "s" } },
      })
    end,
  },
  {
    -- A neovim plugin that helps managing crates.io dependencies
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    tag = "stable",
    opts = {},
  },
  {
    "MeanderingProgrammer/py-requirements.nvim",
    enabled = false,
    event = { "BufRead pyproject.toml" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      index_url = "https://pypi.org/simple/",
      extra_index_url = nil, -- Fallback endpoint in case 'index_url' fails to find a package
    },
  },
}
