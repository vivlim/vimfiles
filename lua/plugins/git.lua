return {
    "tpope/vim-fugitive",
    "rhysd/git-messenger.vim",
    {
        "aaronhallaert/advanced-git-search.nvim",
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

            vim.keymap.set(
                "v",
                "<space>g",
                ":'<,'>AdvancedGitSearch diff_commit_line<cr>",
                { desc = "git line history" }
            )
            vim.keymap.set(
                "n",
                "<space>g/",
                ":AdvancedGitSearch search_log_content<cr>",
                { desc = "search git history msgs" }
            )
            vim.keymap.set(
                "n",
                "<space>g?",
                ":AdvancedGitSearch search_log_content_file<cr>",
                { desc = "search git history by content" }
            )
            vim.keymap.set(
                "n",
                "<space>fg/",
                ":AdvancedGitSearch diff_commit_file<cr>",
                { desc = "git file history telescope" }
            )
            vim.keymap.set(
                "n",
                "<space>fgb",
                ":AdvancedGitSearch diff_branch_file<cr>",
                { desc = "git diff file with other branch" }
            )
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
        config = function()
            require("diffview").setup({})
            vim.keymap.set("n", "<space>fgh", ":DiffviewFileHistory %<cr>", { desc = "git file history diffview" })
        end,
    },
}
