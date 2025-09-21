local map = vim.keymap.set

vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to other [b]uffer" })
-- vim.keymap.set('n', '<leader>e', ':Explore<cr>', { desc = 'Open [E]xplorer' })

vim.keymap.set("n", "<leader>bc", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("file:", path)
end, { desc = "[c]opy buffer file path" })

vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
-- Move by screen line if no count was given, otherwise move by text line
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Manage windows (tmux split keys)
vim.keymap.set("n", '<leader>w"', "<C-W>s", { desc = "Split [w]indow below" })
vim.keymap.set("n", "<leader>w%", "<C-w>v", { desc = "Split [w]indow right" })
vim.keymap.set("n", "<leader>wd", "<C-w>c", { desc = "[w]indow [d]elete" })

-- Navigate windows using <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Move lines up/down
-- vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
-- vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
-- vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
-- vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Resize window using <ctrl> arrow keys

vim.keymap.set("n", "<C-Up>", function()
  if vim.fn.winnr() == vim.fn.winnr("j") then -- at bottom edge
    vim.api.nvim_win_set_height(0, vim.api.nvim_win_get_height(0) + 2)
  else
    vim.api.nvim_win_set_height(0, vim.api.nvim_win_get_height(0) - 2)
  end
end, { desc = "Resize window up" })

vim.keymap.set("n", "<C-Down>", function()
  if vim.fn.winnr() == vim.fn.winnr("j") then -- at bottom edge
    if vim.fn.winnr() ~= vim.fn.winnr("k") then -- not at top edge
      vim.api.nvim_win_set_height(0, vim.api.nvim_win_get_height(0) - 2)
    end
  else
    vim.api.nvim_win_set_height(0, vim.api.nvim_win_get_height(0) + 2)
  end
end, { desc = "Resize Window down" })

vim.keymap.set("n", "<C-Left>", function()
  if vim.fn.winnr() == vim.fn.winnr("l") then -- at right edge
    vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) + 2)
  else
    vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) - 2)
  end
end, { desc = "Resize window left" })

vim.keymap.set("n", "<C-Right>", function() -- at right edge
  if vim.fn.winnr() == vim.fn.winnr("l") then
    vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) - 2)
  else
    vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) + 2)
  end
end, { desc = "Resize window right" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

-- Center buffer when moving
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move half screen up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move half screen down" })
vim.keymap.set("n", "gg", "ggzz", { desc = "Go to the first line of the document" })
vim.keymap.set("n", "G", "Gzz", { desc = "Go to the last line of the document" })
vim.keymap.set("n", "n", "nzz", { desc = "Repeat search in same direction" })
vim.keymap.set("n", "N", "Nzz", { desc = "Repeat search in opposite direction" })
vim.keymap.set("n", "<C-o>", "<C-o>zz", { desc = "Go to older position in jump list" })
vim.keymap.set("n", "<C-i>", "<C-i>zz", { desc = "Go to newer position in jump list" })

-- Keep selection when shifting sidewards
-- https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
vim.keymap.set("v", "<", "<gv", { desc = "Dedent" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent" })

-- The direction of n and N depends on whether / (forward) or ? (backward) was used.
-- Remapping 'n' to always search forward and 'N' backward.
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit Terminal mode" })

-- LSP

vim.keymap.set("n", "grR", function()
  vim.lsp.stop_client(vim.lsp.get_clients())
  vim.cmd("edit")
end, { desc = "[R]estart LSP" })

-- map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
-- map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[R]ename Symbol" })
map("n", "grc", "<cmd>checkhealth vim.lsp<cr><esc>", { desc = "[c]heck health lsp" })
map("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, { desc = "Hover Documentation" })
map("n", "<C-s>", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, { desc = "signature help" })
map("i", "<C-s>", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, { desc = "signature help" })
vim.keymap.del("n", "gO") -- Disable default keymap of 'vim.lsp.buf.document_symbol'

map("n", "<leader>th", function()
  local toggle = not vim.lsp.inlay_hint.is_enabled()
  vim.lsp.inlay_hint.enable(toggle)
end, { desc = "toggle inlay [h]ints" })
