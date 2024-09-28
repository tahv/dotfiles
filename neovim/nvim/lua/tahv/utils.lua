local M = {}

---Protected 'require' call. Returns nil if 'modname' import failed.
---@param modname string
---@return nil | unknown
function M.prequire(modname)
  local status, mod = pcall(require, modname)
  if status then
    return mod
  end
  return nil
end

return M
