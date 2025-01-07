return {
    {
        "folke/which-key.nvim",
        lazy = false,
        config = function()
            local wk = require("which-key")

            wk.setup({
                notify = false, -- don't warn about issues with mappings; use :checkhealth which-key manually
            })
            wk.register({
                f = {
                    name = "file",
                    F = { "(todo: find file in path)" },
                    g = { "(todo: git-tracked files?)" },
                },
                r = {
                    name = "recent",
                },
                g = {
                    name = "git",
                    --["?"] = { function() ts.git_commits{} end, "fzf commits" },
                    --["/"] = { function() ts.git_bcommits{} end, "fzf buffer commits" },
                    --Q = { ":Gllog --source --all -i -G ", "get commits with changes matching regex" },
                    --b = { function() ts.git_branches{} end, "fzf branches" },
                },
                N = {
                    name = "nvim meta",
                    t = { name = "plugin traces" },
                },
                p = {
                    name = "projects (whaler)",
                },
            }, { prefix = "<space>" })
        end,
        keys = {
            {
                "<c-w><space>",
                function()
                    require('which-key').show({
                        keys = "<c-w>",
                        loop = true,
                    })
                end,
                mode = { "n", "t" },
                desc = "loop",

            },
        },
    },
}
