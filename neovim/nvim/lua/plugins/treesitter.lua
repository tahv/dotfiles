---Check `tree-sitter-cli` is installed
---@return boolean installed whether tree-sitter-cli is available.
local function check_treesitter_cli()
  local utils = require("utils")
  local have_mason, mason_registry = pcall(require, "mason-registry")
  if not have_mason then
    utils.err("Missing `tree-sitter-cli` and `mason.nvim` is disabled")
    return false
  end
  if not mason_registry.is_installed("tree-sitter-cli") then
    utils.err("Missing `tree-sitter-cli`, install it with `mason.nvim`")
    return false
  end
  return true
end

---Ensure `mingw64` is installed on Windows, for compiling treesitter parsers
local function ensure_mingw64_on_windows()
  -- TODO(tga): with winget: https://winlibs.com/
  local utils = require("utils")
  if not utils.is_win() then
    return
  end

  local datadir = utils.user_stdpath("data")
  local archive = vim.fs.joinpath(utils.user_stdpath("cache"), "mingw64.7z")

  if vim.uv.fs_stat(archive) then
    utils.info("Deleting '" .. archive .. "'")
    vim.fs.rm(archive)
    utils.info("Deleted '" .. archive .. "'")
  end

  utils.download_file(
    "https://github.com/niXman/mingw-builds-binaries/releases/download/15.2.0-rt_v13-rev0/x86_64-15.2.0-release-win32-seh-ucrt-rt_v13-rev0.7z",
    archive
  )

  local outdir = vim.fs.joinpath(datadir, "mingw64")
  if vim.uv.fs_stat(outdir) then
    utils.info("Deleting '" .. outdir .. "'")
    vim.fs.rm(outdir, { recursive = true })
    utils.info("Deleted '" .. outdir .. "'")
  end

  utils.extract_7z_archive(archive, datadir)
end

---@class tahv.RepeatableMoveModule
---@field builtin_F_expr function
---@field builtin_T_expr function
---@field builtin_f_expr function
---@field builtin_t_expr function
---@field repeat_last_move_next function
---@field repeat_last_move_previous function

---@return tahv.RepeatableMoveModule
local function ts_repeat_move() return require("nvim-treesitter-textobjects.repeatable_move") end

---@param query_string string
---@param query_group? string
---@return fun() function
local function select_textobject(query_string, query_group)
  return function()
    local select = require("nvim-treesitter-textobjects.select")
    select.select_textobject(query_string, query_group)
  end
end

---@param query_string string
---@param query_group? string
---@return fun() function
local function goto_next_start(query_string, query_group)
  return function()
    local select = require("nvim-treesitter-textobjects.move")
    select.goto_next_start(query_string, query_group)
  end
end

---@param query_string string
---@param query_group? string
---@return fun() function
local function goto_next_end(query_string, query_group)
  return function()
    local select = require("nvim-treesitter-textobjects.move")
    select.goto_next_end(query_string, query_group)
  end
end

---@param query_string string
---@param query_group? string
---@return fun() function
local function goto_prev_start(query_string, query_group)
  return function()
    local select = require("nvim-treesitter-textobjects.move")
    select.goto_previous_start(query_string, query_group)
  end
end

---@param query_string string
---@param query_group? string
---@return fun() function
local function goto_prev_end(query_string, query_group)
  return function()
    local select = require("nvim-treesitter-textobjects.move")
    select.goto_previous_end(query_string, query_group)
  end
end

---@param query_string string
---@param query_group? string
---@return fun() function
local function swap_next(query_string, query_group)
  return function()
    local select = require("nvim-treesitter-textobjects.swap")
    select.swap_next(query_string, query_group)
  end
end

---@param query_string string
---@param query_group? string
---@return fun() function
local function swap_prev(query_string, query_group)
  return function()
    local select = require("nvim-treesitter-textobjects.swap")
    select.swap_previous(query_string, query_group)
  end
end

