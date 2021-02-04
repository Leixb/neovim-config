--------------------------------------------------------------------------------
-- Check if Plug is installed and download it if not
--------------------------------------------------------------------------------

local vim_plug_install_path = vim.fn['stdpath']('config') .. '/autoload/plug.vim'

local f = io.open(vim_plug_install_path, 'r')
if f == nil then
    os.execute(('curl -fLo %s --create-dirs %s'):format(
		vim_plug_install_path,
		'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	))
    vim.api.nvim_command('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
else
	f:close()
end


--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------

local global_opts = {
    encoding      = 'utf-8',
    termguicolors = true,

    backup        = false,
    writebackup   = false,

    smarttab      = true,

    ignorecase    = true,
    smartcase     = true,

    splitbelow    = true,
    splitright    = true,

    showmode      = false,
    ruler         = false,

    cmdheight     = 2,

    updatetime    = 300,
    ttimeoutlen   = 10,
    timeoutlen    = 500,

    title         = true,

    wildmenu      = true,
    hidden        = true,
    scrolloff     = 10,
    showtabline   = 2,

    hlsearch      = true,
    incsearch     = true,

    -- virtualedit   = 'block',
    backspace     = 'indent,eol,start',

    shortmess     = 'filnxtToOIc',

    completeopt   = 'menuone,noinsert,noselect',
}

local win_opts = {
    cursorline = true,
    number     = true,
    signcolumn = 'number',
    foldmethod = 'expr',
    foldexpr   = 'nvim_treesitter#foldexpr()',
    foldenable = false,
}

local buf_opts = {
    autoindent  = true,
    smartindent = true,

    infercase   = true,

    expandtab   = true,

    shiftwidth  = 4,
    softtabstop = 4,
    tabstop     = 4,

    textwidth   = 80,
}

for k, v in pairs(global_opts) do
	vim.o[k] = v
    -- vim.api.nvim_set_option(k, v)
end

for k, v in pairs(buf_opts) do
	vim.o[k] = v
	vim.bo[k] = v
    -- vim.api.nvim_set_option(k, v)
    -- vim.api.nvim_buf_set_option(0, k, v)
end

for k, v in pairs(win_opts) do
	vim.o[k] = v
	vim.wo[k] = v
    -- vim.api.nvim_set_option(k, v)
    -- vim.api.nvim_win_set_option(0, k, v)
end

--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------

local plugins = {
    'itchyny/lightline.vim',
    'mengelbrecht/lightline-bufferline',

    'bluz71/vim-nightfly-guicolors',

    'dense-analysis/ale',

    'neovim/nvim-lspconfig',
    'nvim-lua/completion-nvim',
    'nvim-lua/lsp-status.nvim',
    'nvim-lua/telescope.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    'norcalli/nvim-colorizer.lua',
    'RishabhRD/popfix',
    'RishabhRD/nvim-lsputils',

    'jiangmiao/auto-pairs',

    'nvim-treesitter/nvim-treesitter',

    'SirVer/ultisnips',
    'honza/vim-snippets',

    'sebdah/vim-delve',
    'arp242/gopher.vim',

    'lervag/vimtex',
    'dart-lang/dart-vim-plugin',

    'tpope/vim-commentary',
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'tpope/vim-apathy',
    'tpope/vim-eunuch',

    'junegunn/vim-easy-align',

    'mhinz/vim-signify',
    'junegunn/gv.vim',
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    'editorconfig/editorconfig-vim',
}

local path = vim.fn['stdpath']('data') .. '/plugged'
vim.fn['plug#begin'](path)

for _,p in pairs(plugins) do
    if type(p) == 'table' then
        vim.fn['plug#'](unpack(p))
    else
        vim.fn['plug#'](p)
    end
end

vim.fn['plug#end']()

--------------------------------------------------------------------------------
-- Colorscheme
--------------------------------------------------------------------------------

local theme = 'nightfly'
local lightline_theme = theme

vim.api.nvim_command('colorscheme ' .. theme)

--------------------------------------------------------------------------------
-- Mappings
--------------------------------------------------------------------------------

vim.api.nvim_command('let mapleader=" "')

local nmap = {
    ['<space>'] = '<NOP>',

    ['<C-j>'] = '<C-w><C-j>',
    ['<C-k>'] = '<C-w><C-k>',
    ['<C-l>'] = '<C-w><C-l>',
    ['<C-h>'] = '<C-w><C-h>',

    ['<F1>']  = {'<cmd>tabprevious<CR>', { noremap = true , silent = true }},
    ['<F2>']  = {'<cmd>bprevious!<CR>',  { noremap = true , silent = true }},
    ['<F3>']  = {'<cmd>bnext!<CR>',      { noremap = true , silent = true }},
    ['<F4>']  = {'<cmd>tabnext<CR>',     { noremap = true , silent = true }},

    ['<F12>'] = {'magg=G`a',             { noremap = true , silent = true }},

    ['Y'] = 'y$',

    ['n'] = 'nzzzv',
    ['N'] = 'Nzzzv',

    ['<leader>m'] = {'<cmd>Make<CR>', { noremap = true , silent = true }},

-- Telescope mappings

    ['<C-S-p>']          = "<cmd>lua require('telescope.builtin').git_files()<CR>",
    ['<C-p>']            = "<cmd>lua require('telescope.builtin').fd()<CR>",
    ['<leader><leader>'] = "<cmd>lua require('telescope.builtin').buffers()<CR>",
    ['<Bs>']             = "<cmd>lua require('telescope.builtin').live_grep()<CR>",

-- LSP mappings

    ['[g']         = {'<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', { silent = true }},
    [']g']         = {'<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', { silent = true }},
    ['gd']         = {'<cmd>lua vim.lsp.buf.definition()<CR>',      { silent = true }},
    ['gy']         = {'<cmd>lua vim.lsp.buf.type_definition()<CR>', { silent = true }},
    ['gi']         = {'<cmd>lua vim.lsp.buf.implementation()<CR>',  { silent = true }},
    ['gr']         = {'<cmd>lua vim.lsp.buf.references()<CR>',      { silent = true }},

    ['<leader>rn'] = {'<cmd>lua vim.lsp.buf.rename()<CR>',      {}},
    ['<leader>f']  = {'<cmd>lua vim.lsp.buf.formatting()<CR>',  {}},
    ['<leader>a']  = {'<cmd>lua vim.lsp.buf.code_action()<CR>', {}},

    -- Close location, quickfix and help windows
    ['<leader>c']  = {'<cmd>ccl <bar> lcl <bar> helpc <CR>', {}},

    ['K']          = {'<cmd>lua show_documentation()<CR>',         {silent = true, noremap = true}},
    ['<c-S>']      = {'<cmd>lua vim.lsp.buf.signature_help()<CR>', {noremap = true}},


    ['<leader>ld'] = {'<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', {silent = true, nowait = true, noremap = true}},
    ['<leader>d']  = {'<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',      {silent = true, nowait = true, noremap = true}},
    ['<leader>i']  = {'<cmd>lua vim.lsp.buf.incoming_calls()<CR>',          {silent = true, nowait = true, noremap = true}},
    ['<leader>o']  = {'<cmd>lua vim.lsp.buf.outgoing_calls()<CR>',          {silent = true, nowait = true, noremap = true}},
    ['<leader>s']  = {'<cmd>lua vim.lsp.buf.document_symbol()<cr>',         {silent = true, nowait = true, noremap = true}},
    ['<leader>w']  = {'<cmd>lua vim.lsp.buf.workspace_symbol()<cr>',        {silent = true, nowait = true, noremap = true}},

    -- gopher
    ['<leader>ge'] = '<Plug>(gopher-error)',
    ['<leader>gi'] = '<Plug>(gopher-if)',
    ['<leader>gm'] = '<Plug>(gopher-implement)',
    ['<leader>gr'] = '<Plug>(gopher-return)',
    ['<leader>gf'] = '<Plug>(gopher-fillstruct)',
}

local imap = {
    ['jk']        = '<ESC>',
    ['<F13>']       = {'<Plug>(completion_trigger)',             {silent = true}},
    ['<TAB>']     = {'pumvisible() ? "\\<C-n>" : "\\<TAB>"',   {silent = true, noremap = true, expr = true}},
    ['<S-TAB>']   = {'pumvisible() ? "\\<C-p>" : "\\<S-TAB>"', {silent = true, noremap = true, expr = true}},

    ['<C-k>e'] = '<Plug>(gopher-error)',
    ['<C-k>i'] = '<Plug>(gopher-if)',
    ['<C-k>m'] = '<Plug>(gopher-implement)',
    ['<C-k>r'] = '<Plug>(gopher-return)',
    ['<C-k>f'] = '<Plug>(gopher-fillstruct)',
}

local xmap = {}
local omap = {}
local vmap = {}

local tmap = {
    ['<ESC>'] = '<C-\\><C-n>',
}

local cmap = {
    ['jk'] = '<ESC>',
}

local default_args = { noremap = true }

for mode, map in pairs({ n = nmap, v = vmap, t = tmap, c = cmap, i = imap, x = xmap, o = omap }) do
    for from, to in pairs(map) do
        if type(to) == 'table' then
            vim.api.nvim_set_keymap(mode, from, to[1], to[2])
        else
            vim.api.nvim_set_keymap(mode, from, to, default_args)
        end
    end
end

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------

local vars = {

    -- netrw

    netrw_banner    = 0,
    netrw_liststyle = 3,
    netrw_winsize   = 30,

    -- vimtex

    tex_flavor = 'latex',

    vimtex_compiler_progname   = 'nvr',
    vimtex_view_method         = 'zathura',
    vimtex_view_use_temp_files = 1,
    vimtex_compiler_latexmk    = {
        backend    = 'nvim',
        background = 1,
        build_dir  = '',
        callback   = 1,
        continuous = 1,
        executable = 'latexmk',
        hooks      = {},
        options    = {
            '-verbose',
            '-file-line-error',
            '-synctex=1',
            '-shell-escape',
            '-interaction=nonstopmode',
        },
    },
    vimtex_compiler_method          = 'latexmk',
    vimtex_compiler_engine          = 'lualatex',
    vimtex_compiler_latexmk_engines = {
        _                           = '-lualatex', -- default to lualatex
        pdflatex                    = '-pdf',
        dvipdfex                    = '-pdfdvi',
        lualatex                    = '-lualatex',
        xelatex                     = '-xelatex',
        ['context (pdftex)']        = '-pdf -pdflatex=texexec',
        ['context (luatex)']        = '-pdf -pdflatex=context',
        ['context (xetex)']         = "-pdf -pdflatex=''texexec --xtx''",
    },

    -- UltiSnips

    UltiSnipsExpandTrigger       = '<Nop>',
    UltiSnipsJumpForwardTrigger  = '<Nop>',
    UltiSnipsJumpBackwardTrigger = '<Nop>',

    -- Lightline

    lightline = {
        colorscheme        = lightline_theme,
        active             = {
            left           = { { 'mode', 'paste' },
                               { 'gitbranch', 'readonly', 'filename', 'modified' } },
            right          = { { 'lineinfo' },
                               { 'percent' },
                               { 'fileformat', 'fileencoding', 'filetype' },
                               { 'lsp_status' } },
        },
        tabline            = {
            left           = { { 'buffers' } },
            right          = { { 'tabs' } },
        },
        component          = {
            lineinfo       = "%3l:%-2c/%{line('$')}",
            lsp_status     = '%{v:lua.Status()}%<',
        },
        component_function = {
            gitbranch      = 'fugitive#head',
        },
        component_expand   = {
            buffers        = 'lightline#bufferline#buffers',
        },
        component_type     = {
            buffers        = 'tabsel',
        },
    },

    -- ALE

    ale_fixers = {
        ['*']      = {'remove_trailing_lines', 'trim_whitespace'},
        css        = {'prettier', 'stylelint'},
        javascript = {'eslint', 'prettier'},
        python     = {'isort', 'black'},
        HTML       = {'HTMLHint', 'proselint'},
        ruby       = {'rubocop'},
        go         = {'gofmt', 'goimports'},
        dart       = {'dartfmt'},
        r          = {'styler'},
    },
    ale_linters_explicit = 1,
    ale_lint_delay = 1000,
    ale_linters = {
        go        = {'staticcheck', 'golangci-lint'},
    },
    ale_fix_on_save              = 1,
    ale_go_imports_executable    = 'gofumports',
    ale_go_golangci_lint_package = 1,
    ale_disable_lsp              = 1,

    completion_enable_snippet    = 'UltiSnips',

    diagnostic_enable_virtual_text = 1,
    diagnostic_virtual_text_prefix = ' ',
    diagnostic_insert_delay = 1,

    gopher_map = 0, -- diable gopher default mappings

    EditorConfig_exclude_patterns = {'fugitive://.*'},
}

for k,v in pairs(vars) do
	vim.g[k] = v
    -- vim.api.nvim_set_var(k, v)
end

--------------------------------------------------------------------------------
-- augroups
--------------------------------------------------------------------------------

local augroups = {
    term = {
        'TermOpen term://* setlocal nonumber',
        'TermOpen * startinsert',
    },
    completion = {
        "BufEnter * lua require'completion'.on_attach()",
    },
    lsp_highlight = {
        'CursorHold  <buffer> silent! lua vim.lsp.buf.document_highlight()',
        'CursorHoldI <buffer> silent! lua vim.lsp.buf.document_highlight()',
        'CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()',
    },
    ale =  {
        "BufEnter tex let b:ale_lint_on_text_changed=0",
    },
}

for augroup, autocmds in pairs(augroups) do
    vim.api.nvim_command(('augroup leixb-%s'):format(augroup))
    vim.api.nvim_command('autocmd!')
    for _, autocmd in ipairs(autocmds) do
        vim.api.nvim_command(('autocmd %s'):format(autocmd))
    end
    vim.api.nvim_command('augroup end')
end

--------------------------------------------------------------------------------
-- commands
--------------------------------------------------------------------------------

local commands = {
    'DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis',
    'VimConfig edit $MYVIMRC',
    "Make silent lua require'async_make'.make()",
    '-nargs=* T  split  | terminal <args>',
    '-nargs=* VT vsplit | terminal <args>',
}

for _, c in pairs(commands) do
    vim.api.nvim_command('command! ' .. c)
end

--------------------------------------------------------------------------------
-- Helper funcitons
--------------------------------------------------------------------------------

function show_documentation()
	if vim.tbl_contains({'vim', 'help'}, vim.bo.filetype) then
		vim.api.nvim_command('help ' .. vim.fn.expand('<cword>'))
	else
        vim.lsp.buf.hover()
	end
end

--------------------------------------------------------------------------------
-- Tree sitter
--------------------------------------------------------------------------------

require'nvim-treesitter.configs'.setup {
    ensure_installed = 'all',
    highlight = {
        enable = true,
    },
}

--------------------------------------------------------------------------------
-- Colorizer
--------------------------------------------------------------------------------

require'colorizer'.setup()

--------------------------------------------------------------------------------
-- LSP
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
    'rls',
    'texlab',
    'tsserver',
    'vimls',
    'yamlls',
}

for _,val in pairs(lsp_list) do
    lspconfig[val].setup{ on_attach = lsp_attach, capabilities = lsp_status.capabilities }
end

local probeLoc = vim.fn.system('npm root -g')
lspconfig.angularls.setup{
  on_attach = lsp_attach,
  capabilities = lsp_status.capabilities,
  cmd = {"ngserver", "--stdio", "--tsProbeLocations", probeLoc , "--ngProbeLocations", probeLoc},
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

function Status()
    if #vim.lsp.buf_get_clients() > 0 then
        return lsp_status.status()
    end
    return ''
end

vim.lsp.callbacks['textDocument/codeAction']     = require'lsputil.codeAction'.code_action_handler
vim.lsp.callbacks['textDocument/references']     = require'lsputil.locations'.references_handler
vim.lsp.callbacks['textDocument/definition']     = require'lsputil.locations'.definition_handler
vim.lsp.callbacks['textDocument/declaration']    = require'lsputil.locations'.declaration_handler
vim.lsp.callbacks['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.callbacks['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.callbacks['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.callbacks['workspace/symbol']            = require'lsputil.symbols'.workspace_handler

-- Diagnostics

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Enable underline, use default values
        underline = true,
        -- Enable virtual text, override spacing to 4
        virtual_text = {
            spacing = 4,
            prefix = '~',
        },
        -- Use a function to dynamically turn signs off
        -- and on, using buffer local variables
        signs = function(bufnr, _)
            local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
            -- No buffer local variable set, so just enable by default
            if not ok then
                return true
            end

            return result
        end,
        -- Disable a feature
        update_in_insert = false,
    }
)

-- Telescope

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
