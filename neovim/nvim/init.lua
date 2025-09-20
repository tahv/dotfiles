-- Set <space> as the leader key
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install 'lazy.vim' package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install and setup on Windows
if vim.uv.os_uname().sysname == "Windows_NT" then
  require("win").setup()
end

require("config.options")
require("config.keymaps")
require("config.autocmds")
-- require("config.lsp")

require("lazy").setup({ require("plugins") }, {})

vim.cmd.colorscheme("tokyonight-moon")

-- TODO: add autopairs + integration with cmp

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
