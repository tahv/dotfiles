local M = {}

function M.is_win() return vim.uv.os_uname().sysname:find("Windows") ~= nil end

---Returns path to the user subdirectory under the |standard-path| directory.
---Directory is automatically created if it doesn't exist.
---@param what 'cache'|'config'|'data'|'log'|'run'|'state'
---@return string
function M.user_stdpath(what)
  local user = "tahv"
  local dir = vim.fs.joinpath(vim.fn.stdpath(what), user)
  if not vim.uv.fs_stat(dir) then
    vim.fn.mkdir(dir, "p")
  end
  return dir
end

---List configured lsp under the `lsp/` directory.
---@return string[]
function M.configured_lsp()
  ---@type string[]
  local configured = {}
  for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
    -- keep tail (:t) and remove extension (:r)
    local name = vim.fn.fnamemodify(f, ":t:r")
    table.insert(configured, name)
  end
  return configured
end

---Returns elements in `a` that are not in `b`.
---@param a any[]
---@param b any[]
---@return any[]
function M.difference(a, b)
  local aa = {}
  for _, v in pairs(a) do
    aa[v] = true
  end
  for _, v in pairs(b) do
    aa[v] = nil
  end
  local ret = {}
  local n = 0
  for _, v in pairs(a) do
    if aa[v] then
      n = n + 1
      ret[n] = v
    end
  end
  return ret
end

---Remove the first item from the list whose value is equal to `value`.
---@param t table
---@param value any Value to remove
---@return boolean `true` if `value` was found in `t` and removed, `false` otherwise.
function M.tbl_remove(t, value)
  vim.validate("t", t, "table")
  for pos, v in pairs(t) do
    if v == value then
      table.remove(t, pos)
      return true
    end
  end
  return false
end

---@param url string
---@param file string
function M.download_file(url, file)
  M.info("Downloading " .. url)
  vim.fn.system({ "curl", "-Lo", file, url })
  M.info("Downloaded " .. url .. " to '" .. file .. "'")
end

---@param path string
local function normpath_backslash(path) return vim.fs.normalize(path):gsub("/", "\\") end

---Returns the path to `7zr.exe`. Download it if necessary.
---@return string
local function get_7z_exe()
  local exe = vim.fs.joinpath(M.user_stdpath("cache"), "7zr.exe")
  if not vim.uv.fs_stat(exe) then
    M.download_file("https://www.7-zip.org/a/7zr.exe", exe)
  end
  return exe
end

---Extract a `.7z` archive to `outdir`.
---@param archive string
---@param outdir string
function M.extract_7z_archive(archive, outdir)
  outdir = normpath_backslash(outdir)
  archive = normpath_backslash(archive)
  local exe_7z = get_7z_exe()

  if not vim.uv.fs_stat(outdir) then
    vim.fn.mkdir(outdir, "p")
  end

  M.info("Extracting '" .. archive .. "'")
  os.execute(exe_7z .. " x " .. archive .. " -o" .. outdir)
  M.info("Extracted " .. archive .. " to '" .. outdir .. "'")
end

-- Setup python with uv and venv
-- https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
-- https://neovim.io/doc/user/provider.html

---@param msg string|string[]
---@param schedule? boolean Schedule the echo call.
---@param level integer
function M.notify(msg, level, schedule)
  if schedule then
    vim.schedule(function() M.notify(msg, level, false) end)
    return
  end

  if type(msg) == "table" then
    msg = table.concat(msg, "\n")
  end

  if msg == "" then
    return
  end

  vim.notify(msg, level, { title = "tahv.config" })
end

---@param msg string|string[]
---@param schedule? boolean Schedule the echo call.
function M.info(msg, schedule) M.notify(msg, vim.log.levels.INFO, schedule) end

---@param msg string|string[]
---@param schedule? boolean Schedule the echo call.
function M.warn(msg, schedule) M.notify(msg, vim.log.levels.WARN, schedule) end

---@param msg string|string[]
---@param schedule? boolean Schedule the echo call.
function M.err(msg, schedule) M.notify(msg, vim.log.levels.ERROR, schedule) end

return M
