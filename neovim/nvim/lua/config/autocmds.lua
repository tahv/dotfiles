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

-- https://github.com/astral-sh/ty/issues/691
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function(_)
    local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] or ""
    local has_inline_metadata = first_line:match("^# /// script")

    local cmd, name, root_dir
    if has_inline_metadata then
      local filepath = vim.fn.expand("%:p")
      local filename = vim.fn.fnamemodify(filepath, ":t")

      -- Set a unique name for the server instance based on the filename
      -- so we get a new client for new scripts
      name = "ty-" .. filename

      local relpath = vim.fn.fnamemodify(filepath, ":.")

      cmd = { "uvx", "--with-requirements", relpath, "ty", "server" }
      root_dir = vim.fn.fnamemodify(filepath, ":h")

      vim.notify(
        "Starting `" .. name .. "` ...",
        vim.log.levels.INFO,
        { title = "Inline script metadata detected" }
      )
    else
      name = "ty"
      cmd = { "uvx", "ty", "server" }
      root_dir = vim.fs.root(0, { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" })
    end

    vim.lsp.start({
      name = name,
      cmd = cmd,
      root_dir = root_dir,
    })
  end,
})
