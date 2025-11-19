-- Declare a global function to retrieve the current directory
-- https://github.com/stevearc/oil.nvim/blob/master/doc/recipes.md#show-cwd-in-the-winbar
---@diagnostic disable-next-line: duplicate-set-field
function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

---@type LazySpec[]
return {
  {
    -- Buffer-lile file explorer
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- Load the plugin eagerly so oil takes over netrw
    ---@type oil.setupOpts
    opts = {
      win_options = {
        winbar = "%!v:lua.get_oil_winbar()",
        signcolumn = "yes:2",
      },
      view_options = {
        show_hidden = true,
      },
      float = { padding = 3 },
      skip_confirm_for_simple_edits = true,
      delete_to_trash = true,
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
  -- https://github.com/benomahony/oil-git.nvim/issues/13
  -- {
  --   "benomahony/oil-git.nvim",
  --   lazy = false,
  --   dependencies = { "stevearc/oil.nvim" },
  -- },
}
