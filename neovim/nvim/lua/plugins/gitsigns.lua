---@type LazySpec[]
return {
  {
    -- Git integration for buffers.
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
        -- stylua: ignore end
      },
      current_line_blame_formatter = "<author_time:%d/%m/%y %H:%MS> <author> - <summary>",
      current_line_blame_opts = {
        delay = 100,
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")

        vim.keymap.set("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, { buffer = bufnr, desc = "Next hunk" })

        vim.keymap.set("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, { buffer = bufnr, desc = "Previous hunk" })

        vim.keymap.set(
          "n",
          "<leader>tb",
          gs.toggle_current_line_blame,
          { buffer = bufnr, desc = "[T]oggle line [B]lame" }
        )

        vim.keymap.set("n", "<leader>td", gs.toggle_deleted, { buffer = bufnr, desc = "[T]oggle [D]eleted" })
        vim.keymap.set("n", "<leader>gd", gs.diffthis, { buffer = bufnr, desc = "[G]it [D]iff" })
        vim.keymap.set("n", "<leader>gp", gs.preview_hunk_inline, { buffer = bufnr, desc = "[G]it [P]review hunk" })
        vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { buffer = bufnr, desc = "[G]it toggle [S]tage hunk" })
        vim.keymap.set("v", "<leader>gs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { buffer = bufnr, desc = "[G]it toggle [S]tage hunk" })
      end,
    },
  },
}
