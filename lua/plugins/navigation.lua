return {
    { "nvim-telescope/telescope.nvim",
        tag = '0.1.5',
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            'nvim-lua/plenary.nvim',
        },
        init = function()
            local telescope = require("telescope")
            telescope.setup {
                defaults = {
                    layout_strategy = 'vertical',
                    layout_config = {
                        vertical = {width = 0.8}
                    },
                },
                extensions = {
                },
            }
        end,
    },
    { 'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },
    { "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        enabled = true,
        dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        init = function()
            local neotree = require("neo-tree")
            neotree.setup {
                enable_git_status = true,
                enable_diagnostics = true,
                use_libuv_file_watcher = true,
                sources = {
                    "filesystem",
                    "buffers",
                    "git_status",
                    "document_symbols",
                },
                filesystem = {
                    hijack_netrw_behavior = "open_current",
                    follow_current_file = {
                        enabled = true,
                        leave_dirs_open = false,
                    },
                    window = {
                        mappings = {
                            ["i"] = "run_command",
                        },
                    },
                    commands = {
                        run_command = function(state)
                            local node = state.tree:get_node()
                            local path = node:get_id()
                            vim.api.nvim_input(": " .. path .. "<Home>")
                        end,
                    },
                },
                window = {
                    mappings = {
                        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = false } },
                        ["h"] = function(state)
                            local node = state.tree:get_node()
                            if node.type == 'directory' and node:is_expanded() then
                            require'neo-tree.sources.filesystem'.toggle_directory(state, node)
                            else
                            require'neo-tree.ui.renderer'.focus_node(state, node:get_parent_id())
                            end
                        end,
                        ["l"] = function(state)
                            local node = state.tree:get_node()
                            if node.type == 'directory' then
                            if not node:is_expanded() then
                                require'neo-tree.sources.filesystem'.toggle_directory(state, node)
                            elseif node:has_children() then
                                require'neo-tree.ui.renderer'.focus_node(state, node:get_child_ids()[1])
                            end
                            end
                        end,
                    }
                },
                source_selector = {
                    winbar = true,
                    sources = {
                        { source = "filesystem" },
                        { source = "buffers" },
                        { source = "git_status" },
                        { source = "document_symbols" },
                    },
                },
            }
        end,
    },
    { "nvim-tree/nvim-tree.lua",
        enabled = false,
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
    },
    {
        "ggandor/leap.nvim", -- https://github.com/ggandor/leap.nvim
        init = function()
            local leap = require('leap')
            local modes = {'n', 'x', 'o'}
            leap.add_default_mappings()
            vim.keymap.set(modes, 's', '<Plug>(leap-forward-to)')
            vim.keymap.set(modes, 'S', '<Plug>(leap-backward-to)')
        end,
    }
}
