return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        lazy = true,
        keys = {
            {"<space>ff", function() require("telescope.builtin").find_files({}) end, mode = "n", desc = "find file"},
            {"<space>fb", "<cmd>Telescope file_browser<cr>", mode = "n", desc = "ts file browser"},
            {"<space>f/", function() require("telescope.builtin").live_grep({}) end, mode = "n", desc = "live grep"},
            {"<space>rf", function() require("telescope.builtin").oldfiles({}) end, mode = "n", desc = "files"},
            {"<space>r:", function() require("telescope.builtin").command_history({}) end, mode = "n", desc = "commands"},
            {"<space>r/", function() require("telescope.builtin").search_history({}) end, mode = "n", desc = "searches"},
            {"<space>/", function() require("telescope.builtin").current_buffer_fuzzy_find({}) end, mode = "n", desc = "current buffer fzf"},
            {"<space>b", function() require("telescope.builtin").buffers({}) end, mode = "n", desc = "telescope buffers"},
            {"<space>d", function() require("telescope.builtin").diagnostics({}) end, mode = "n", desc = "telescope diagnostics"},
            {"<space><space>", function() require("telescope.builtin").resume({}) end, mode = "n", desc = "telescope resume"},
            {"<space>:", function() require("telescope.builtin").builtin({}) end, mode = "n", desc = "telescope pickers"},
            -- notify history - i switched plugins so this doesn't work atm {"<space>Nn", function() require("telescope").extensions.notify.notify() end, mode = "n", desc = "telescope pickers"},
            {"<space>g?", function() require("telescope.builtin").git_commits({}) end, mode = "n", desc = "telescope commits"},
            {"<space>g/", function() require("telescope.builtin").git_bcommits({}) end, mode = "n", desc = "telescope buffer commits"},
            {"<space>gb", function() require("telescope.builtin").git_branches({}) end, mode = "n", desc = "telescope branches"},
        },
        config = function()
            local telescope = require("telescope")
            local whaler_oneoff_directories = { { path = vim.fs.dirname(os.getenv("MYVIMRC")), alias = "nvim" } }
            -- Don't assume that HOME is always set, it might not be on windows.
            local home_dir = os.getenv("HOME")
            if home_dir ~= nil then
                local project_dir_file = vim.fn.resolve(home_dir .. "/.nvim_project_dirs.lua")
                if vim.fn.filereadable(project_dir_file) == 1 then
                    vim.list_extend(whaler_oneoff_directories, dofile(project_dir_file))
                end
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
        "ggandor/leap.nvim", -- https://github.com/ggandor/leap.nvim
        config = function()
            local leap = require("leap")
            local modes = { "n", "x", "o" }
            leap.add_default_mappings()
            vim.keymap.set(modes, "s", "<Plug>(leap-forward-to)")
            vim.keymap.set(modes, "S", "<Plug>(leap-backward-to)")
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        lazy = true,
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    },
    {
        "SalOrak/whaler.nvim",
        keys = {
        },
        config = function()
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    {
        'stevearc/stickybuf.nvim',
        opts = {},
    },
}
