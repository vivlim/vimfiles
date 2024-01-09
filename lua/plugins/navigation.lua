return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        init = function()
            local telescope = require("telescope")
            local whaler_oneoff_directories = { { path = vim.fs.dirname(os.getenv("MYVIMRC")), alias = "nvim" } }
            local project_dir_file = vim.fn.resolve(os.getenv("HOME") .. "/.nvim_project_dirs.lua")
            if vim.fn.filereadable(project_dir_file) == 1 then
                vim.list_extend(whaler_oneoff_directories, dofile(project_dir_file))
            end

            telescope.setup({
                defaults = {
                    layout_strategy = "vertical",
                    layout_config = {
                        vertical = { width = 0.8 },
                    },
                },
                extensions = { -- look here for more: https://github.com/nvim-telescope/telescope.nvim/wiki/Extensions
                    "ui-select",
                    cder = {
                        dir_command = {
                            "fd",
                            "--type=d",
                            "--hidden",
                            "--glob",
                            "--absolute-path",
                            ".git",
                            "$env:HOME/git",
                            "-x",
                            "echo",
                            '"{//}"',
                        },
                    },
                    whaler = {
                        theme = {
                            layout_strategy = "center",
                            layout_config = {
                                height = 0.7,
                                width = 0.7,
                            },
                        },
                        -- Whaler configuration
                        directories = { "~/git" },
                        -- directories that will not be searched for subdirectories
                        oneoff_directories = whaler_oneoff_directories,
                        file_explorer = "telescope_file_browser",
                    },
                    file_browser = {},
                },
            })
            telescope.load_extension("ui-select")
            telescope.load_extension("whaler")
            telescope.load_extension("file_browser")

            vim.keymap.set("n", "<space>pc", function()
                telescope.extensions.whaler.whaler({
                    auto_file_explorer = true,
                    auto_cwd = true,
                })
            end, { desc = "cd project" })
            vim.keymap.set("n", "<space>pp", function()
                telescope.extensions.whaler.whaler({
                    auto_file_explorer = true,
                    auto_cwd = true,
                    file_explorer_config = {
                        plugin_name = "telescope",
                        command = "Telescope find_files",
                        prefix_dir = " cwd=",
                    },
                })
            end, { desc = "cd project -> find_files" })
            vim.keymap.set("n", "<space>p/", function()
                telescope.extensions.whaler.whaler({
                    auto_file_explorer = true,
                    auto_cwd = true,
                    file_explorer_config = {
                        plugin_name = "telescope",
                        command = "Telescope live_grep",
                        prefix_dir = " cwd=",
                    },
                })
            end, { desc = "cd project -> live_grep" })
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },
    -- Use telescope for vim.ui.select, e.g. code actions
    {
        "nvim-neo-tree/neo-tree.nvim",
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
            local options = {
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
        "nvim-tree/nvim-tree.lua",
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

            local api = require("nvim-tree.api")
            vim.keymap.set("n", "-", function()
                api.tree.open({ find_file = true })
            end)

            local function my_on_attach(bufnr)
                local api = require("nvim-tree.api")
                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                -- default mappings
                api.config.mappings.default_on_attach(bufnr)

                -- custom mappings
                -- vim.keymap
                vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
                vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
                vim.keymap.set("n", "L", api.node.open.horizontal, opts("Open: horizontal split"))
                vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close directory"))
            end

            require("nvim-tree").setup({ on_attach = my_on_attach })
        end,
    },
    {
        "ggandor/leap.nvim", -- https://github.com/ggandor/leap.nvim
        init = function()
            local leap = require("leap")
            local modes = { "n", "x", "o" }
            leap.add_default_mappings()
            vim.keymap.set(modes, "s", "<Plug>(leap-forward-to)")
            vim.keymap.set(modes, "S", "<Plug>(leap-backward-to)")
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    },
    { "SalOrak/whaler.nvim" },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
}
