return {
  {"boltlessengineer/bufterm.nvim",
    init = function()
      require('bufterm').setup()
      local term = require('bufterm.terminal')
      local ui   = require('bufterm.ui')

      local floating_term = term.Terminal:new({
      })

      vim.keymap.set({'n'}, '<space>tf', function()
        floating_term:spawn()
        ui.toggle_float(floating_term.bufnr)
      end, {
        desc = 'Toggle floating window with terminal buffers',
      })
      vim.keymap.set({'n'}, '<space>tt', '<cmd>:new<cr>:terminal<cr>', {
        desc = 'New window term',
      })
    end,
  },
  {"rebelot/terminal.nvim",
  lazy = false,
  enabled = false,
  init = function()
    local terminal = require("terminal")
    local wk = require("which-key")
    local term_map = require("terminal.mappings")
    wk.register({
      t = {
        name = "terminal",
        ["1"] = { function() term_map.set_target(1) end, "target 1"},
        ["2"] = { function() term_map.set_target(2) end, "target 2"},
        ["3"] = { function() term_map.set_target(3) end, "target 3"},
        ["4"] = { function() term_map.set_target(4) end, "target 4"},
        t = { function() term_map.run(vim.o.shell) end, "toggle terminal"},
        s = { function() term_map.operator_send{} end, "capture text -> terminal"},
        o = { function() term_map.toggle() end, "toggle terminal"},
        O = { function() term_map.toggle({ open_cmd = "enew" }) end, "toggle (enew) "},
        r = { function() term_map.run() end, "run"},
        R = { function() term_map.run(nil, { layout = { open_cmd = "enew" } }) end, "run (enew)"},
        k = { function() term_map.kill() end, "kill"},
        ["]"] = { function() term_map.cycle_next() end, "next"},
        ["["] = { function() term_map.cycle_prev() end, "prev"},
        l = { function() term_map.move({ open_cmd = "belowright vnew" }) end, "below right"},
        L = { function() term_map.move({ open_cmd = "botright vnew" }) end, "bot right"},
        h = { function() term_map.move({ open_cmd = "belowright new" }) end, "below right"},
        H = { function() term_map.move({ open_cmd = "botright new" }) end, "bot right"},
        f = { function() term_map.move({ open_cmd = "float" }) end, "float"},
      },
    }, { prefix = "<space>" })
    terminal.setup({})
  end,
},
  {"Vigemus/iron.nvim",
  enabled = false,
    init = function()
      local iron = require("iron.core")

      iron.setup {
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = {"zsh"}
            }
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require('iron.view').bottom(40),
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          send_motion = "<space>sc",
          visual_send = "<space>sc",
          send_file = "<space>sf",
          send_line = "<space>sl",
          send_until_cursor = "<space>su",
          send_mark = "<space>sm",
          mark_motion = "<space>mc",
          mark_visual = "<space>mc",
          remove_mark = "<space>md",
          cr = "<space>s<cr>",
          interrupt = "<space>s<space>",
          exit = "<space>sq",
          clear = "<space>cl",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      }

      -- iron also has a list of commands, see :h iron-commands for all available commands
      vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
      vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
      vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
      vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
    end,
  }
}
