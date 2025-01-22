local have_make = vim.fn.executable("make") == 1
local have_cmake = vim.fn.executable("cmake") == 1

---@type LazySpec[]
return {
  -- A highly extendable fuzzy finder over lists.
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      enabled = have_make or have_cmake,
      build = have_make and "make"
        or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    pcall(telescope.load_extension, "fzf") -- Enable telescope-fzf-native, if installed
  end,
  opts = function()
    local actions = require("telescope.actions")
    return {
      defaults = {
        path_display = { "truncate" },
        file_ignore_patterns = { "^.git[/\\]" },
        mappings = {
          i = {
            ["<C-u>"] = false, -- Remap scrolling up
            ["<C-d>"] = false, -- Remap scrolling down
            ["<C-Up>"] = actions.preview_scrolling_up,
            ["<C-Down>"] = actions.preview_scrolling_down,
          },
          n = {
            ["<C-Up>"] = actions.preview_scrolling_up,
            ["<C-Down>"] = actions.preview_scrolling_down,
          },
        },
      },
      pickers = {
        colorscheme = { enable_preview = true },
      },
    }
  end,
  -- TODO: lsp symbols kind filters (see how lazyvim do it)
  keys = {
    { "<leader><space>", "<cmd>Telescope buffers sort_mru=true<cr>", desc = "[ ] Search buffers" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy [S]earch current [B]uffer" },
    -- { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "[S]earch [C]ommands" },
    {
      "<leader>sc",
      function()
        require("telescope.builtin").git_commits({
          git_command = { "git", "log", "--pretty=%h %ad %an | %s", "--date=format:%d/%m %H:%M" },
        })
      end,
      desc = "[S]earch git [C]ommits (cwd)",
    },
    {
      "<leader>sC",
      function()
        require("telescope.builtin").git_bcommits({
          git_command = { "git", "log", "--pretty=%h %ad %an | %s", "--date=format:%d/%m %H:%M" },
        })
      end,
      desc = "[S]earch git [C]ommits (buffer)",
    },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "[S]earch document [D]iagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "[S]earch workspace [D]iagnostics" },
    { "<leader>sf", "<cmd>Telescope find_files hidden=true<cr>", desc = "[S]earch [F]iles" },
    { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "[S]earch [G]rep" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[S]earch [H]elp tags" },
    { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "[R]esume last search" },
    { "<leader>so", "<cmd>Telescope oldfiles only_cwd=true<cr>", desc = "[S]earch [O]ld files" },
    { "<leader>sO", "<cmd>Telescope vim_options<cr>", desc = "[S]earch vim [O]ptions" },
    { "<leader>sG", "<cmd>Telescope git_status<cr>", desc = "[S]earch [G]it status files" },
    -- { "<leader>sS", "<cmd>Telescope git_stash<cr>", desc = "[S]earch git [S]tash" },
  },
}
