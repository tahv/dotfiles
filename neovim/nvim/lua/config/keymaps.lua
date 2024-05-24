vim.keymap.set('n', '<leader>bb', "<cmd>e #<cr>", { desc = 'Switch to other [B]uffer' })
-- vim.keymap.set('n', '<leader>e', ':Explore<cr>', { desc = 'Open [E]xplorer' })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
-- Move by screen line if no count was given, otherwise move by text line
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Manage windows (tmux split keys)
vim.keymap.set('n', '<leader>w"', '<C-W>s', { desc = 'Split [W]indow below' })
vim.keymap.set('n', '<leader>w%', '<C-w>v', { desc = 'Split [W]indow right' })
vim.keymap.set('n', '<leader>wd', '<C-w>c', { desc = '[W]indow [D]elete' })

-- Navigate windows using <ctrl> hjkl keys
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- Center buffer when moving
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move half screen up' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move half screen down' })
vim.keymap.set('n', 'gg', 'ggzz', { desc = 'Go to the first line of the document' })
vim.keymap.set('n', 'G', 'Gzz', { desc = 'Go to the last line of the document' })
vim.keymap.set('n', 'n', 'nzz', { desc = 'Repeat search in same direction' })
vim.keymap.set('n', 'N', 'Nzz', { desc = 'Repeat search in opposite direction' })
vim.keymap.set('n', '<C-o>', '<C-o>zz', { desc = 'Go to older position in jump list' })
vim.keymap.set('n', '<C-i>', '<C-i>zz', { desc = 'Go to newer position in jump list' })

-- Don't lose selection when shifting sidewards
-- https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
vim.keymap.set("v", "<", "<gv", { desc = 'Dedent' })
vim.keymap.set("v", ">", ">gv", { desc = 'Indent' })

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
