---@type LazySpec[]
return {
  -- 'tpope/vim-fugitive',
  -- 'tpope/vim-rhubarb',
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  require("plugins.lsp"), -- LSP Configuration & Plugins
  require("plugins.gitsigns"), -- Adds git signs to gutter and utilities for managing changes
  require("plugins.lualine"), -- Set lualine as statusline
  require("plugins.colorschemes"),
  -- require("plugins.telescope"), -- Fuzzy Finder (files, lsp, etc)
  -- require("plugins.nvim-cmp"), -- Autocompletion
  require("plugins.blink-cmp"), -- Autocompletion
  require("plugins.treesitter"),
  require("plugins.snacks"),
  {
    -- Buffer-lile file explorer
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- Load the plugin eagerly so oil takes over netrw
    ---@type oil.setupOpts
    opts = {
      win_options = {
        winbar = "%{v:lua.require('oil').get_current_dir()}",
      },
      view_options = {
        show_hidden = true,
      },
      float = { padding = 3 },
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-r>"] = "actions.refresh",
        ["q"] = "actions.close",
      },
    },
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", desc = "[e]xplorer (buffer dir)" },
      { "<leader>E", function() require("oil.actions").open_cwd.callback() end, desc = "[E]xplorer (root)" },
    },
  },
  {
    -- Indentation guides
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    main = "ibl",
    ---@type ibl.config.full
    opts = {
      indent = {
        char = "▏",
      },
      scope = {
        show_start = false,
        show_end = false,
      },
    },
  },
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
    -- Improve the default `vim.ui` interfaces
    "stevearc/dressing.nvim",
    lazy = true,
    enabled = false,
    opts = {},
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
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
    -- Highlighting other uses of the word under cursor using LSP, Tree-sitter, or regex.
    "RRethy/vim-illuminate",
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
        { "grn", desc = "re[n]ame symbol" },
        { "gra", desc = "code [a]ction", mode = { "n", "v" } },
      })
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    enabled = false,
    event = "VeryLazy", -- Or `LspAttach`
    opts = {},
  },
  {
    "dgagn/diagflow.nvim",
    enabled = false,
    event = "LspAttach",
    opts = {},
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
      { "nvim-telescope/telescope.nvim" },
      {
        "nvim-treesitter/nvim-treesitter",
        opts = {
          ensure_installed = { "markdown" },
        },
      },
    },
    cmd = { "PyDoc" },
    opts = {},
    keys = {
      {
        "<leader>sp",
        function() require("pydoc").show_telescope_picker() end,
        desc = "[S]earch [P]ydoc",
      },
    },
  },
}
