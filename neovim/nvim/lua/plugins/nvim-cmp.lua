local symbol_map = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
}

local function completion_next(fallback)
  local cmp = require('cmp')
  if cmp.visible() then
    cmp.select_next_item()
  else
    fallback()
  end
end

local function completion_previous(fallback)
  local cmp = require('cmp')
  if cmp.visible() then
    cmp.select_prev_item()
  else
    fallback()
  end
end

return {
  'hrsh7th/nvim-cmp',
  event = "InsertEnter",
  dependencies = {
    'L3MON4D3/LuaSnip',             -- Snippet engine
    'rafamadriz/friendly-snippets', -- Pre-configured snippets for different languages
    'saadparwaiz1/cmp_luasnip',     -- Source: LuaSnip snippets
    -- 'hrsh7th/cmp-buffer',        -- Source: text in current buffer
    -- 'hrsh7th/cmp-path',          -- Source: file system paths
    'hrsh7th/cmp-nvim-lsp',         -- Source: neovim builtin LSP client
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    -- Loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup({
      preselect = cmp.PreselectMode.None,

      -- Configure how nvim-cmp interacts with the snippet engine.
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- Sources for autocompletion, order matters.
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },

      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(_, item)
          item.kind = symbol_map[item.kind] or ""
          return item
        end,
      },

      mapping = cmp.mapping.preset.insert {
        -- ['<C-p>'] = cmp.mapping.select_prev_item(), -- Previous suggestion
        -- ['<C-n>'] = cmp.mapping.select_next_item(), -- Next suggestion
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),   -- Show completion suggestion
        ['<C-e>'] = cmp.mapping.abort(),          -- Close the completion window
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace, -- Replace adjacent text with selected item.
          select = false,                         -- Only confirm explicitly selected item
        },
        ['<Tab>'] = cmp.mapping(completion_next, { "i", "s" }),
        ['<S-Tab>'] = cmp.mapping(completion_previous, { "i", "s" })
      },
    })
  end,
}
