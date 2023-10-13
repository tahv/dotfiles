return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",  -- lsp completion source for nvim-cmp
    -- { "antosha417/nvim-lsp-file-operations", config = true },
    'folke/neodev.nvim' -- Additional lua configuration for nevim
  },
  config = function()
    require('neodev').setup({}) -- IMPORTANT: make sure to setup neodev BEFORE lspconfig

    local lspconfig = require('lspconfig')

    -- used to enable autocompletion (assign to every lsp server config)
    -- local capabilities = cmp_nvim_lsp.default_capabilities()
    -- TODO: from config
    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(client, bufnr)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP: [R]e[n]ame Symbol' })
      -- TODO: test visual mode
      vim.keymap.set({'n', 'v'},'<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP: [C]ode [A]ction' })

      vim.keymap.set('n','gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'LSP: [G]oto [D]efinition' })
      vim.keymap.set('n','gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'LSP: [G]oto [D]eclaration' })
      vim.keymap.set('n','gr', require('telescope.builtin').lsp_references, { buffer = bufnr, desc = 'LSP: [G]oto [R]eferences' })
      vim.keymap.set('n','gI', require('telescope.builtin').lsp_implementations, { buffer = bufnr, desc = 'LSP: [G]oto [I]mplementation' })
      vim.keymap.set('n','<leader>D', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'LSP: Type [D]efinition' })

      vim.keymap.set('n','<leader>ds', require('telescope.builtin').lsp_document_symbols, { buffer = bufnr, desc = 'LSP: [D]ocument [S]ymbols' })
      -- vim.keymap.set('n','<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, { buffer = bufnr, desc = 'LSP: [W]orkspace [S]ymbols' })

      -- See `:help K` for why this keymap
      vim.keymap.set('n','K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP: Hover Documentation' })
      -- TODO: find a better shortcut to enter doc by typing it twice
      vim.keymap.set('n','gK', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'LSP: Signature Documentation' })

      -- vim.keymap.set('n','<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = 'LSP: [W]orkspace [A]dd Folder' })
      -- vim.keymap.set('n','<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc = 'LSP: [W]orkspace [R]emove Folder' })
      -- vim.keymap.set('n','<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { buffer = bufnr, desc = 'LSP: [W]orkspace [L]ist Folders' })

      vim.keymap.set('n','<leader>rs', ":LspRestart<CR>", { desc = 'LSP: Signature Documentation' })

      -- Create a command `:Format` local to the LSP buffer
      -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      --   vim.lsp.buf.format()
      -- end, { desc = 'Format current buffer with LSP' })
    end

    lspconfig["pyright"].setup({
      capabilities = capabilities,
      on_attach = on_attach
    })

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    })
  end,
}
