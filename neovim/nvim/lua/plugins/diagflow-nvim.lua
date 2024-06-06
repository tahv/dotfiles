-- LSP diagnostics in virtual text at the top right of your screen

---@param diagnostic vim.Diagnostic
---@return string
local function format_diagnostic(diagnostic)
    local text = ""

    if diagnostic.code then
        text = text .. string.format("[%s] ", diagnostic.code)
    end

    if diagnostic.source then
        text = text .. string.format("%s: ", diagnostic.source)
    end

    return text .. diagnostic.message
end

return {
    "dgagn/diagflow.nvim",
    event = "LspAttach",
    opts = {
        scope = "line",
        padding_right = 1,
        format = format_diagnostic,
    },
}
