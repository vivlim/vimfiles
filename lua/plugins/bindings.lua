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
                F = { "(todo: find file in path)" },
                g = { "(todo: git-tracked files?)" },
                ["/"] = { function() ts.live_grep{} end, "live grep" },
                t = { ":NvimTreeToggle<cr>", "file tree" },
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
            [":"] = { function() ts.builtin{} end, "telescope pickers" },
        }, { prefix = "<space>" })
        end,
    },

}
