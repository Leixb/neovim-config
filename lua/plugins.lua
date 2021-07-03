return require('packer').startup({function(use, use_rocks)
    use 'wbthomason/packer.nvim'

    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use {'norcalli/nvim-colorizer.lua', config = function() require'colorizer'.setup() end }

    use 'itchyny/lightline.vim'
    use 'mengelbrecht/lightline-bufferline'

    use 'bluz71/vim-nightfly-guicolors'

    use 'dense-analysis/ale'

    use 'nvim-lua/completion-nvim'
    use {'nvim-lua/telescope.nvim', config = function()
        local actions = require('telescope.actions')

        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        ["<c-k>"] = actions.move_selection_previous,
                        ["<c-j>"] = actions.move_selection_next,
                        ["<c-d>"] = actions.close,
                    },
                },
            }
        }
    end}

    use {'RishabhRD/nvim-lsputils', requires = 'RishabhRD/popfix', config = function()
        vim.lsp.handlers['textDocument/codeAction']     = require'lsputil.codeAction'.code_action_handler
        vim.lsp.handlers['textDocument/references']     = require'lsputil.locations'.references_handler
        vim.lsp.handlers['textDocument/definition']     = require'lsputil.locations'.definition_handler
        vim.lsp.handlers['textDocument/declaration']    = require'lsputil.locations'.declaration_handler
        vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
        vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
        vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
        vim.lsp.handlers['workspace/symbol']            = require'lsputil.symbols'.workspace_handler
    end}

    use {'norcalli/snippets.nvim', requires = 'hrsh7th/vim-vsnip',
        config = function() require'snippets'.use_suggested_mappings() end}

    use 'jiangmiao/auto-pairs'

    use {'nvim-treesitter/nvim-treesitter', config = function()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = 'all',
            highlight = {
                enable = true,
            },
        }
    end}

    use {'simrat39/rust-tools.nvim', after = "lsp-status.nvim",
        ft = { "rust" }, event = { "BufEnter Cargo.toml" },
        config = function()
            local rust_opts = {
                tools = {
                    autoSetHints = true,
                    hover_with_actions = true,
                    runnables = { use_telescope = true },

                    inlay_hints = {
                        show_parameter_hints = true,
                    },
                },
                server = {},
            }

            require('rust-tools').setup(rust_opts)
        end
    }

    use {'sebdah/vim-delve',             ft = "go" }
    use {'lervag/vimtex',                ft = {"tex", "latex"}}
    use {'dart-lang/dart-vim-plugin',    ft = "dart"}
    use {'JuliaEditorSupport/julia-vim', disable = true} -- , ft = "julia" -- does not load lazyly properly
    use {'dag/vim-fish',                 ft = "fish"}

    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-apathy'
    use 'tpope/vim-eunuch'

    use { 'junegunn/vim-easy-align', cmd = "EasyAlign" }

    use {'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = function() require('gitsigns').setup() end}

    use 'tpope/vim-fugitive'
    use {'tpope/vim-rhubarb', cmd = 'GBrowse'}
    use {'junegunn/gv.vim', cmd = "GV"}

    use 'editorconfig/editorconfig-vim'

    use {'rhysd/vim-grammarous', cmd = {"GrammarousCheck"}, } -- ft = {"markdown", "tex", "latex", "text"},

    use 'neovim/nvim-lspconfig'
    use {'nvim-lua/lsp-status.nvim', after = 'nvim-lspconfig', config = function()
--------------------------------------------------------------------------------
-- LSP config
--------------------------------------------------------------------------------
        local lspconfig = require('lspconfig')
        local lsp_status = require('lsp-status')

        lsp_status.config{
            status_symbol = '',
        }

        lsp_status.register_progress()

        local function lsp_attach(client)
            lsp_status.on_attach(client)
        end

        local lsp_list = {
            -- 'bashls', -- high CPU usage...
            'clangd',
            'cssls',
            'dartls',
            'dockerls',
            'gopls',
            -- 'hls',
            'html',
            'jdtls',
            'jsonls',
            'julials',
            -- 'kotlin_language_server',
            'pyls',
            'r_language_server',
            -- 'rls',
            'texlab',
            'tsserver',
            'vimls',
            'yamlls',
        }

        for _,val in pairs(lsp_list) do
            lspconfig[val].setup{ on_attach = lsp_attach, capabilities = lsp_status.capabilities }
        end

        local probeLoc = vim.fn.system('npm root -g')
        local probeNg = "/home/leix/.asdf/installs/nodejs/lts/.npm/lib/node_modules"
        lspconfig.angularls.setup{
            on_attach = lsp_attach,
            capabilities = lsp_status.capabilities,
            cmd = {"ngserver", "--stdio", "--tsProbeLocations", probeLoc , "--ngProbeLocations", probeNg},
        }

        local system_name
        if vim.fn.has("mac") == 1 then
            system_name = "macOS"
        elseif vim.fn.has("unix") == 1 then
            system_name = "Linux"
        elseif vim.fn.has('win32') == 1 then
            system_name = "Windows"
        else
            print("Unsupported system for sumneko")
        end

        local sumneko_root_path = vim.fn.stdpath('cache')..'/nvim_lsp/sumneko_lua/lua-language-server'
        local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

        lspconfig.sumneko_lua.setup{
            cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
            on_attach = lsp_attach,
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT', path = vim.split(package.path, ';'), },
                    completion = { keywordSnippet = 'Disable', },
                    diagnostics = { enable = true, globals = {
                        'vim', 'describe', 'it', 'before_each', 'after_each' },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                        }
                    }
                }
            },
            capabilities = lsp_status.capabilities,
        }

        function _G.status()
            if #vim.lsp.buf_get_clients() > 0 then
                return require'lsp-status'.status()
            end
            return ''
        end
    end}

end,

--------------------------------------------------------------------------------
-- Packer config
--------------------------------------------------------------------------------

config = {
    transitive_opt = true,
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end
    }
}
})
