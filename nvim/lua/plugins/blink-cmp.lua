---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*", -- use a release tag to download pre-built binaries
    event = "InsertEnter",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "none", -- set to 'none' to disable the 'default' preset
        -- TODO: snippets
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
        -- Show documentation when selecting a completion item
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        menu = {
          border = "rounded",
        },
        -- Disable auto brackets
        -- NOTE: some LSPs may add auto brackets themselves anyway
        accept = { auto_brackets = { enabled = false } },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      cmdline = { enabled = false },
      signature = {
        enabled = true,
        window = { border = "rounded" },
      },
    },
  },
}
