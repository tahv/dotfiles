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

---@param diagnostic vim.Diagnostic
---@return string
function M.format_diagnostic(diagnostic)
    local text = ""

    if diagnostic.code then
        text = text .. string.format("[%s] ", diagnostic.code)
    end

    if diagnostic.source then
        text = text .. string.format("%s: ", diagnostic.source)
    end

    return text .. diagnostic.message
end

return M
