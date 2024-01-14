local M = {}

local tahvpath = vim.fn.stdpath 'data' .. '/tahv'

local get_seven_zip = function ()
  local exe_path = tahvpath .. '7zip.exe'
  if not vim.loop.fs_stat(tahvpath) then
    vim.fn.system { 'curl', '-Lo', exe_path, 'https://www.7-zip.org/a/7zr.exe' }
  end
  return exe_path
end

-- install mingw64, contain a C compiler for tree-sitter
local download_mingw = function ()
  -- download
  local archive = tahvpath .. 'mingw64.7z'
  vim.fn.system {
    'curl',
    '-Lo',
    archive,
    'https://github.com/niXman/mingw-builds-binaries/releases/download/13.2.0-rt_v11-rev1/x86_64-13.2.0-release-win32-seh-ucrt-rt_v11-rev1.7z',
  }

  -- extract
  local seven_zip = get_seven_zip()
  os.execute( seven_zip .. ' x ' .. archive .. " -o" .. tahvpath)

  -- remove archive
  os.execute('del /f /q ' .. archive)
end

local download_npm = function ()
  -- download
  local archive = tahvpath .. 'node.7z'
  vim.fn.system {
    'curl',
    '-Lo',
    archive,
    'https://github.com/niXman/mingw-builds-binaries/releases/download/13.2.0-rt_v11-rev1/x86_64-13.2.0-release-win32-seh-ucrt-rt_v11-rev1.7z',
  }

  -- extract
  local seven_zip = get_seven_zip()
  os.execute( seven_zip .. ' x ' .. archive .. ' -o' .. tahvpath )
  os.execute( 'ren ' .. tahvpath .. '/node-v20.11.0-win-x64 node' )

  -- remove archive
  os.execute( 'del /f /q ' .. archive )
end

local download_python = function ()
  -- download
  local archive = tahvpath .. 'python.tar.gz'
  vim.fn.system {
    'curl',
    '-Lo',
    archive,
    'https://github.com/indygreg/python-build-standalone/releases/download/20240107/cpython-3.11.7+20240107-i686-pc-windows-msvc-shared-install_only.tar.gz',
  }

  -- extract
  os.execute('tar -xf ' .. archive .. ' -C ' .. tahvpath)

  -- remove archive
  os.execute('del /f /q ' .. archive)
end

function M.setup()
  -- TODO: argument 'force'
  if not vim.fn.has("win32") then
    return
  end

  if not vim.loop.fs_stat(tahvpath) then
    os.execute('mkdir ' .. tahvpath)
    download_mingw()
    download_npm()
    download_python()
  end

  vim.env.PATH = vim.env.PATH .. ';' .. tahvpath .. '/mingw64/bin'
  vim.env.PATH = vim.env.PATH .. ';' .. tahvpath .. '/node'
  vim.env.PATH = vim.env.PATH .. ';' .. tahvpath .. '/python'
end

return M
