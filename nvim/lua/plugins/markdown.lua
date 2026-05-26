return {
  {
    -- A hackable markdown, Typst, latex, html(inline) & Asciidoc previewer
    "OXY2DEV/markview.nvim",
    enabled = true,
    lazy = false,
    -- Completion for `blink.cmp`
    -- dependencies = { "saghen/blink.cmp" },
    ---@type markview.config
    opts = {
      preview = {
        icon_provider = "devicons",
        debounce = 0,
        enable = false,
        enable_hybrid_mode = false,
        hybrid_modes = { "n", "no", "c" },
        linewise_hybrid_mode = true,
        edit_range = { 0, 0 },
      },
      markdown = {
        headings = {
          heading_1 = { icon_hl = "@markup.link", icon = "[%d] " },
          heading_2 = { icon_hl = "@markup.link", icon = "[%d.%d] " },
          heading_3 = { icon_hl = "@markup.link", icon = "[%d.%d.%d] " },
        },
      },
    },
    keys = {
      { "<leader>tm", ":Markview toggle<CR>", desc = "toggle render [m]arkdown" },
    },
  },
  {
    -- Improve viewing Markdown files
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
    lazy = true,
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      enabled = false,
      render_modes = { "n", "c", "t" },
      nested = false,
      -- completions = { lsp = { enabled = true } },
    },
    dependencies = {
      "nvimq-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>tm", ":RenderMarkdown toggle<CR>", desc = "toggle render [m]arkdown" },
    },
  },
  {
    -- Preview Markdown, HTML, AsciiDoc, SVG files in a web browser with live updates.
    "brianhuster/live-preview.nvim",
    lazy = true,
    cmd = { "LivePreview" },
    opts = {
      address = "127.0.0.1",
      port = 5500,
    },
    keys = {
      { "<leader>tp", ":LivePreview start<CR>", desc = "live [p]review current file" },
      { "<leader>tP", ":LivePreview pick<CR>", desc = "select and live [p]review file" },
    },
  },
  {
    -- Preview Markdown in browser with synchronised scrolling
    "iamcco/markdown-preview.nvim",
    enabled = false,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    -- https://github.com/iamcco/markdown-preview.nvim/issues/690
    build = ":call mkdp#util#install()",
  },
}
