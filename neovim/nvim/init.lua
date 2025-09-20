-- Set leader key before loading plugins so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.uv.os_uname().sysname == "Windows_NT" then
  require("win").setup()
end

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")

vim.cmd.colorscheme("tokyonight-moon")
