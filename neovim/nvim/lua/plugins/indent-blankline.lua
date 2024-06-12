---@type LazySpec[]
return {
  -- Indent guides.
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@type ibl.config.full
  opts = {
    indent = {
      char = "▏",
    },
    scope = {
      show_start = false,
      show_end = false,
    },
  },
}
