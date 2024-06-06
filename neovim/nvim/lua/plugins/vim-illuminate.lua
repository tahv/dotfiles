-- Automatically highlighting other uses of the word under the cursor
-- using either LSP, Tree-sitter, or regex matching.
return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  opts = {
    large_file_cutoff = 2000, -- number of lines at which to use large_file_overrides
    large_file_overrides = {
      providers = { "lsp" },
    },
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
  end
}
