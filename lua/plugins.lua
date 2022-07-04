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

    -- use 'nathom/filetype.nvim'

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
            'kyazdani42/nvim-web-devicons',
        {
            'nvim-lualine/lualine.nvim',
            config = function() require'conf.statusline' end,
            requires = {{'kyazdani42/nvim-web-devicons', opt = true}, 'arkav/lualine-lsp-progress'},
        },
        {
            'romgrk/barbar.nvim',
            requires = {'kyazdani42/nvim-web-devicons', opt = true},
        },
        {
          "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            requires = {
              "nvim-lua/plenary.nvim",
              "kyazdani42/nvim-web-devicons",
              "MunifTanjim/nui.nvim",
            },
            config = function() require'conf.tree' end,
            -- cmd = "Neotree",
        },
    }

    use {
        'rcarriga/nvim-notify', config = function() vim.notify = require'notify' end,
    }

    -- Colorscheme
    use {
        'catppuccin/nvim',
        as = 'catppuccin',
        config = function()
            vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
            vim.cmd[[colorscheme catppuccin]]
        end,
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

    use {'nvim-telescope/telescope.nvim', module = 'telescope', cmd = 'Telescope',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require'conf.telescope'
            require'telescope'.load_extension('notify')
        end}

    use { 'nvim-treesitter/nvim-treesitter', config = function() require'conf.treesitter' end,
        requires = {
            'p00f/nvim-ts-rainbow',
            'windwp/nvim-ts-autotag',
            { 'JoosepAlviste/nvim-ts-context-commentstring', requires = 'tpope/vim-commentary' },
        },
    }
    use {'nvim-treesitter/nvim-treesitter-refactor', cmd = {'Refactor'}}

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
        {'jalvesaq/Nvim-R',              branch = 'stable', ft={'r', 'rmd', 'rout', 'rnoweb'}},
        {'LnL7/vim-nix',                 ft = 'nix'},
        {'scalameta/nvim-metals',
            requires = { "nvim-lua/plenary.nvim" },
            ft={'scala', 'sbt', 'java'},
            config = function() require("metals").initialize_or_attach({}) end,
        },
        'neo4j-contrib/cypher-vim-syntax',
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
        {'tanvirtin/vgit.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = "require'conf._vgit'"},
    }

    -- Spell
    use {'rhysd/vim-grammarous', cmd = {'GrammarousCheck'}, }
    -- use {
    --     'lewis6991/spellsitter.nvim',
    --     config = function() require'spellsitter'.setup() end
    -- }
    use {'anufrievroman/vim-angry-reviewer', cmd = 'AngryReviewer'}
    use { "brymer-meneses/grammar-guard.nvim", requires = { "neovim/nvim-lspconfig", "williamboman/nvim-lsp-installer" },
        config = function() require'conf.grammar-guard' end,
    }


    -- Copilot
    use {'github/copilot.vim'}

    -- LSP
    use {
        'neovim/nvim-lspconfig',
        config = function() require'conf.lsp' end,
        requires = {
            {'kabouzeid/nvim-lspinstall', cmd = 'LspInstall'},
            'jose-elias-alvarez/nvim-lsp-ts-utils',
            'ray-x/lsp_signature.nvim',
            {'simrat39/symbols-outline.nvim', opt = false, cmd = {'SymbolsOutline', 'SymbolsOutlineOpen'}},
            {'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu', module = 'code_action_menu' },
        }
    }

    -- DAP
    use {
        'rcarriga/nvim-dap-ui',
        module = 'dapui',
        requires = {'mfussenegger/nvim-dap', module = 'dap'},
        config = function() require'conf.dap' end
    }

    -- ORG mode
    use { 'nvim-neorg/neorg', config = function() require'conf.org' end, requires = 'nvim-lua/plenary.nvim' }

    -- Firenvim
    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end
    }

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
        compile_path = require'packer.util'.join_paths(vim.fn.stdpath('data'), 'plugin', 'packer_compiled.lua'),
    }
}
