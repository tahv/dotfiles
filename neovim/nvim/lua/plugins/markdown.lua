---@type LazySpec[]
return {
  {
    -- Improve viewing Markdown files
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>tm", ":RenderMarkdown toggle<CR>", desc = "[T]oggle render [M]arkdown" },
    },
  },
  {
    -- Preview Markdown in browser with synchronised scrolling
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
