return {
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            default_file_explorer = false,
            columns = {
                "icon",
                -- "permissions",
                -- "size",
                -- "mtime",
            },
            watch_for_changes = true,
            view_options = {
                show_hidden = true,
                case_insensitive = vim.fn.has("win32")
            },
        },
        keys = {
            {
                -- Customize or remove this keymap to your liking
                "_",
                "<cmd>Oil<cr>",
                mode = "n",
                desc = "edit dir with oil",
            },
        },
        -- Optional dependencies
        --dependencies = { { "echasnovski/mini.icons", opts = {} } },
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    }
}
