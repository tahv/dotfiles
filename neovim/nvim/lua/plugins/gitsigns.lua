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

        vim.keymap.set("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]h", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, { buffer = bufnr, desc = "Next hunk" })

        vim.keymap.set("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[h", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, { buffer = bufnr, desc = "Previous hunk" })

        vim.keymap.set(
          "n",
          "<leader>tb",
          gs.toggle_current_line_blame,
          { buffer = bufnr, desc = "[t]oggle line [b]lame" }
        )
        vim.keymap.set("n", "<leader>gd", gs.diffthis, { buffer = bufnr, desc = "git [d]iff" })
        vim.keymap.set("n", "<leader>gp", gs.preview_hunk_inline, { buffer = bufnr, desc = "git [p]review hunk" })
        vim.keymap.set("n", "<leader>gh", gs.stage_hunk, { buffer = bufnr, desc = "git toggle stage [h]unk" })
        vim.keymap.set(
          "v",
          "<leader>gh",
          function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
          { buffer = bufnr, desc = "git toggle stage [h]unk" }
        )
      end,
    },
  },
}
