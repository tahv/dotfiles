-- LSP diagnostics in virtual text at the top right of your screen
return {
    'dgagn/diagflow.nvim',
    event = 'LspAttach',
    opts = {
        scope = 'line',
        padding_right = 1,
    }
}
