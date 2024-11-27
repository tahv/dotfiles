---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "v0.*", -- use a release tag to download pre-built binaries

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        -- TODO: snippets
        ["<Tab>"] = { "show", "select_next", "fallback" },
        ["<S-Tab>"] = { "show", "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
      highlight = {
        use_nvim_cmp_as_default = true,
      },
      nerd_font_variant = "mono",
      -- experimental auto-brackets support
      sources = {
        completion = {
          enabled_providers = { "lsp", "path", "snippets", "buffer" },
        },
        -- adding any nvim-cmp sources here will enable them with blink.compat
        compat = {},
      },
      -- experimental auto-brackets support
      accept = { auto_brackets = { enabled = true } },
      -- experimental signature help support
      trigger = { signature_help = { enabled = true } },
      -- allows extending the enabled_providers array elsewhere
      opts_extend = { "sources.completion.enabled_providers" },
      windows = {
        autocomplete = { selection = "auto_insert" },
        documentation = { auto_show = true },
      },
    },
  },
}
