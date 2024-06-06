vim.api.nvim_create_autocmd(
  "TextYankPost",
  {
    callback = vim.highlight.on_yank,
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    pattern = "*",
    desc = "Highlight on yank",
  }
)
