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

    virtualedit   = 'block',
    backspace     = 'indent,eol,start',

    shortmess	  = 'atIc',

    completeopt   = 'menuone,noinsert,noselect',
}

local win_opts = {
    cursorline = true,
    number     = true,
    signcolumn = 'number',
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

    'sainnhe/sonokai',

    'dense-analysis/ale',

    'neovim/nvim-lspconfig',
    'nvim-lua/completion-nvim',
    'nvim-lua/diagnostic-nvim',
    'nvim-lua/lsp-status.nvim',

    'jiangmiao/auto-pairs',

    'nvim-treesitter/nvim-treesitter',

    'SirVer/ultisnips',
    'honza/vim-snippets',

    'sebdah/vim-delve',
    'arp242/gopher.vim',

    'lervag/vimtex',

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

    {'Shougo/denite.nvim', { ['do'] = ':UpdateRemotePlugins' } },
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

local theme = 'sonokai'
local lightline_theme = theme

vim.api.nvim_command('colorscheme ' .. theme)

--------------------------------------------------------------------------------
-- Mappings
--------------------------------------------------------------------------------

local nmap = {
    ['<space>'] = {'<leader>', {}},

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

-- Denite mappings

    ['<C-p>'] = '<cmd>DeniteProjectDir file/rec<CR>',
    ['\\']    = '<cmd>Denite buffer<CR>',
    ['<Bs>']  = '<cmd>Denite grep:. -no-empty<CR>',

-- LSP mappings

    ['[g']         = {'<cmd>PrevDiagnostic<CR>',                    { silent = true }},
    [']g']         = {'<cmd>NextDiagnostic<CR>',                    { silent = true }},
    ['gd']         = {'<cmd>lua vim.lsp.buf.definition()<CR>',      { silent = true }},
    ['gy']         = {'<cmd>lua vim.lsp.buf.type_definition()<CR>', { silent = true }},
    ['gi']         = {'<cmd>lua vim.lsp.buf.implementation()<CR>',  { silent = true }},
    ['gr']         = {'<cmd>lua vim.lsp.buf.references()<CR>',      { silent = true }},

    ['<leader>rn'] = {'<cmd>lua vim.lsp.buf.rename()<CR>',      {}},
    ['<leader>f']  = {'<cmd>lua vim.lsp.buf.formatting()<CR>',  {}},
    ['<leader>a']  = {'<cmd>lua vim.lsp.buf.code_action()<CR>', {}},

    ['K']          = {'<cmd>lua show_documentation()<CR>',         {silent = true, noremap = true}},
    ['<c-S>']      = {'<cmd>lua vim.lsp.buf.signature_help()<CR>', {noremap = true}},


    ['<leader>d']  = {'<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', {silent = true, nowait = true, noremap = true}},
    ['<leader>i']  = {'<cmd>lua vim.lsp.buf.incoming_calls()<CR>',         {silent = true, nowait = true, noremap = true}},
    ['<leader>o']  = {'<cmd>lua vim.lsp.buf.outgoing_calls()<CR>',         {silent = true, nowait = true, noremap = true}},
    ['<leader>s']  = {'<cmd>lua vim.lsp.buf.document_symbol()<cr>',        {silent = true, nowait = true, noremap = true}},
    ['<leader>w']  = {'<cmd>lua vim.lsp.buf.workspace_symbol()<cr>',       {silent = true, nowait = true, noremap = true}},
}

local imap = {
    ['jk']        = '<ESC>',
    ['<F13>']       = {'<Plug>(completion_trigger)',             {silent = true}},
    ['<TAB>']     = {'pumvisible() ? "\\<C-n>" : "\\<TAB>"',   {silent = true, noremap = true, expr = true}},
    ['<S-TAB>']   = {'pumvisible() ? "\\<C-p>" : "\\<S-TAB>"', {silent = true, noremap = true, expr = true}},
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
    sonokai_style                     = 'atlantis',
    sonokai_enable_italic             = 0,
    sonokai_disable_italic_comment    = 1,
    sonokai_better_performance        = 1,
    sonokai_diagnostic_line_highlight = 1,

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

    -- UltiSnips

    UltiSnipsExpandTrigger       = '<Nop>',
    UltiSnipsJumpForwardTrigger  = '<Nop>',
    UltiSnipsJumpBackwardTrigger = '<Nop>',

    -- Lightline

    lightline = {
        colorscheme        = lightline_theme,
        active             = {
            left           = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } },
        },
        tabline            = {
            left           = { { 'buffers' } },
            right          = { { 'tabs' } },
        },
        component          = {
            lineinfo       = "%3l:%-2c/%{line('$')}",
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
        ['*']     = {'remove_trailing_lines', 'trim_whitespace'},
        cs        = {'prettier', 'stylelint'},
        jvascript = {'eslint', 'prettier'},
        pthon     = {'isort', 'black'},
        HML       = {'HTMLHint', 'proselint'},
        rby       = {'rubocop'},
        o         = {'gofmt', 'goimports'},
    },
    ale_linters = {
        go        = {'staticcheck', 'golangci-lint'},
    },
    ale_fix_on_save              = 1,
    ale_go_imports_executable    = 'gofumports',
    ale_go_golangci_lint_package = 1,
    ale_disable_lsp              = 1,

    completion_enable_snippet    = 'UltiSnips',

    AutoPairsFlyMode             = 1,
    AutoPairsShortcutBackInsert  = '<M-b>',
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
    },
    denite = {
        'FileType denite call v:lua.denite_window_settings()',
        'FileType denite-filter call v:lua.denite_filter_settings()',
    },
    completion = {
        "BufEnter * lua require'completion'.on_attach()"
    },
    lsp_highlight = {
        'CursorHold  <buffer> lua vim.lsp.buf.document_highlight()',
        'CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()',
        'CursorMoved <buffer> lua vim.lsp.buf.clear_references()',
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
}

