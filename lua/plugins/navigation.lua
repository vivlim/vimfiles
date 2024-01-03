return {
    { "nvim-telescope/telescope.nvim",
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
        },
        init = function()
            local telescope = require("telescope")
            telescope.setup {
                extensions = {
                    whaler = {
                        -- Whaler configuration
                        directories = { ".", },
                        theme = {
                            layout_strategy = "center",
                            layout_config = {
                                height = 0.3,
                                width = 0.9,
                            },
                        },
                    },
                },
            }
            telescope.load_extension("whaler")

            vim.keymap.set("n", '<space>W', function()
                telescope.extensions.whaler.whaler({
                        theme = {
                            layout_strategy = "center",
                            layout_config = {
                                height = 0.7,
                                width = 0.3,
                            },
                        },
                    })
            end, { desc = 'correct size' })
            vim.keymap.set("n", '<space>w', ":Telescope whaler<cr>", { desc = 'wrong size' })
        end,
    },
    { "SalOrak/whaler.nvim" },
}
