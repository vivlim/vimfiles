return {
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },
    {
        "Wansmer/treesj",
        keys = {
            "<space>m",
            "<space>j",
            "<space>s",
        },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("treesj").setup({})
        end,
    },
    {
        "stevearc/conform.nvim", -- formatter
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                -- Customize or remove this keymap to your liking
                "<leader>fr",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "FoRmat buffer",
            },
        },
        -- Everything in opts will be passed to setup()
        opts = {
            -- Define your formatters
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                javascript = { { "prettierd", "prettier" } },
            },
            format_on_save = function(bufnr)
                -- Disable with a global or buffer-local variable
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 500, lsp_fallback = true }
            end,
            -- Customize formatters
            formatters = {
                shfmt = {
                    prepend_args = { "-i", "2" },
                },
            },
        },
        init = function()
            -- If you want the formatexpr, here is the place to set it
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
            vim.api.nvim_create_user_command("FormatDisable", function(args)
                if args.bang then
                    -- FormatDisable! will disable formatting just for this buffer
                    vim.b.disable_autoformat = true
                else
                    vim.g.disable_autoformat = true
                end
            end, {
                desc = "Disable autoformat-on-save",
                bang = true,
            })
            vim.api.nvim_create_user_command("FormatEnable", function()
                vim.b.disable_autoformat = false
                vim.g.disable_autoformat = false
            end, {
                desc = "Re-enable autoformat-on-save",
            })
        end,
    },
}
