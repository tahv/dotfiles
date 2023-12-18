-- Highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching. 
return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
}
