return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        enabled = true,
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        keys = {
            {"<space>ft", ":Neotree filesystem reveal=true position=left<cr>", mode = "n", desc = "file tree"},
            --{"-", ":Neotree filesystem reveal=true position=current<cr>", mode = "n", desc = "file tree"},
        },
        config = function()
            local neotree = require("neo-tree")
            local options = {
                enable_git_status = true,
                enable_diagnostics = true,
                use_libuv_file_watcher = true,
                sources = {
                    "filesystem",
                    "buffers",
                    "git_status",
                },
                filesystem = {
                    -- hijack_netrw_behavior = "open_current", -- nah, using oil for this
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
                            if node.type == "directory" and node:is_expanded() then
                                require("neo-tree.sources.filesystem").toggle_directory(state, node)
                            else
                                require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
                            end
                        end,
                        ["l"] = function(state)
                            local node = state.tree:get_node()
                            if node.type == "directory" then
                                if not node:is_expanded() then
                                    require("neo-tree.sources.filesystem").toggle_directory(state, node)
                                elseif node:has_children() then
                                    require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
                                end
                            end
                        end,
                    },
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
            if GLOBAL_TRACE == true then
                -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Troubleshooting
                options.log_level = "trace"
                options.log_to_file = "neo-tree.log"
                vim.keymap.set("n", "<space>Ntt", function()
                    neotree.show_logs()
                end, { desc = "neo-tree trace log", noremap = true, silent = true })
            end
            neotree.setup(options)
        end,
    },
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            default_file_explorer = true,
            columns = {
                "icon",
                "permissions",
                "size",
                "mtime",
            },
            watch_for_changes = true,
            view_options = {
                show_hidden = true,
                case_insensitive = vim.fn.has("win32")
            },
        },
        keys = {
            {
                -- Customize or remove this keymap to your liking
                "-",
                "<cmd>Oil<cr>",
                mode = "n",
                desc = "edit dir with oil",
            },
        },
        -- Optional dependencies
        --dependencies = { { "echasnovski/mini.icons", opts = {} } },
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    }
}
