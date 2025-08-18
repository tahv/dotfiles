vim.o.mouse = "a" -- Enable mouse in all modes
vim.o.colorcolumn = "80,88" -- Vertical rulers
vim.o.wrap = false -- Deactivate line wrap
vim.o.scrolloff = 5 -- Keep n lines above & below cursor
vim.o.sidescrolloff = 5 -- Keep n lines left & right of cursor
vim.o.clipboard = "unnamedplus" -- Sync clipboard between OS and vim
vim.o.breakindent = true
vim.o.completeopt = "menu,menuone,noselect" -- Completion options

-- Indentation
vim.o.tabstop = 4 -- Tab width
vim.o.expandtab = true -- Use soaces instead of tabs
vim.o.autoindent = true -- Copy indent from current line
vim.o.smartindent = true -- Smart auto-indenting

-- Search settings
vim.o.ignorecase = true -- Case insensitive search
vim.o.smartcase = true -- Case sensitive search if uppercase in search
vim.o.hlsearch = true -- Highlight search results
-- vim.o.incsearch = true  -- Show matches as you type
-- vim.o.showmatch = true  -- Highlight matching bracket
-- vim.o.matchtume = 2  -- How lon to show matching bracket

-- Visual settings
vim.o.signcolumn = "yes" -- Always show sign column
vim.o.termguicolors = true -- Enable 24-bit colors (make sure terminal supports it)
vim.o.cursorline = true -- Highlight cursor line
vim.o.number = true -- Show line numbers
vim.o.relativenumber = true -- Relative line numbers

-- File handling
-- vim.o.backup = false -- Don't create backup files
-- vim.o.writebackup = false -- Don't create backup before writing
-- vim.o.autoread = true  -- Auto reload files changes outside vim
vim.o.swapfile = false -- Don't create swap
vim.o.undofile = true -- Save undo history
vim.o.updatetime = 250 -- Faster completion, decrease update time.
vim.o.timeoutlen = 300 -- Key timeout duration

vim.diagnostic.config({
  jump = { float = true },
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
    border = "rounded",
    format = function(diag)
      if diag.source then
        return string.format("%s: %s", diag.source, diag.message)
      end
      return diag.message
    end,
  },
})
