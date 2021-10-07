--------------------------------------------------------------------------------
-- Bootstrap packer
--------------------------------------------------------------------------------

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.api.nvim_command 'packadd packer.nvim'
end

return require'packer'.startup{function(use)
    use 'wbthomason/packer.nvim'

    use 'nathom/filetype.nvim'

    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'

    use 'tpope/vim-eunuch'

    use {'junegunn/vim-easy-align', cmd = 'EasyAlign'}

    use 'editorconfig/editorconfig-vim'

    use {'windwp/nvim-autopairs', config = function() require'nvim-autopairs'.setup() end }

    use {'norcalli/nvim-colorizer.lua', config = function() require'colorizer'.setup() end }

    use {'kwkarlwang/bufresize.nvim', config = function() require'bufresize'.setup() end }

    -- Status lines
    use {
        {
            'hoob3rt/lualine.nvim',
            config = function() require'conf.statusline' end,
            requires = {{'kyazdani42/nvim-web-devicons', opt = true}, 'arkav/lualine-lsp-progress'},
        },
        {
            'romgrk/barbar.nvim',
            requires = {'kyazdani42/nvim-web-devicons', opt = true},
        },
        {
            'kyazdani42/nvim-tree.lua', module = 'nvim-tree', cmd = {'NvimtreeToggle', 'NvimtreeOpen'},
            config = function() require'nvim-tree'.setup() end,
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
        {'hrsh7th/nvim-cmp', config = function() require'conf.cmp' end},

        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'hrsh7th/cmp-calc'},
        {'kdheepak/cmp-latex-symbols'},
        {'hrsh7th/cmp-nvim-lua'},

        {'L3MON4D3/LuaSnip', config = function() require'snippets' end},
        {'saadparwaiz1/cmp_luasnip'},
        {'rafamadriz/friendly-snippets'},

        {'onsails/lspkind-nvim'},
    }

    use {'nvim-lua/telescope.nvim', module = 'telescope', cmd = 'Telescope',
        requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'},
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
        {'simrat39/rust-tools.nvim', after = 'nvim-lspconfig',
            ft = { 'rust' }, event = { 'BufEnter Cargo.toml' },
            config = function() require'conf.rust-tools' end  ,  },
        {'sebdah/vim-delve',             ft = 'go' },
        {'lervag/vimtex',                ft = {'tex', 'latex'}},
        {'dart-lang/dart-vim-plugin',    ft = 'dart'},
        {'JuliaEditorSupport/julia-vim', disable = true}, -- , ft = 'julia' -- does not load lazily properly (https://github.com/JuliaEditorSupport/julia-vim/issues/269)
        {'dag/vim-fish',                 ft = 'fish'},
        {'jalvesaq/Nvim-R',              branch = 'stable', ft={'r', 'rmd', 'rout'}},
    }

    -- Git
    use {
        {'tpope/vim-rhubarb', requires = 'tpope/vim-fugitive',
            cmd = {
                'G', 'Ggrep', 'Git', 'Glgrep', 'Gclog', 'Gllog', 'Gcd', 'Glcd',
                'Gedit', 'Gsplit', 'Gvsplit', 'Gtabedit', 'Gpedit', 'Gread',
                'Gwrite', 'Gwq', 'Gdiffsplit', 'GMove', 'GRename', 'GDelete',
                'GRemove', 'GBrowse',
            }
        },
        {'junegunn/gv.vim',     cmd = 'GV'},
        {'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = function() require'gitsigns'.setup() end},
    }

    -- Spell
    use {'rhysd/vim-grammarous', cmd = {'GrammarousCheck'}, }
    use {
        'lewis6991/spellsitter.nvim',
        config = function() require'spellsitter'.setup() end
    }

    -- LSP
    use {
        'neovim/nvim-lspconfig',
        config = function() require'conf.lsp' end,
        requires = {
            {'kabouzeid/nvim-lspinstall', cmd = 'LspInstall'},
            {'glepnir/lspsaga.nvim', module = 'lspsaga', config = function() require'lspsaga'.init_lsp_saga() end },
            'jose-elias-alvarez/nvim-lsp-ts-utils',
            'ray-x/lsp_signature.nvim',
            {'simrat39/symbols-outline.nvim', opt = false, cmd = {'SymbolsOutline', 'SymbolsOutlineOpen'}},
        },
    }

    -- DAP
    use {
        'rcarriga/nvim-dap-ui',
        module = 'dapui',
        requires = {'mfussenegger/nvim-dap', module = 'dap'},
        config = function() require'conf.dap' end
    }

    -- ORG mode
    use { 'nvim-neorg/neorg', config = function() require('conf.org') end, requires = 'nvim-lua/plenary.nvim' }

end,
    --------------------------------------------------------------------------------
    -- Packer config
    --------------------------------------------------------------------------------

    config = {
        display = {
            open_fn = function()
                return require'packer.util'.float({ border = 'single' })
            end
        },
        compile_path = require('packer.util').join_paths(vim.fn.stdpath('data'), 'plugin', 'packer_compiled.lua'),
    }
}
