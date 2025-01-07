return {
    "tpope/vim-fugitive",
    {
        "rhysd/git-messenger.vim",
        lazy = true,
        keys = {
            {
                "<space>gm",
                "<cmd>GitMessenger<cr>",
                mode = "n",
                desc = "Show commit msg",
            },
        },
    },
    {
        "aaronhallaert/advanced-git-search.nvim",
        lazy = true,
        keys = {
            {
                "<space>g",
                ":'<,'>AdvancedGitSearch diff_commit_line<cr>",
                mode = "v",
                desc = "git line history",
            },
            {
                "<space>g/",
                ":AdvancedGitSearch search_log_content<cr>",
                mode = "n",
                desc = "search git history msgs",
            },
            {
                "<space>g?",
                ":AdvancedGitSearch search_log_content_file<cr>",
                mode = "n",
                desc = "search git history by content",
            },
            {
                "<space>fg/",
                ":AdvancedGitSearch diff_commit_file<cr>",
                mode = "n",
                desc = "git file history telescope",
            },
            {
                "<space>fgb",
                ":AdvancedGitSearch diff_branch_file<cr>",
                mode = "n",
                desc = "git diff file with other branch",
            },
        },
        config = function()
            -- optional: setup telescope before loading the extension
            require("telescope").setup({
                -- move this to the place where you call the telescope setup function
                extensions = {
                    advanced_git_search = {
                        diff_plugin = "diffview",
                    },
                },
            })

            require("telescope").load_extension("advanced_git_search")
        end,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            -- to show diff splits and open commits in browser
            "tpope/vim-fugitive",
            -- to open commits in browser with fugitive
            "tpope/vim-rhubarb",
            -- optional: to replace the diff from fugitive with diffview.nvim
            -- (fugitive is still needed to open in browser)
            "sindrets/diffview.nvim",
        },
    },
    {
        "sindrets/diffview.nvim",
        lazy = false,
        keys = {
            { "<space>fgh", ":DiffviewFileHistory %<cr>", mode = "n", desc = "git file history diffview" },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        keys = {
            {
                '[c',
                function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        require('gitsigns').nav_hunk('prev')
                    end
                end,
                mode = 'n',
                desc = 'prev hunk/change',
            },
            {
                ']c',
                function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        require('gitsigns').nav_hunk('next')
                    end
                end,
                mode = 'n',
                desc = 'next hunk/change',
            },
        },
        config = function()
            require('gitsigns').setup {
                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Actions
                    map('n', '<leader>hs', gitsigns.stage_hunk)
                    map('n', '<leader>hr', gitsigns.reset_hunk)
                    map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
                    map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
                    map('n', '<leader>hS', gitsigns.stage_buffer)
                    map('n', '<leader>hu', gitsigns.undo_stage_hunk)
                    map('n', '<leader>hR', gitsigns.reset_buffer)
                    map('n', '<leader>hp', gitsigns.preview_hunk)
                    map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end)
                    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                    map('n', '<leader>hd', gitsigns.diffthis)
                    map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
                    map('n', '<leader>td', gitsigns.toggle_deleted)

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end
            }
        end
    },
}
