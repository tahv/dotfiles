vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd("BufReadCmd", {
  desc = "Open Python wheel",
  pattern = "*.whl",
  group = vim.api.nvim_create_augroup("whl-ft", { clear = true }),
  command = 'call zip#Browse(expand("<amatch>"))',
})

-- Open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})

-- Auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
  command = "wincmd =",
})

-- Syntax highlighting for dotenv files
vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("dotenv-ft", { clear = true }),
  pattern = { ".env", ".env.*" },
  callback = function() vim.bo.filetype = "dosini" end,
})

-- Show cursorline only in active window - enable
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("active-cursorline", { clear = true }),
  callback = function() vim.opt_local.cursorline = true end,
})

-- Show cursorline only in active window - disable
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = "active-cursorline",
  callback = function() vim.opt_local.cursorline = false end,
})
