
local function previous_hunk()
  if vim.wo.diff then
    vim.cmd.normal({ "[c", bang = true })
  else
    require("gitsigns").nav_hunk("prev")
  end
end

local function next_hunk()
  if vim.wo.diff then
    vim.cmd.normal({ "]c", bang = true })
  else
    require("gitsigns").nav_hunk("next")
  end
end

return {
  -- Git integration for buffers.
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "▁" },
      topdelete = { text = "▔" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    current_line_blame_formatter = "<author_time:%d/%m/%y %H:%MS> <author> - <summary>",
    current_line_blame_opts = {
      delay = 100,
    },
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      vim.keymap.set("n", "]c", next_hunk, { buffer = bufnr, desc = "Next hunk" })
      vim.keymap.set("n", "[c", previous_hunk, { buffer = bufnr, desc = "Previous hunk" })
      vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = "[T]oggle line [B]lame" })
      vim.keymap.set("n", "<leader>td", gitsigns.toggle_deleted, { buffer = bufnr, desc = "[T]oggle git show [D]eleted" })
    end,
  },
}
