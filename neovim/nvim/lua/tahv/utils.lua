local M = {}

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
