--------------------------------------------------------------------------------
-- Bootstrap packer
--------------------------------------------------------------------------------

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.api.nvim_command 'packadd packer.nvim'
end

return require('packer').startup({function(use, use_rocks)
    use 'wbthomason/packer.nvim'

    use { 'famiu/nvim-reload', cmd = {'Restart', 'Reload'},
        config = function() require('conf.reload') end,
    }

    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'

    use 'tpope/vim-apathy'
    use 'tpope/vim-eunuch'

    use 'gennaro-tedesco/nvim-peekup'

    use { 'junegunn/vim-easy-align', cmd = "EasyAlign" }

    use 'editorconfig/editorconfig-vim'

    use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup() end }

    use {'norcalli/nvim-colorizer.lua', config = function() require'colorizer'.setup() end }

    -- Status lines
    use {
        {
            'glepnir/galaxyline.nvim',
            branch = 'main',
            config = function() require'conf.statusline' end,
            requires = {'kyazdani42/nvim-web-devicons', opt = true}
        },
        {
            -- 'akinsho/nvim-bufferline.lua',
            'romgrk/barbar.nvim',
            requires = {'kyazdani42/nvim-web-devicons', opt = true},
            -- config = function() require'conf.bufferline' end
        },
        {
            'kyazdani42/nvim-tree.lua',
            requires = {'kyazdani42/nvim-web-devicons', opt = true},
        }
    }

    -- Colorscheme
    use {
        'bluz71/vim-nightfly-guicolors',
        config = function() vim.api.nvim_command('colorscheme ' .. 'nightfly') end
    }

    -- Completion
    use {
        {'hrsh7th/nvim-compe', config = function() require'conf.compe' end },
        {'hrsh7th/vim-vsnip', requires = {'rafamadriz/friendly-snippets'}},
    }

    use {'nvim-lua/telescope.nvim', requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'},
        config = function() require'conf.telescope' end}

    use { 'nvim-treesitter/nvim-treesitter', config = function() require'conf.treesitter' end,
        run = ':TSUpdate',
        requires = {
            'p00f/nvim-ts-rainbow',
            'windwp/nvim-ts-autotag',
            { 'JoosepAlviste/nvim-ts-context-commentstring', requires = 'tpope/vim-commentary' },
        },
    }

    -- Language specific
    use {
        {'simrat39/rust-tools.nvim', after = "nvim-lspconfig",
            ft = { "rust" }, event = { "BufEnter Cargo.toml" },
            config = function() require'conf.rust-tools' end  ,  },
        {'sebdah/vim-delve',             ft = "go" },
        {'lervag/vimtex',                ft = {"tex", "latex"}},
        {'dart-lang/dart-vim-plugin',    ft = "dart"},
        {'JuliaEditorSupport/julia-vim', disable = true}, -- , ft = "julia" -- does not load lazyly properly
        {'dag/vim-fish',                 ft = "fish"},
    }

    -- Git
    use {
        {'tpope/vim-rhubarb', requires = 'tpope/vim-fugitive',
            cmd = {
                "G", "Ggrep", "Git", "Glgrep", "Gclog", "Gllog", "Gcd", "Glcd",
                "Gedit", "Gsplit", "Gvsplit", "Gtabedit", "Gpedit", "Gread",
                "Gwrite", "Gwq", "Gdiffsplit", "GMove", "GRename", "GDelete",
                "GRemove", "GBrowse",
            }
        },
        {'junegunn/gv.vim',     cmd = "GV"},
        {'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = function() require('gitsigns').setup() end},
    }

    -- Spell
    use {'rhysd/vim-grammarous', cmd = {"GrammarousCheck"}, } -- ft = {"markdown", "tex", "latex", "text"},
    use {
        'lewis6991/spellsitter.nvim',
        config = function() require('spellsitter').setup() end
    }

    -- Lint
    use 'dense-analysis/ale'

    -- LSP
    use {
        'neovim/nvim-lspconfig',
        config = function() require('conf.lsp') end,
        requires = {
            'nvim-lua/lsp-status.nvim',
            'kabouzeid/nvim-lspinstall',
            'glepnir/lspsaga.nvim',
            {'RishabhRD/nvim-lsputils', disable = true, requires = 'RishabhRD/popfix'},
            'jose-elias-alvarez/nvim-lsp-ts-utils',
            'ray-x/lsp_signature.nvim',
            'simrat39/symbols-outline.nvim',
        },
    }

    -- DAP

    use {
        "rcarriga/nvim-dap-ui",
        requires = {"mfussenegger/nvim-dap"},
        config = function() require('conf.dap') end
    }

end,
    --------------------------------------------------------------------------------
    -- Packer config
    --------------------------------------------------------------------------------

    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end
        }
    }
})
