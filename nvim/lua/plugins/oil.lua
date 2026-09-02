--- Show CWD in the winbar
--- :h oil-recipe-cwd-winbar
---@diagnostic disable-next-line: duplicate-set-field
function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    return vim.api.nvim_buf_get_name(0)
  end
end

---@type LazySpec[]
return {
  {
    "barrettruth/canola.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- Load the plugin eagerly so oil takes over netrw
    main = "oil",
    ---@type oil.setupOpts
    opts = {
      lsp_file_methods = {
        enabled = true,
      },
      win_options = {
        winbar = "%!v:lua.get_oil_winbar()",
      },
      view_options = {
        show_hidden = true,
      },
      float = {
        padding = 3,
      },
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
  { "malewicz1337/oil-git.nvim" },
}
