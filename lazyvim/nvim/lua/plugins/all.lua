return {

  -- add onedark theme and configure LazyVim to load it.
  {
    "navarasu/onedark.nvim",
    opts = {
      highlights = {
        IlluminatedWordText = { bg = "$bg3" },
        IlluminatedWordRead = { bg = "$bg3" },
        IlluminatedWordWrite = { bg = "$bg3" },
      },
    },
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "onedark" } },

  -- neo-tree configuration
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- Show hidden files by default
          -- hide_gitignored = false,
          never_show = { -- remains hidden even if visible is toggled to true
            ".DS_Store",
          },
          never_show_by_pattern = {
            "*.pyc",
          },
        },
      },
    },
  },

  -- dim unused symbols
  {
    "zbirenbaum/neodim",
    event = "LspAttach",
    opts = {
      alpha = 0.5,
    },
  },

  {
    "folke/todo-comments.nvim",
    -- opts = {
    --   keywords = {
    --     TODO = { icon = " ", color = "info" },
    --     NOTE = { icon = " ", color = "hint" },
    --   },
    --   highlight = {
    --     multiline = false,
    --     pattern = "[[.*<(KEYWORDS)]]",  -- block highlight pattern
    --   },
    --   search = {
    --     pattern = [[\b(KEYWORDS)\b]], -- search patterb
    --   },
    -- },
    -- opts = function(_, opts)
    --   opts.keywords = {
    --     TODO = { icon = " ", color = "info" },
    --     NOTE = { icon = " ", color = "hint" },
    --   }
    --   opts.highlight = vim.tbl_extend("force", opts.highlight, {
    --     multiline = false,
    --     pattern = "[[.*<(KEYWORDS)]]",
    --   })
    --   opts.search = vim.tbl_extend("force", opts.search, {
    --     pattern = [[\b(KEYWORDS)\b]],
    --   })
    -- end,
  },

  -- mini.indentscope configuration
  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = {
        -- Disable indent scope line animation
        animation = require("mini.indentscope").gen_animation.none(),
      },
    },
  },

  -- mason configuration
  {
    "williamboman/mason.nvim",
    opts = {
      -- Overwrite lazyvim deafult, do not install anything automatically
      ensure_installed = {},
    },
  },

  -- null-ls configuration
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.diagnostics_format = "[#{s}] #{c}: #{m}"
      opts.sources = {
        nls.builtins.formatting.trim_whitespace,
      }
      -- vim.list_extend(opts.sources, {
      --   nls.builtins.formatting.trim_whitespace,
      -- })
    end,
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      -- Overwrite lazyvim default, complete/replace on tab
      opts.completion = { completeopt = "menu,menuone,noselect" }
      opts.preselect = "None" -- Do not preselect the first item

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
