local function next_hunk()
  if vim.wo.diff then
    -- jump to start of next change
    vim.cmd.normal({ "]c", bang = true })
  else
    require("gitsigns").nav_hunk("next")
  end
end

local function prev_hunk()
  if vim.wo.diff then
    -- jump to start of previous change
    vim.cmd.normal({ "[c", bang = true })
  else
    require("gitsigns").nav_hunk("prev")
  end
end

---@return [integer,integer]
local function visual_range()
  local start = vim.fn.line(".")
  local stop = vim.fn.line("v")
  return { start, stop }
end

---@type LazySpec[]
return {
  {
    -- Git integration for buffers.
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    enabled = true,
    ---@type Gitsigns.Config
    opts = {
      signs = {
        -- stylua: ignore start
        add =          { text = "▎" },
        change =       { text = "▎" },
        delete =       { text = "▁" },
        topdelete =    { text = "▔" },
        changedelete = { text = "▎" },
        untracked =    { text = "▎" },
        -- stylua: ignore end
      },
      signs_staged = {
        -- stylua: ignore start
        add =          { text = "▎" },
        change =       { text = "▎" },
        delete =       { text = "▁" },
        topdelete =    { text = "▔" },
        changedelete = { text = "▎" },
        untracked =    { text = "▎" },
        -- stylua: ignore end
      },
      current_line_blame_formatter = "<author_time:%x %X> • <author> • <summary>",
      current_line_blame_opts = {
        delay = 100,
      },
      numhl = true,
      signcolumn = false,
      on_attach = function(buffer)
        --- @param mode string|string[]
        --- @param lhs string
        --- @param rhs string|function
        --- @param desc string
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc, silent = true })
        end

        local gs = require("gitsigns")

        map("n", "]h", next_hunk, "Next [h]unk")
        map("n", "[h", prev_hunk, "Previous [h]unk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First [H]unk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last [H]unk")
        map("n", "<leader>gd", gs.diffthis, "[d]iff this")
        map("n", "<leader>gb", gs.toggle_current_line_blame, "Toggle line [b]lame")
        map("n", "<leader>gB", function() gs.blame() end, "Blame [B]uffer")
        map("n", "<leader>gp", gs.preview_hunk_inline, "[p]review hunk inline")
        map("n", "<leader>gh", gs.stage_hunk, "Stage [h]unk")
        map("x", "<leader>gh", function() gs.stage_hunk(visual_range()) end, "Stage [h]unk")
        map("n", "<leader>gR", gs.reset_hunk, "[R]eset hunk")
        map("x", "<leader>gR", function() gs.reset_hunk(visual_range()) end, "[R]eset hunk")
        -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        -- TODO: https://github.com/lewis6991/gitsigns.nvim/discussions/1343
      end,
    },
  },
}