---@type LazySpec[]
return {
  {
    -- Treesitter configurations and abstraction layer
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = function(plugin)
      check_treesitter_cli()
      ensure_mingw64_on_windows()
      -- Update all parsers
      require("lazy.core.loader").load(plugin, { task = "build" })
      local cmd = vim.api.nvim_parse_cmd("TSUpdate", {}) --[[@as vim.api.keyset.cmd]]
      vim.api.nvim_cmd(cmd, { output = true })
    end,
    ---@alias lazyvim.TSFeat { enable?: boolean }
    ---@class tahv.TSConfig: TSConfig
    opts = {
      indent = { enable = true }, ---@type lazyvim.TSFeat enable indentation based on the `=` operator
      highlight = { enable = true }, ---@type lazyvim.TSFeat enable syntax highlighting
      folds = { enable = false }, ---@type lazyvim.TSFeat
      ensure_installed = { ---@type string[]
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
        "nu",
        "python",
        "regex",
        "requirements",
        "rst",
        "rust",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
    ---@param opts tahv.TSConfig
    config = function(_, opts)
      local utils = require("utils")
      local treesitter = require("nvim-treesitter")

      if utils.is_win() then
        local bin = vim.fs.joinpath(utils.user_stdpath("data"), "mingw64", "bin")
        vim.env.PATH = vim.env.PATH .. ";" .. bin
      end

      treesitter.setup()

      -- install missing
      treesitter.install(opts.ensure_installed)

      -- remove unused
      local installed = treesitter.get_installed()
      local remove = utils.difference(installed, opts.ensure_installed)
      if next(remove) ~= nil then
        treesitter.uninstall(remove)
      end

      -- TODO(tga): install automatically: https://aliou.me/posts/upgrading-nvim-treesitter/
      -- enable features per-file
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter-features", { clear = true }),
        callback = function(args)
          -- filter installed filetype
          if vim.treesitter.language.get_lang(args.match) == nil then
            return
          end
          -- syntax highlighting
          if opts.highlight.enable ~= false then
            pcall(vim.treesitter.start, args.buf)
          end
          -- indentation
          if opts.indent.enable ~= false then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
          -- folds
          if opts.folds.enable ~= false then
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            -- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            -- vim.wo[0][0].foldmethod = "expr"
          end
        end,
      })
    end,
  },
  {
    -- Show code context
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    enabled = true,
    ---@type TSContext.UserConfig
    opts = {
      mode = "cursor",
      max_lines = 5,
      multiline_threshold = 1, -- line per context
    },
    keys = {
      { "<leader>tc", ":TSContext toggle<CR>", desc = "[t]oggle code [c]ontext" },
      -- { "[c", function() require("treesitter-context").go_to_context(vim.v.count1) end, desc = "jump to context" },
    },
  },
  {
    -- Syntax aware text-objects, select, move, swap, and peek support
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
      vim.g.no_plugin_maps = true -- disable built-in `ftplugin` mappings to avoid conflicts
    end,
    ---@type TSTextObjects.UserConfig
    opts = {
      select = {},
      move = { set_jumps = true }, -- add to jumplist
    },
    keys = {
      -- select text objects
      { "aa", select_textobject("@parameter.outer"), desc = "outer p[a]rameter", mode = { "x", "o" } },
      { "ia", select_textobject("@parameter.inner"), desc = "[i]nner p[a]rameter", mode = { "x", "o" } },
      { "af", select_textobject("@function.outer"), desc = "outer [f]unction", mode = { "x", "o" } },
      { "if", select_textobject("@function.inner"), desc = "[i]nner [f]unction", mode = { "x", "o" } },
      { "ac", select_textobject("@class.outer"), desc = "outer [c]lass", mode = { "x", "o" } },
      { "ic", select_textobject("@class.inner"), desc = "[i]nner [c]lass", mode = { "x", "o" } },
      -- move to the next or previous text object
      { "]f", goto_next_start("@function.outer"), desc = "next [f]unction start", mode = { "n", "x", "o" } },
      { "]c", goto_next_start("@class.outer"), desc = "next [c]lass start", mode = { "n", "x", "o" } },
      { "]F", goto_next_end("@function.outer"), desc = "next [F]unction end", mode = { "n", "x", "o" } },
      { "]C", goto_next_end("@class.outer"), desc = "next [C]lass end", mode = { "n", "x", "o" } },
      { "[f", goto_prev_start("@function.outer"), desc = "previous [f]unction start", mode = { "n", "x", "o" } },
      { "[c", goto_prev_start("@class.outer"), desc = "previous [c]lass start", mode = { "n", "x", "o" } },
      { "[F", goto_prev_end("@function.outer"), desc = "previous [F]unction end", mode = { "n", "x", "o" } },
      { "[C", goto_prev_end("@class.outer"), desc = "previous [C]lass end", mode = { "n", "x", "o" } },
      -- swap text objects
      { "<leader>a", swap_next("@parameter.inner"), desc = "swap p[a]rameter with next" },
      { "<leader>A", swap_prev("@parameter.inner"), desc = "swap p[A]rameter with previous" },
      -- repeat movement with ; and ,
      { ";", function() ts_repeat_move().repeat_last_move_next() end, mode = { "n", "x", "o" } },
      { ",", function() ts_repeat_move().repeat_last_move_previous() end, mode = { "n", "x", "o" } },
      -- make builtin f, F, t, T also repeatable with ; and ,
      -- { "f", function() ts_repeat_move().builtin_f_expr() end, expr = true, mode = { "n", "x", "o" } },
      -- { "F", function() ts_repeat_move().builtin_F_expr() end, expr = true, mode = { "n", "x", "o" } },
      -- { "t", function() ts_repeat_move().builtin_t_expr() end, expr = true, mode = { "n", "x", "o" } },
      -- { "T", function() ts_repeat_move().builtin_T_expr() end, expr = true, mode = { "n", "x", "o" } },
    },
  },
}
