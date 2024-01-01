return {
    { "folke/which-key.nvim",
    lazy = false,
    init = function()
        local wk = require("which-key")
        local ts = require("telescope.builtin")

        wk.setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
        wk.register({
            f = {
                name = "file",
                f = { function() ts.find_files{} end, "find file" },
                b = { ":Telescope file_browser<cr>", "ts file browser" },
                F = { "(todo: find file in path)" },
                g = { "(todo: git-tracked files?)" },
                ["/"] = { function() ts.live_grep{} end, "live grep" },
                t = { ":Neotree filesystem reveal=true position=left<cr>", "file tree" },
            },
            r = {
                name = "recent",
                f = { function() ts.oldfiles{} end, "files" },
                [":"] = { function() ts.command_history{} end, "commands" },
                ["/"] = { function() ts.search_history{} end, "searches" },
            },
            g = {
                name = "git",
                ["?"] = { function() ts.git_commits{} end, "fzf commits" },
                ["/"] = { function() ts.git_bcommits{} end, "fzf buffer commits" },
                Q = { ":Gllog --source --all -i -G ", "get commits with changes matching regex" },
                b = { function() ts.git_branches{} end, "fzf branches" },
            },
            ["/"] = { function() ts.current_buffer_fuzzy_find{} end, "current buffer fzf" },
            b = { function() ts.buffers{} end, "telescope buffers" },
            d = { function() ts.diagnostics{} end, "telescope diagnostics" },
            ["<space>"] = { function() ts.resume{} end, "telescope resume" },
            [":"] = { function() ts.builtin{} end, "telescope pickers" },
            N = {
                name = "nvim meta",
                n = { function() require('telescope').extensions.notify.notify() end, "notification history" },
                t = { name = "plugin traces" },
            },
        }, { prefix = "<space>" })
        end,
    },

}
