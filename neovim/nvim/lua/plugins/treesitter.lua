local iswin = vim.fn.has("win32") == 1

local function setup_mingw64()
  local utils = require("utils")
  local datadir = utils.user_stdpath("data")
  local archive = vim.fs.joinpath(utils.user_stdpath("cache"), "mingw64.7z")

  if vim.uv.fs_stat(archive) then
    print("[tahv] " .. "Deleting '" .. archive .. "'")
    vim.fs.rm(archive)
  end

  utils.download_file(
    "https://github.com/niXman/mingw-builds-binaries/releases/download/15.2.0-rt_v13-rev0/x86_64-15.2.0-release-win32-seh-ucrt-rt_v13-rev0.7z",
    archive
  )

  local outdir = vim.fs.joinpath(datadir, "mingw64")
  if vim.uv.fs_stat(outdir) then
    print("[tahv] " .. "Deleting '" .. outdir .. "'")
    vim.fs.rm(outdir, { recursive = true })
  end

  utils.extract_7z_archive(archive, datadir)
end

---@type LazySpec[]
return {
  {
    -- Treesitter configurations and abstraction layer for Neovim.
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    version = false, -- last release is way too old and doesn't work on Windows
    -- branch = 'main',
    -- main = "nvim-treesitter.configs",
    event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },

    build = function(plugin)
      -- Prepare compiler on Windows
      if iswin then
        setup_mingw64()
      end
      -- Update all parsers
      require("lazy.core.loader").load(plugin, { task = "build" })
      local cmd = vim.api.nvim_parse_cmd("TSUpdate", {}) --[[@as vim.api.keyset.cmd]]
      vim.api.nvim_cmd(cmd, { output = true })
    end,

    config = function(_, opts)
      if iswin then
        -- todo: set compilers directly instead
        -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support
        local utils = require("utils")
        local bin = vim.fs.joinpath(utils.user_stdpath("data"), "mingw64", "bin")
        vim.env.PATH = vim.env.PATH .. ";" .. bin
      end
      require("nvim-treesitter.configs").setup(opts)
    end,

    opts = {
      highlight = { enable = true }, -- Enable syntax highlighting
      indent = { enable = true }, -- Enable indentation based on the `=` operator
      auto_install = true,
      ensure_installed = {
        "bash",
        "c_sharp",
        "diff",
        "dockerfile",
        "gitignore",
        "json",
        "jsonc",
        "just",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "mermaid",
        "python",
        "regex",
        "requirements",
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
  },
  {
    -- Treesitter plugin for setting commentstring based on the cursor location
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = { enable_autocmd = false },
  },
  {
    -- Show code context.
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    enabled = true,
    ---@type TSContext.UserConfig
    opts = {
      mode = "cursor",
      max_lines = 3,
    },
    keys = {
      { "<leader>tc", ":TSContextToggle<CR>", desc = "[T]oggle [C]ontext" },
    },
  },
  {
    -- Syntax aware text-objects, select, move, swap, and peek support.
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    lazy = true,
    enabled = true,
    main = "nvim-treesitter.configs",
    opts = {
      textobjects = {
        select = {
          enable = true,
          -- lookahead = true, -- Automatically jump to next textobject
          keymaps = {
            ["aa"] = { query = "@parameter.outer", desc = "Outer p[a]rameter" },
            ["ia"] = { query = "@parameter.inner", desc = "[i]nner p[a]rameter" },
            ["af"] = { query = "@function.outer", desc = "Outer [f]unction" },
            ["if"] = { query = "@function.inner", desc = "[i]nner [f]unction" },
            ["ac"] = { query = "@class.outer", desc = "Outer [c]lass" },
            ["ic"] = { query = "@class.inner", desc = "[i]nner [c]lass" },
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- Add to jumplist
          goto_next_start = {
            ["]f"] = { query = "@function.outer", desc = "Next [f]unction start" },
            ["]c"] = { query = "@class.outer", desc = "Next [c]lass start" },
          },
          goto_next_end = {
            ["]F"] = { query = "@function.outer", desc = "Next [F]unction end" },
            ["]C"] = { query = "@class.outer", desc = "Next [C]lass end" },
          },
          goto_previous_start = {
            ["[f"] = { query = "@function.outer", desc = "Previous [f]unction start" },
            ["[c"] = { query = "@class.outer", desc = "Previous [c]lass start" },
          },
          goto_previous_end = {
            ["[F"] = { query = "@function.outer", desc = "Previous [F]unction end" },
            ["[C"] = { query = "@class.outer", desc = "Previous [C]lass end" },
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
