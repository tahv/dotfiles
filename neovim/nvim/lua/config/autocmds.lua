vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufReadCmd", {
  desc = "Open Python wheel",
  pattern = "*.whl",
  group = vim.api.nvim_create_augroup("whl", { clear = true }),
  command = 'call zip#Browse(expand("<amatch>"))',
})
