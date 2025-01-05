-- Extended mapping for K
local function show_hover()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({ "vim", "help" }, filetype) then
        vim.cmd("h " .. vim.fn.expand("<cword>"))
    elseif vim.tbl_contains({ "man" }, filetype) then
        vim.cmd("Man " .. vim.fn.expand("<cword>"))
    elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
        require("crates").show_popup()
    else
        vim.lsp.buf.hover()
    end
end
vim.keymap.set("n", "K", show_hover, { desc = "lsp: hover", noremap = true, silent = true })
vim.keymap.set("i", "<C-k>", show_hover, { desc = "lsp: hover", noremap = true, silent = true })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local lsp_on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    local wk = require("which-key")

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set(
        "n",
        "gD",
        vim.lsp.buf.declaration,
        { desc = "lsp: go declaration", noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set(
        "n",
        "gd",
        vim.lsp.buf.definition,
        { desc = "lsp: go definition", noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set(
        "n",
        "gi",
        vim.lsp.buf.implementation,
        { desc = "lsp: go implementation", noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set(
        "n",
        "<space>ls",
        vim.lsp.buf.signature_help,
        { desc = "lsp: sig help", noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set(
        "n",
        "<space>lK",
        show_hover,
        { desc = "lsp: hover (also K and c-k in ins)", noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set(
        "n",
        "<space>lq",
        vim.lsp.buf.add_workspace_folder,
        { desc = "lsp: + workspace folder", noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set(
        "n",
        "<space>wQ",
        vim.lsp.buf.remove_workspace_folder,
        { desc = "lsp: - workspace folder", noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set("n", "<space>lw", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = "lsp: list workspace folders", noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set(
        "n",
        "<space>lD",
        vim.lsp.buf.declaration,
        { desc = "lsp: go declaration", noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set(
        "n",
        "<space>ld",
        vim.lsp.buf.definition,
        { desc = "lsp: go definition", noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set(
        "n",
        "<space>li",
        vim.lsp.buf.implementation,
        { desc = "lsp: go implementation", noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set(
        "n",
        "<space>lt",
        vim.lsp.buf.type_definition,
        { desc = "lsp: type def'n", noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set(
        "n",
        "<space>lR",
        vim.lsp.buf.rename,
        { desc = "lsp: rename", noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set(
        "n",
        "<space>la",
        vim.lsp.buf.code_action,
        { desc = "lsp: code actions", noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set(
        "n",
        "<space>lr",
        vim.lsp.buf.references,
        { desc = "lsp: references", noremap = true, silent = true, buffer = bufnr }
    )
    vim.keymap.set(
        "n",
        "<space>l/",
        ":Telescope lsp_dynamic_workspace_symbols<cr>",
        { desc = "lsp: search ws symbols", noremap = true, silent = true, buffer = bufnr }
    )
    -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts) -- disabled because vim.lsp.buf.formatting is nil (maybe I was partway through installing it??)

    -- label the prefix
    wk.register({
        l = {
            name = "lsp",
        },
    }, { prefix = "<space>" })
end

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        -- TODO: replace much of this with https://www.lazyvim.org/plugins/lsp
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        keys = {
            {"<space>e", function() vim.diagnostic.open_float() end, mode = "n", desc = "open diagnostic"},
            {"[d", function() vim.diagnostic.goto_prev() end, mode = "n", desc = "prev diagnostic"},
            {"]d", function() vim.diagnostic.goto_next() end, mode = "n", desc = "next diagnostic"},
            {"<space>q", function() vim.diagnostic.setloclist() end, mode = "n", desc = "diagnostic loc list"},
        },
        config = function()
            -- Install some lsps
            require("mason").setup()
            require("mason-lspconfig").setup()
            require("mason-lspconfig").setup_handlers {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function (server_name) -- default handler (optional)
                    local capabilities =
                        require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
                    require("lspconfig")[server_name].setup({
                        on_attach = lsp_on_attach,
                        capabilities = capabilities,
                    })
                end,
                -- Next, you can provide a dedicated handler for specific servers.
                ["nil_ls"] = function ()
                    local capabilities =
                        require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
                    require("lspconfig").nil_ls.setup({
                        on_attach = lsp_on_attach,
                        capabilities = capabilities,
                    })
                end,
                ["elixirls"] = function ()
                    local capabilities =
                        require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
                    require("lspconfig").elixirls.setup({
                        on_attach = lsp_on_attach,
                        capabilities = capabilities,
                        cmd = { "elixir-ls" }, -- This should be on the path if the project has a nix flake devshell & direnv configured.
                    })
                end,
                ["rust_analyzer"] = function ()
                    local capabilities =
                        require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
                    require("lspconfig").rust_analyzer.setup({
                        on_attach = lsp_on_attach,
                        capabilities = capabilities,
                    })
                end,
            }

            local capabilities =
                require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
            require("lspconfig").lua_ls.setup({
                on_attach = lsp_on_attach,
                capabilities = capabilities,
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if
                        not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc")
                    then
                        client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
                            Lua = {
                                runtime = {
                                    -- Tell the language server which version of Lua you're using
                                    -- (most likely LuaJIT in the case of Neovim)
                                    version = "LuaJIT",
                                },
                                -- Make the server aware of Neovim runtime files
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        vim.env.VIMRUNTIME,
                                        -- "${3rd}/luv/library"
                                        -- "${3rd}/busted/library",
                                    },
                                    -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                                    -- library = vim.api.nvim_get_runtime_file("", true)
                                },
                            },
                        })

                        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                    end
                    return true
                end,
            })

        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        -- build = ":TSUpdate",
        lazy = true,
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    "c",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "elixir",
                    "heex",
                    "javascript",
                    "typescript",
                    "html",
                    "rust",
                    "nix",
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        lazy = true,
        keys = {
            { "<space>ld", function() require("lsp_lines").toggle() end, mode = "n", desc = "toggle diagnostic lines", },
        },
        config = function()
            -- Disable virtual_text since it's redundant due to lsp_lines.
            vim.diagnostic.config({
                virtual_text = false,
            })

            require("lsp_lines").setup()
        end,
    },
    {
        "simrat39/symbols-outline.nvim",
        lazy = true,
        keys = {
            { "<space>S", "<cmd>:SymbolsOutline<CR>", desc = "tgl symbols outline" },
        },
        opts = {}
    },
    {
        "simrat39/rust-tools.nvim",
        lazy = true,
        event = {
            "BufEnter *.rs",
            "BufEnter Cargo.toml",
        },
        keys = {
            { "<space>VR", "", desc = "Activate rust-tools" },
        },
        opts = {
            tools = {
                hover_actions = {
                    auto_focus = true,
                },
            },
            server = {
                on_attach = function(client, bufnr)
                    local rt = require("rust-tools")
                    lsp_on_attach(client, bufnr)
                    vim.keymap.set(
                        "n",
                        "<space>R",
                        rt.runnables.runnables,
                        { desc = "rust: runnables", noremap = true, silent = true, buffer = bufnr }
                    )
                    vim.keymap.set(
                        "n",
                        "<space>lA",
                        ":RustHoverActions<cr>",
                        { desc = "rust: hover actions", noremap = true, silent = true, buffer = bufnr }
                    )
                    vim.keymap.set(
                        "n",
                        "<space>lC",
                        rt.open_cargo_toml.open_cargo_toml,
                        { desc = "rust: open cargo.toml", noremap = true, silent = true, buffer = bufnr }
                    )
                end,
            },
        },
    },
    {
        "j-hui/fidget.nvim",
        opts = {
            -- options
        },
    },
    {
        "saecki/crates.nvim",
        lazy = true,
        tag = "stable",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = {
            "BufEnter Cargo.toml",
        },
        config = function()
            local crates = require("crates")
            crates.setup({
                popup = {
                    autofocus = true,
                },
            })
            local group = vim.api.nvim_create_augroup("cargotoml_group", { clear = true })
            vim.api.nvim_create_autocmd("BufNew", {
                callback = function(ev)
                    -- for debugging: require('notify')(vim.inspect(ev))
                    require("which-key").register({
                        x = { name = "Cargo.toml specific" },
                    }, { prefix = "<space>", buffer = ev.buf })
                    vim.keymap.set(
                        "n",
                        "<space>xf",
                        crates.show_features_popup,
                        { desc = "crate features", noremap = true, silent = true, buffer = ev.buf }
                    )
                    vim.keymap.set(
                        "n",
                        "<space>xi",
                        crates.show_crate_popup,
                        { desc = "crate info", noremap = true, silent = true, buffer = ev.buf }
                    )
                    vim.keymap.set(
                        "n",
                        "<space>xv",
                        crates.show_versions_popup,
                        { desc = "crate versions", noremap = true, silent = true, buffer = ev.buf }
                    )
                    vim.keymap.set(
                        "n",
                        "<space>xD",
                        crates.show_dependencies_popup,
                        { desc = "crate dependencies", noremap = true, silent = true, buffer = ev.buf }
                    )
                    vim.keymap.set(
                        "n",
                        "<space>xu",
                        crates.update_crate,
                        { desc = "update (newest compatible)", noremap = true, silent = true, buffer = ev.buf }
                    )
                    vim.keymap.set(
                        "n",
                        "<space>xU",
                        crates.upgrade_crate,
                        { desc = "upgrade (newest)", noremap = true, silent = true, buffer = ev.buf }
                    )
                    vim.keymap.set(
                        "n",
                        "<space>xr",
                        crates.open_repository,
                        { desc = "www: go to repository", noremap = true, silent = true, buffer = ev.buf }
                    )
                    vim.keymap.set(
                        "n",
                        "<space>xw",
                        crates.open_homepage,
                        { desc = "www: go to homepage", noremap = true, silent = true, buffer = ev.buf }
                    )
                    vim.keymap.set(
                        "n",
                        "<space>xd",
                        crates.open_documentation,
                        { desc = "www: go to docs", noremap = true, silent = true, buffer = ev.buf }
                    )
                    vim.keymap.set(
                        "n",
                        "<space>xc",
                        crates.open_crates_io,
                        { desc = "www: go to crates.io", noremap = true, silent = true, buffer = ev.buf }
                    )
                end,
                group = group,
                pattern = "*Cargo.toml",
            })
        end,
    },
    {
        "nvim-lua/lsp-status.nvim",
    },
    {
        'stevearc/aerial.nvim',
        opts = {
            attach_mode = "global",
            open_automatic = true,
            show_guides = true,

            nav = {
                win_opts = {
                    winblend = 0,
                },
                autojump = true,
                keymaps = {
                    ["<CR>"] = "actions.jump",
                    ["<2-LeftMouse>"] = "actions.jump",
                    ["<C-v>"] = "actions.jump_vsplit",
                    ["<C-s>"] = "actions.jump_split",
                    ["h"] = "actions.left",
                    ["l"] = "actions.right",
                    ["<C-c>"] = "actions.close",
                    ["<ESC>"] = "actions.close",
                },
            },
        },
        keys = {
            {"<space>lo", "<cmd>AerialToggle<cr>", mode = "n", desc = "aerial.nvim outline"},
            {"<C-j>", "<cmd>AerialNext<cr>", mode = "n", desc = "aerial.nvim next symbol"},
            {"<C-k>", "<cmd>AerialPrev<cr>", mode = "n", desc = "aerial.nvim prev symbol"},
            {"<space>ln", "<cmd>AerialNavToggle<cr>", mode = "n", desc = "aerial.nvim nav"},
            {"<space>s", function() require("telescope").extensions.aerial.aerial() end, mode = "n", desc = "telescope aerial symbols"},
        },
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    },
    {
        "lewis6991/hover.nvim",
        keys = {
            {"K", function() require("hover").hover() end, mode = "n", desc = "open hover.nvim"},
            {"<MouseMove>", function() require("hover").hover_mouse() end, mode = "n", desc = "hover.nvim (mouse)"},
            {"<C-k>", function() require("hover").hover() end, mode = "i", desc = "open hover.nvim"},
            {"gK", function() require("hover").hover_select() end, mode = "n", desc = "hover.nvim (select source)"},
        },
        config = function()
            require("hover").setup {
                init = function()
                    -- Require providers
                    require("hover.providers.lsp")
                    -- require('hover.providers.gh')
                    -- require('hover.providers.gh_user')
                    -- require('hover.providers.jira')
                    -- require('hover.providers.dap')
                    require('hover.providers.fold_preview')
                    require('hover.providers.diagnostic')
                    require('hover.providers.man')
                    require('hover.providers.dictionary')
                end,
                preview_opts = {
                    border = 'single'
                },
                -- Whether the contents of a currently open hover window should be moved
                -- to a :h preview-window when pressing the hover keymap.
                preview_window = true,
                title = true,
                mouse_providers = {
                    'LSP'
                },
                mouse_delay = 400
            }
        end
    }
}
