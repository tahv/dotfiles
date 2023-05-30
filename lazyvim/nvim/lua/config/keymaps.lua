-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Better view  scroll
vim.keymap.set(
  "n",
  "<C-u>",
  "<C-u>zz",
  {desc = "Scroll window upward and center the view"}
)

vim.keymap.set(
  "n",
  "<C-d>",
  "<C-d>zz",
  {desc = "Scroll window downward and center the view"}
)
