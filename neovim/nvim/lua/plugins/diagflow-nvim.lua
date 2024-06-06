-- LSP diagnostics in virtual text at the top right of your screen
return {
    "dgagn/diagflow.nvim",
    event = "LspAttach",
    opts = {
        scope = "line",
        padding_right = 1,
        format = function(diagnostic)
            if diagnostic.code == nil then
                return diagnostic.message
            end
            return string.format("[%s] %s", diagnostic.code, diagnostic.message)
        end,
    },
}
