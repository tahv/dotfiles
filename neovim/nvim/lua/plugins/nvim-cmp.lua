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
  local cmp = require("cmp")
  if cmp.visible() then
    cmp.select_next_item()
  else
    fallback()
  end
end

local function completion_previous(fallback)
  local cmp = require("cmp")
  if cmp.visible() then
    cmp.select_prev_item()
  else
    fallback()
  end
end

local function ghost_text_hl_group()
  local hl_group = "CmpGhostText"
  vim.api.nvim_set_hl(0, hl_group, { link = "Comment", default = true })
  return hl_group
end

---@type LazySpec
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    -- "hrsh7th/cmp-nvim-lsp-signature-help",
    "saadparwaiz1/cmp_luasnip", -- Source: LuaSnip snippets
    {
      -- Snippet Engine.
      "L3MON4D3/LuaSnip", -- TODO: build
      dependencies = {
        {
          -- Set of preconfigured snippets for different languages.
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
    },
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      experimental = { ghost_text = { hl_group = ghost_text_hl_group() } },
      preselect = cmp.PreselectMode.None,
      snippet = { -- Configure how nvim-cmp interacts with the snippet engine.
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        -- {{ name = "nvim_lsp_signature_help" }},
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, { -- Sources below are only shown if none of the above matched.
        { name = "buffer" },
      }),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(_, vim_item)
          vim_item.kind = symbol_map[vim_item.kind] or ""
          return vim_item
        end,
      },
      mapping = cmp.mapping.preset.insert({
        -- ['<C-p>'] = cmp.mapping.select_prev_item(), -- Previous suggestion
        -- ['<C-n>'] = cmp.mapping.select_next_item(), -- Next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- Show completion suggestion
        ["<C-e>"] = cmp.mapping.abort(), -- Close the completion window
        -- Only confirm explicitly selected item and replace adjacent text with selected item.
        ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        ["<Tab>"] = cmp.mapping(completion_next, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(completion_previous, { "i", "s" }),
      }),
    })
  end,
}
