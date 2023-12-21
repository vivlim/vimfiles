return {
{ "neovim/nvim-lspconfig",
    lazy = false,
    init = function()
        local lsp = require("lspconfig")
        -- suggested config from nvim-lspconfig
            -- Mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        local opts = { noremap=true, silent=true }
        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
            local wk = require("which-key")

            -- Mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "lsp: go declaration", noremap=true, silent=true, buffer=bufnr })
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "lsp: go definition", noremap=true, silent=true, buffer=bufnr })
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "lsp: hover", noremap=true, silent=true, buffer=bufnr })
            vim.keymap.set('i', '<C-k>', vim.lsp.buf.hover, { desc = "lsp: hover", noremap=true, silent=true, buffer=bufnr })
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "lsp: go implementation", noremap=true, silent=true, buffer=bufnr })
            vim.keymap.set('n', '<space>ls', vim.lsp.buf.signature_help, { desc = "lsp: sig help", noremap=true, silent=true, buffer=bufnr })
            vim.keymap.set('n', '<space>lK', vim.lsp.buf.hover, { desc = "lsp: hover (also K and c-k in ins)", noremap=true, silent=true, buffer=bufnr })
            vim.keymap.set('n', '<space>lq', vim.lsp.buf.add_workspace_folder, { desc = "lsp: + workspace folder", noremap=true, silent=true, buffer=bufnr })
            vim.keymap.set('n', '<space>wQ', vim.lsp.buf.remove_workspace_folder, { desc = "lsp: - workspace folder", noremap=true, silent=true, buffer=bufnr })
            vim.keymap.set('n', '<space>lw', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, { desc = "lsp: list workspace folders", noremap=true, silent=true, buffer=bufnr })
            vim.keymap.set('n', '<space>lD', vim.lsp.buf.declaration, { desc = "lsp: go declaration", noremap=true, silent=true, buffer=bufnr })
            vim.keymap.set('n', '<space>ld', vim.lsp.buf.definition, { desc = "lsp: go definition", noremap=true, silent=true, buffer=bufnr })
            vim.keymap.set('n', '<space>li', vim.lsp.buf.implementation, { desc = "lsp: go implementation", noremap=true, silent=true, buffer=bufnr })
            vim.keymap.set('n', '<space>lt', vim.lsp.buf.type_definition, { desc = "lsp: type def'n", noremap=true, silent=true, buffer=bufnr })
            vim.keymap.set('n', '<space>lR', vim.lsp.buf.rename, { desc = "lsp: rename", noremap=true, silent=true, buffer=bufnr })
            vim.keymap.set('n', '<space>la', vim.lsp.buf.code_action, { desc = "lsp: code actions", noremap=true, silent=true, buffer=bufnr })
            vim.keymap.set('n', '<space>lr', vim.lsp.buf.references, { desc = "lsp: references", noremap=true, silent=true, buffer=bufnr })
            vim.keymap.set('n', '<space>l/', ":Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "lsp: search ws symbols", noremap=true, silent=true, buffer=bufnr })
            -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts) -- disabled because vim.lsp.buf.formatting is nil (maybe I was partway through installing it??)

            -- label the prefix
            wk.register({
                l = {
                    name = "lsp",
                },
            }, { prefix = "<space>" })
        end

        lsp.nil_ls.setup{
            autostart = true,
            on_attach = on_attach,
            capabilities = capabilities
        }
        lsp.rust_analyzer.setup{
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                ["rust-analyzer"] = {}
            }
        }
        lsp.elixirls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "elixir-ls" }, -- This should be on the path if the project has a nix flake devshell & direnv configured.
        }
        lsp.lua_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            on_init = function(client)
                local path = client.workspace_folders[1].name
                if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
                client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                    Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                        vim.env.VIMRUNTIME
                        -- "${3rd}/luv/library"
                        -- "${3rd}/busted/library",
                        }
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                    }
                })

                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                end
                return true
            end
        }
    end,
},
{"nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "typescript", "html", "rust", "nix" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
},
{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  init = function()
    -- Disable virtual_text since it's redundant due to lsp_lines.
    vim.diagnostic.config({
        virtual_text = false,
    })
    vim.keymap.set(
        {'n'},
        "<space>ld",
        require("lsp_lines").toggle,
        { desc = "toggle diagnostic lines" }
    )

    require("lsp_lines").setup()
  end,
},
{"simrat39/symbols-outline.nvim",
    opts = {},
}
}
