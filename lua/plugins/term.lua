return {
  {"boltlessengineer/bufterm.nvim",
    init = function()
      -- no line numbers in terminals.
      vim.api.nvim_command("autocmd TermOpen * setlocal nonumber")

      require('bufterm').setup()
      local term = require('bufterm.terminal')
      local ui   = require('bufterm.ui')

      local floating_term = term.Terminal:new({
      })

      local floating_lazygit = term.Terminal:new({
        cmd = "lazygit",
        auto_close = true,
        fallback_on_exit = true,
      })

      vim.keymap.set({'n', 't'}, '<C-t>', function()
        floating_term:spawn()
        ui.toggle_float(floating_term.bufnr)
        vim.api.nvim_set_option_value("number", false, {buf = floating_term.bufnr})
      end, {
        desc = 'Toggle floating window with terminal buffers',
      })
      vim.keymap.set({'n'}, '<space>tg', function()
        floating_lazygit:spawn()
        ui.toggle_float(floating_lazygit.bufnr)
        vim.api.nvim_set_option_value("number", false, {buf = floating_lazygit.bufnr})
      end, {
        desc = 'Floating Lazygit',
      })
      vim.keymap.set({'n'}, '<space>tt', '<cmd>:new<cr>:terminal<cr>', {
        desc = 'New window term',
      })
      vim.keymap.set({'n'}, '<space>tT', function()
        floating_term:spawn()
        vim.cmd('split')
        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(win, floating_term.bufnr)
      end, {
        desc = 'New win <- floating term',
      })

    end,
  },
  {"willothy/flatten.nvim", -- nvim launched from a nested term will instead open the file in the parent instance.
    config = true,
    priority = 1001,
  },
  {"rebelot/terminal.nvim",
  lazy = false,
  enabled = false,
  init = function()
    local terminal = require("terminal")
    local term_map = require("terminal.mappings")

    terminal.setup({})

    local lazygit = terminal.terminal:new({
        layout = { open_cmd = "float", height = 0.9, width = 0.9 },
        cmd = { "lazygit" },
        autoclose = false,
    })
    vim.env["EDITOR"] = "nvr -cc close -cc split --remote-wait +'set bufhidden=wipe'"
    vim.env["GIT_EDITOR"] = "nvr -cc close -cc split --remote-wait +'set bufhidden=wipe'"
    vim.api.nvim_create_user_command("Lazygit", function(args)
        lazygit.cwd = args.args and vim.fn.expand(args.args)
        lazygit:toggle(nil, true)
    end, { nargs = "?" })
    vim.keymap.set({'n'}, '<space>tg', '<cmd>:Lazygit<cr>', {
      desc = 'Toggle Lazygit term',
    })

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
  },
  "ii14/neorepl.nvim",
}
