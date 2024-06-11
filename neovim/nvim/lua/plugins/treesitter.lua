---@type LazySpec[]
return {
  {
    -- Treesitter configurations and abstraction layer for Neovim.
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate", -- When installed or updated, update all parsers
    event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
      highlight = { enable = true }, -- Enable syntax highlighting
      indent = { enable = true }, -- Enable indendation based on the `=` operator
      auto_install = true,
      ensure_installed = {
        "bash",
        "c_sharp",
        "diff",
        "dockerfile",
        "gitignore",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "mermaid",
        "python",
        "regex",
        "requirements", -- python requirements
        "rust",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>", -- Start incremental selection
          node_incremental = "<C-space>", -- Increment to the upper named parent
          scope_incremental = false, -- Decrement to the upper scope
          node_decremental = "<C-BS>", -- Decrement to the previous named node
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    -- Show code context.
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    enabled = true,
    ---@type TSContext.UserConfig
    opts = { mode = "cursor" },
  },
  {
    -- Syntax aware text-objects, select, move, swap, and peek support.
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    lazy = true,
    enabled = true,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    opts = {
      textobjects = {
        select = {
          enable = true,
          -- lookahead = true, -- Automatically jump to next textobject
          keymaps = {
            ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a p[a]rameter" },
            ["ia"] = { query = "@parameter.inner", desc = "Select [i]nner part of a p[a]rameter" },
            ["af"] = { query = "@function.outer", desc = "Select outer part of a [f]unction" },
            ["if"] = { query = "@function.inner", desc = "Select [i]nner part of a [f]unction" },
            ["ac"] = { query = "@class.outer", desc = "Select outer part of a [c]lass" },
            ["ic"] = { query = "@class.inner", desc = "Select [i]nner part of a [c]lass" },
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- Add to jumplist
          goto_next_start = {
            ["]f"] = { query = "@function.outer", desc = "Move to next [f]unction start" },
            -- ["]c"] = { query = "@class.outer", desc = "Move to next [c]lass start" },
          },
          goto_next_end = {
            ["]F"] = { query = "@function.outer", desc = "Move to next [F]unction end" },
            -- ["]C"] = { query = "@class.outer", desc = "Move to next [C]lass end" },
          },
          goto_previous_start = {
            ["[f"] = { query = "@function.outer", desc = "Move to previous [f]unction start" },
            -- ["[c"] = { query = "@class.outer", desc = "Move to previous [c]lass start" },
          },
          goto_previous_end = {
            ["[F"] = { query = "@function.outer", desc = "Move to previous [F]unction end" },
            -- ["[C"] = { query = "@class.outer", desc = "Move to previous [C]lass end" },
          },
        },
        -- swap = {
        --   enable = true,
        --   swap_next = {
        --     ["<leader>a"] = { query = "@parameter.inner", desc = "Swap Parameter with Next" },
        --   },
        --   swap_previous = {
        --     ["<leader>A"] = { query = "@parameter.inner", desc = "Swap Parameter with Previous" },
        --   },
        -- },
      },
    },
  },
}
