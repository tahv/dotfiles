-- https://github.com/seblyng/roslyn.nvim?tab=readme-ov-file#example
---@type vim.lsp.Config
return {
  settings = {
    ["csharp|symbol_search"] = {
      dotnet_search_reference_assemblies = true,
    },
    ["csharp|formatting"] = {
      dotnet_organize_imports_on_format = true,
    },
  },
}
