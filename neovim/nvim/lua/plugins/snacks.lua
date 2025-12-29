---@type LazySpec[]
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = {
        enabled = true,
        notify = true,
      },
      quickfile = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          -- { section = "header" },
          { section = "keys", gap = 1 },
          -- { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 2 } },
          -- { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
          -- { section = "startup" },
        },
      },
      dim = {
        enabled = false,
        animate = { enabled = false },
      },
      gitbrowse = {
        notify = true,
        url_patterns = {
          ["gitlab%.org"] = {
            branch = "/-/tree/{branch}",
            file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
            permalink = "/-/blob/{commit}/{file}#L{line_start}-L{line_end}",
            commit = "/-/commit/{commit}",
          },
        },
      },
      indent = {
        enabled = true,
        scope = { char = "▏" },
        indent = { char = "▏" },
        animate = { enabled = false },
      },
      input = { enabled = true },
      notifier = { enabled = true },
      picker = {
        show_delay = 0, -- ms to wait before showing the picker while no results yet
        ui_select = true, -- replace `vim.ui.select` with the snacks picker
        main = {
          file = false,
          current = true,
        },
      },
      words = {
        enabled = true,
        debounce = 100,
      },
    },
    keys = {
      -- Search
      { "<leader><space>", function() Snacks.picker.buffers() end, desc = "[ ] search buffers" },
      { "<leader>sD", function() Snacks.picker.diagnostics() end, desc = "search [D]iagnostics" },
      { "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, desc = "search buffer [d]iagnostics" },
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "search [b]uffer lines" },
      { "<leader>sf", function() Snacks.picker.files({ hidden = true }) end, desc = "search [f]iles" },
      {
        "<leader>sc",
        function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
        desc = "search [c]onfig files",
      },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "[g]rep" },
      { "<leader>sG", function() Snacks.picker.grep_word() end, desc = "[G]rep word" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "search [h]elp" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "search [k]eymaps" },
      { "<leader>sr", function() Snacks.picker.resume() end, desc = "[r]esume last search" },
      -- Git
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "search git [l]og" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "search git log [L]ine" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "search git log [f]ile" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "search [g]it [s]tatus" },
      { "<leader>gB", function() Snacks.git.blame_line() end, desc = "[b]lame line" },
      { "<leader>go", function() Snacks.gitbrowse.open({ what = "repo" }) end, desc = "[o]pen git repo" },
      { "<leader>gO", function() Snacks.gitbrowse.open({ what = "file" }) end, desc = "[O]pen git file" },
      -- LSP
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "goto [d]efinition" },
      { "gD", function() Snacks.picker.lsp_declarations() end, desc = "goto [D]eclaration" },
      { "grr", function() Snacks.picker.lsp_references() end, desc = "goto [r]eferences" },
      { "gri", function() Snacks.picker.lsp_implementations() end, desc = "goto [i]mplementation" },
      { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "goto t[y]pe definition" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "search buffer [s]ymbols" },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "search workspace [S]ymbols" },
      -- Other
      { "<leader>bd", function() Snacks.bufdelete.delete() end, desc = "buffer [d]elete" },
      { "<leader>bD", function() Snacks.bufdelete.delete({ force = true }) end, desc = "buffer [D]elete (force)" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazy[g]it" },
      { "z=", function() Snacks.picker.spelling() end, desc = "Spelling suggestions" },
      -- Floating terminal
      {
        "<leader>tt",
        function() Snacks.terminal.toggle(nil, { win = { position = "float", border = "rounded" } }) end,
        desc = "Toggle [t]erminal",
      },
      -- Words
      { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
      -- Other
      { "<leader>tn", function() Snacks.notifier.show_history() end, desc = "[n]otification History" },
    },
  },
}
