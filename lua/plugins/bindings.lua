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
                "<leader><leader>",
                function()
                    require('which-key').show({
                        keys = "<leader>",
                        loop = true,
                    })
                end,
                mode = { "n", },
                desc = "loop",

            },
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
            {
                "]<space>",
                function()
                    require('which-key').show({
                        keys = "]",
                        loop = true,
                    })
                end,
                mode = { "n", },
                desc = "loop",

            },
            {
                "[<space>",
                function()
                    require('which-key').show({
                        keys = "[",
                        loop = true,
                    })
                end,
                mode = { "n", },
                desc = "loop",
            },
        },
    },
    --    {
    --        "anuvyklack/hydra.nvim",
    --        lazy = false,
    --        --        keys = {
    --        --            {
    --        --                "<space>D",
    --        --                function()
    --        --                    require('hydra').activate({
    --        --                        name = "diff",
    --        --                        config = {
    --        --                            color = 'pink', -- persistent, see https://github.com/anuvyklack/hydra.nvim?tab=readme-ov-file#color
    --        --                        },
    --        --                        heads = {
    --        --                            { 'q', nil, { nowait = true } }, -- exit
    --        --                            { 'j',
    --        --                        },
    --        --
    --        --                        hint = {
    --        --                            type = "cmdline",
    --        --                        },
    --        --                    })
    --        --                end,
    --        --                mode = "n",
    --        --                desc = "Diff mode",
    --        --            }
    --        --        },
    --        config = function()
    --            local Hydra = require("hydra")
    --
    --            Hydra({
    --                name = 'Window',
    --                mode = { 'n', 't', },
    --                body = '<C-w>',
    --                heads = {
    --                    { 'h', },
    --                    { 'j', },
    --                    { 'k', },
    --                    { 'l', },
    --                    { 'H', },
    --                    { 'J', },
    --                    { 'K', },
    --                    { 'L', },
    --                    { '+', },
    --                    { '-', },
    --                    { '<', },
    --                    { '>', },
    --                }
    --            })
    --        end
    --    },
}
