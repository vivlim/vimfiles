return {
    {"catppuccin/nvim", name = "catppuccin",
    init = function()
        require("catppuccin").setup({
                flavour = "mocha",
                term_colors = true,
                -- transparent_background = true,
                dim_inactive = {
                    enabled = false,
                    shade = "dark",
                    percentage = 0.05,
                },
                integrations = {
                    telescope = {
                        enabled = true,
                    },
                    nvimtree = true,
                    treesitter = true,
                    notify = true,
                },
                color_overrides = {
                    mocha = { -- these are copied from https://github.com/b-ggs/dotfiles/blob/becba14045586db9ee2becf39fbe07f0f8ae0a68/nvim/.config/nvim/init.vim#L203-L237
                        text = "#F4CDE9",
                        subtext1 = "#DEBAD4",
                        subtext0 = "#C8A6BE",
                        overlay2 = "#B293A8",
                        overlay1 = "#9C7F92",
                        overlay0 = "#866C7D",
                        surface2 = "#705867",
                        surface1 = "#5A4551",
                        surface0 = "#44313B",

                        base = "#352939",
                        mantle = "#211924",
                        crust = "#1a1016",
                    },
                },
        })
        vim.cmd.colorscheme "catppuccin"
    end },

    "itchyny/lightline.vim", -- status line
}

