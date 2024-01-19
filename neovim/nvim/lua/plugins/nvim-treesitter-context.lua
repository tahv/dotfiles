-- Show code context.
return {
  'nvim-treesitter/nvim-treesitter-context',
  event = "BufReadPre",
  enabled = true,
  opts = { mode = "cursor" },
}
