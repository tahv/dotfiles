-- Neovim plugin to remove buffers.

local function delete_buffer()
  require("mini.bufremove").delete(0, false)
end

local function force_delete_buffer()
  require("mini.bufremove").delete(0, true)
end

return {
  "echasnovski/mini.bufremove",
  version = "*",
  keys = {
    { "<leader>bd", delete_buffer, desc = "[b]uffer [d]elete" },
    { "<leader>bD", force_delete_buffer, desc = "[b]uffer [D]elete (force)" },
  },
}