for _, c in pairs(commands) do
    vim.api.nvim_command('command! ' .. c)
end


--------------------------------------------------------------------------------
-- DENITE
--------------------------------------------------------------------------------

vim.fn['denite#custom#var']('file/rec', 'command',  {'rg', '--files', '--glob', '!.git'})

vim.fn['denite#custom#var']('grep', {
    command        = {'rg'},
    default_opts   = {'-i', '--vimgrep', '--no-heading'},
    recursive_opts = {},
    pattern_opt    = {'--regexp'},
    separator      = {'--'},
    final_opts     = {},
})

-- Change ignore_globs
vim.fn['denite#custom#filter']('matcher/ignore_globs', 'ignore_globs', {
    '.git/', '.ropeproject/', '__pycache__/', 'venv/', 'images/', '*.min.*', 'img/', 'fonts/'
})

-- Remove date from buffer list
vim.fn['denite#custom#var']('buffer', 'date_format', '')

local denite_options = {
    split                       = 'floating',
    start_filter                = 1,
    auto_resize                 = 1,
    source_names                = 'short',
    prompt                      = 'λ ',
    winrow                      = 1,
    vertical_preview            = 1,
    highlight_matched_char      = 'DiffOrig',
    highlight_matched_range     = 'Visual',
    highlight_window_background = 'Visual',
    highlight_filter_background = 'DiffAdd',
}

for k,v in pairs(denite_options) do
    vim.fn['denite#custom#option']('default', k, v)
end

local denite_mappings = {
    normal = {
        ['<CR>']  = 'do_action',
        ['q']     = 'quit',
        ['<ESC>'] = 'quit',
        ['d']     = {'do_action', 'delete'},
        ['p']     = {'do_action', 'preview'},
        ['i']     = 'open_filter_buffer',
        ['<C-o>'] = 'open_filter_buffer',
        ['<C-t>'] = {'do_action', 'tabopen'},
        ['<C-v>'] = {'do_action', 'vsplit'},
        ['<C-h>'] = {'do_action', 'split'},
        ['.']     = 'toggle_select',
    },
    filter = {
        ['<CR>']  = 'do_action',
        ['<ESC>'] = 'quit',
        ['<C-t>'] = {'do_action', 'tabopen'},
        ['<C-v>'] = {'do_action', 'vsplit'},
        ['<C-h>'] = {'do_action', 'split'},
        ['.']     = 'toggle_select',
    },
    filter_no_expr = {
        ['<C-o>'] = '<Plug>(denite_filter_quit)',
        ['jk']    = '<Plug>(denite_filter_quit)',
    }
}

function denite_filter_settings()
    for k,v in pairs(denite_mappings.filter) do
        denite_map('i', k, v)
    end
    for k,v in pairs(denite_mappings.filter_no_expr) do
        denite_map_noexpr(k, v)
    end
end

function denite_window_settings()
    for k,v in pairs(denite_mappings.normal) do
        denite_map('n', k, v)
    end
end

function denite_map_noexpr(key, action)
    vim.api.nvim_buf_set_keymap(0, 'i', key, action, { silent = true })
end

function denite_map(mode, key, action)
    if type(action) == 'table' then
        action = ("denite#do_map('%s', '%s')"):format(action[1], action[2])
    else
        action = ("denite#do_map('%s')"):format(action)
    end
    vim.api.nvim_buf_set_keymap(0, mode, key, action, { silent = true, expr = true, noremap = true })
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
-- LSP
--------------------------------------------------------------------------------

local nvim_lsp = require("nvim_lsp")
local nvim_diagnostic = require("diagnostic")

local function lsp_attach()
  nvim_diagnostic.on_attach()
end

nvim_lsp.gopls.setup                  { on_attach = lsp_attach }
nvim_lsp.html.setup                   { on_attach = lsp_attach }
nvim_lsp.pyls.setup                   { on_attach = lsp_attach }
nvim_lsp.r_language_server.setup      { on_attach = lsp_attach }
nvim_lsp.rls.setup                    { on_attach = lsp_attach }

nvim_lsp.vimls.setup                  { on_attach = lsp_attach }
nvim_lsp.yamlls.setup                 { on_attach = lsp_attach }
nvim_lsp.texlab.setup                 { on_attach = lsp_attach }

nvim_lsp.kotlin_language_server.setup { on_attach = lsp_attach }
nvim_lsp.julials.setup                { on_attach = lsp_attach }
nvim_lsp.bashls.setup                 { on_attach = lsp_attach }
nvim_lsp.dockerls.setup               { on_attach = lsp_attach }
nvim_lsp.cssls.setup                  { on_attach = lsp_attach }
nvim_lsp.clangd.setup                 { on_attach = lsp_attach }
nvim_lsp.hls.setup                    { on_attach = lsp_attach }
nvim_lsp.jsonls.setup                 { on_attach = lsp_attach }

nvim_lsp.sumneko_lua.setup{
    on_attach = lsp_attach,
    cmd = { "/home/leix/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/bin/Linux/lua-language-server", "-E",
            "/home/leix/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua" },
}
