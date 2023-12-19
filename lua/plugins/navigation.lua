return {
    { "nvim-telescope/telescope.nvim",
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            defaults = {
                layout_strategy = 'vertical',
                layout_config = {
                    vertical = {width = 0.8}
                },
            },
        },
    },
    { 'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },
    { "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        init = function()
            -- disable netrw
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            -- set termguicolors to enable highlight groups
            vim.opt.termguicolors = true

            local api = require "nvim-tree.api"
            vim.keymap.set('n', '-',
            function()
                api.tree.open({find_file = true})
            end)

            local function my_on_attach(bufnr)
                local api = require "nvim-tree.api"
                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                -- default mappings
                api.config.mappings.default_on_attach(bufnr)

                -- custom mappings
                -- vim.keymap
                vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
                vim.keymap.set('n', 'l',     api.node.open.edit,                  opts('Open'))
                vim.keymap.set('n', 'L',     api.node.open.horizontal,                  opts('Open: horizontal split'))
                vim.keymap.set('n', 'h',     api.node.navigate.parent_close,                  opts('Close directory'))
            end

            require("nvim-tree").setup {on_attach = my_on_attach}
        end,
    }
}