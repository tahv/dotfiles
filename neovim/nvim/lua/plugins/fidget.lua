-- Standalone UI for nvim-lsp progress 
return {
  'j-hui/fidget.nvim',
  -- fidget.nvim will soon be completely rewritten.
  -- Pinning configuration to the legacy branch to avoid breaking changes.
  -- https://github.com/j-hui/fidget.nvim/issues/131
  tag = 'legacy',
  config = function()
    require('fidget').setup({})
  end,
}
