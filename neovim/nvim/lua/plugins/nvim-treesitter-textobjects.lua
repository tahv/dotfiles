-- Syntax aware text-objects, select, move, swap, and peek support.
return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  lazy = true,
  config = function ()
    require('nvim-treesitter.configs').setup({
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = { query = '@parameter.outer', desc = "Select outer part of a [P]arameter" },
            ['ia'] = { query = '@parameter.inner', desc = "Select [I]nner part of a [P]arameter" },
            ['af'] = { query = '@function.outer', desc = "Select outer part of a [F]unction" },
            ['if'] = { query = '@function.inner', desc = "Select [I]nner part of a [F]unction" },
            ['ac'] = { query = '@class.outer', desc = "Select outer part of a [C]]lass" },
            ['ic'] = { query = '@class.inner', desc = "Select [I]nner part of a [C]lass" },
          },
        },

        move = {
          enable = true,
          set_jumps = true, -- Add jumps in the jumplist
          goto_next_start = {
            [']m'] = { query = '@function.outer', desc = "Move to next function start"},
            [']]'] = { query = '@class.outer', desc = "Move to next class start"},
          },
          goto_next_end = {
            [']M'] = { query = '@function.outer', desc = "Move to next function end"},
            [']['] = { query = '@class.outer', desc = "Move to next class end"},
          },
          goto_previous_start = {
            ['[m'] = { query = '@function.outer', desc = "Move to previous function start"},
            ['[['] = { query = '@class.outer', desc = "Move to previous class start"},
          },
          goto_previous_end = {
            ['[M'] = { query = '@function.outer', desc = "Move to previous function end"},
            ['[]'] = { query = '@class.outer', desc = "Move to previous class end"},
          },
        },

        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = { query = '@parameter.inner', desc = "Swap Parameter with Next" }
          },
          swap_previous = {
            ['<leader>A'] = { query = '@parameter.inner', desc = "Swap Parameter with Previous" }
          },
        },

      },
    })
  end
}
