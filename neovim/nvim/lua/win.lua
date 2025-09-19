local M = {}

local tahvpath = vim.fn.stdpath("data") .. "\\tahv"

-- install node and npm for pyright
local download_npm = function()
  -- download
  local archive = tahvpath .. "\\node.7z"
  vim.fn.system({
    "curl",
    "-Lo",
    archive,
    -- "https://nodejs.org/dist/v20.11.0/node-v20.11.0-win-x64.7z",
    "https://nodejs.org/dist/v23.6.0/node-v23.6.0-win-x64.7z",
  })

  -- extract
  local seven_zip = get_seven_zip()
  os.execute(seven_zip .. " x " .. archive .. " -o" .. tahvpath)
  os.rename(tahvpath .. "\\node-v23.6.0-win-x64", tahvpath .. "\\node")

  -- remove archive
  os.remove(archive)
end

-- install python for ruff-lsp
local download_python = function()
  -- download
  local archive = tahvpath .. "\\python.tar.gz"
  vim.fn.system({
    "curl",
    "-Lo",
    archive,
    -- "https://github.com/indygreg/python-build-standalone/releases/download/20240107/cpython-3.11.7+20240107-i686-pc-windows-msvc-shared-install_only.tar.gz",
    "https://github.com/astral-sh/python-build-standalone/releases/download/20250106/cpython-3.13.1+20250106-i686-pc-windows-msvc-shared-install_only.tar.gz",
  })

  -- extract
  os.execute("tar -xf " .. archive .. " -C " .. tahvpath)

  -- remove archive
  os.remove(archive)

  vim.fn.system({
    tahvpath .. "\\python\\python.exe",
    "-m",
    "pip",
    "install",
    "pynvim",
  })
end

function M.setup()
  if not vim.uv.os_uname().sysname == "Windows_NT" then
    return
  end

  if not vim.uv.fs_stat(tahvpath) then
    os.execute("mkdir " .. tahvpath)
    download_npm()
    download_python()
  end

  vim.env.PATH = vim.env.PATH
    .. ";"
    .. tahvpath
    .. "\\node"
    .. ";"
    .. tahvpath
    .. "\\python"
  -- vim.env.PATH = tahvpath .. '\\python' .. ";" .. vim.env.PATH

  vim.g.python3_host_prog = tahvpath .. "\\python\\python.exe"
end

return M
