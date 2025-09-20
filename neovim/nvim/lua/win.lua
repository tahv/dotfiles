local M = {}

-- install node and npm for pyright
local bootstrap_npm = function()
  local utils = require("utils")
  local datadir = utils.user_stdpath("data")
  local archive = vim.fs.joinpath(utils.user_stdpath("cache"), "node.7z")

  if vim.uv.fs_stat(archive) then
    vim.fs.rm(archive)
  end

  utils.download_file("https://nodejs.org/dist/v23.6.0/node-v23.6.0-win-x64.7z", archive)

  local outdir = vim.fs.joinpath(datadir, "node")
  if vim.uv.fs_stat(outdir) then
    vim.fs.rm(outdir, { recursive = true })
  end

  utils.extract_7z_archive(archive, datadir)
  os.rename(vim.fs.joinpath(datadir, "node-v23.6.0-win-x64"), outdir)
end

-- install python for ruff-lsp
local bootstrap_python = function()
  local utils = require("utils")
  local datadir = utils.user_stdpath("data")
  local archive = vim.fs.joinpath(utils.user_stdpath("cache"), "python.tar.gz")

  if vim.uv.fs_stat(archive) then
    vim.fs.rm(archive)
  end

  utils.download_file(
    "https://github.com/astral-sh/python-build-standalone/releases/download/20250918/cpython-3.13.7+20250918-x86_64-pc-windows-msvc-install_only.tar.gz",
    archive
  )

  local outdir = vim.fs.joinpath(datadir, "python")
  if vim.uv.fs_stat(outdir) then
    vim.fs.rm(outdir, { recursive = true })
  end

  print("[tahv] " .. "Extracting '" .. archive .. "'")
  os.execute("tar -xf " .. archive .. " -C " .. datadir)
  print("[tahv] " .. "Extracted " .. archive .. " to '" .. datadir .. "'")

  vim.fn.system({
    vim.fs.joinpath(outdir, "python.exe"),
    "-m",
    "pip",
    "install",
    "pynvim",
  })
end

function M.setup()
  local iswin = vim.fn.has("win32") == 1
  if not iswin then
    return
  end

  local utils = require("utils")
  local datadir = utils.user_stdpath("data")

  -- Setup node
  local nodedir = vim.fs.joinpath(datadir, "node")
  if not vim.uv.fs_stat(nodedir) then
    bootstrap_npm()
  end
  vim.env.PATH = vim.env.PATH .. ";" .. nodedir

  -- Setup python
  local pydir = vim.fs.joinpath(datadir, "python")
  if not vim.uv.fs_stat(pydir) then
    bootstrap_python()
  end
  vim.env.PATH = vim.env.PATH .. ";" .. pydir
  vim.g.python3_host_prog = vim.fs.joinpath(pydir, "python.exe")
end

return M
