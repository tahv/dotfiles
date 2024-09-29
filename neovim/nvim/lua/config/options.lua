-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Vertical rulers
vim.o.colorcolumn = "80,88"

-- Deactivate line wrap
vim.o.wrap = false

vim.o.tabstop = 4

-- No swap file
vim.o.swapfile = false

-- Sync clipboard between OS and Neovim.
-- Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.scrolloff = 5

-- Highlight cursor line
vim.o.cursorline = true

vim.diagnostic.config({
  virtual_text = {
    format = function(diag)
      if diag.source and diag.code then
        return string.format("%s [%s]", diag.source, diag.code)
      elseif diag.source then
        return string.format("%s", diag.source)
      elseif diag.code then
        return string.format("[%s]", diag.code)
      end
      return diag.message
    end,
  },
  float = {
    format = function(diag)
      if diag.source then
        return string.format("%s: %s", diag.source, diag.message)
      end
      return diag.message
    end,
  },
})
