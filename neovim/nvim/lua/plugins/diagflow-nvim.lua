-- LSP diagnostics in virtual text at the top right of your screen
return {
    "dgagn/diagflow.nvim",
    event = "LspAttach",
    opts = {
        scope = "line",
        padding_right = 1,
        format = function(diag)
            if diag.code == nil then
                return diag.message
            end
            return string.format("[%s] %s", diag.code, diag.message)
        end,
    },
}
