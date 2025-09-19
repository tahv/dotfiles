local M = {}
local iswin = vim.fn.has('win32') == 1

---Returns path to the user subdirectory under the |standard-path| directory.
---Directory is automatically created if it doesn't exist.
---@param what 'cache'|'config'|'data'|'log'|'run'|'state'
---@return string
local function user_stdpath(what)
  local user = "tahv"
  local dir = vim.fs.joinpath(vim.fn.stdpath(what), user)
  if not vim.uv.fs_stat(dir) then
    vim.fn.mkdir(dir, "p")
  end
  return dir
end

---@param url string
---@param file string
local function download_file(url, file)
  vim.fn.system({ "curl", "-Lo", file, url })
  vim.notify("Downloaded `" .. file .. "`", vim.log.levels.INFO)
end

---@param path string
local function normpath_backslash(path)
  return vim.fs.normalize(path):gsub("/", "\\")
end

---Returns the path to `7zr.exe`.
---Download it if necessary.
---@return string
local function get_7z_exe()
  local exe = vim.fs.joinpath(user_stdpath('cache'), "7zr.exe")
  if not vim.uv.fs_stat(exe) then
    download_file("https://www.7-zip.org/a/7zr.exe", exe)
  end
  return exe
end

---Extract a `.7z` archive to `outdir`.
---@param archive string
---@param outdir string
local function extract_7z_archive(archive, outdir)
  outdir = normpath_backslash(outdir)
  archive = normpath_backslash(archive)
  local exe_7z = get_7z_exe()
  if not vim.uv.fs_stat(outdir) then
    vim.fn.mkdir(outdir, "p")
  end
  os.execute(exe_7z .. " x " .. archive .. " -o" .. outdir)
end

-- Setup python with uv and venv
-- https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
-- https://neovim.io/doc/user/provider.html

M.user_stdpath = user_stdpath
M.download_file = download_file
M.extract_7z_archive = extract_7z_archive

return M
