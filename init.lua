--------------------------------------------------------------------------------
-- Bootstrap packer
--------------------------------------------------------------------------------

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------

local opts = {
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
    wildignore    = {'*.o', '*.a', '__pycache__'},
    hidden        = true,
    scrolloff     = 10,
    showtabline   = 2,

    hlsearch      = true,
    incsearch     = true,

    -- virtualedit   = 'block',
    backspace     = {'indent', 'eol', 'start'},

    shortmess     = 'filnxtToOIc',

    completeopt   = {'menuone', 'noinsert', 'noselect'},

    cursorline    = true,
    number        = true,
    signcolumn    = 'yes',
    foldmethod    = 'expr',
    foldexpr      = 'nvim_treesitter#foldexpr()',
    foldenable    = false,

    autoindent    = true,
    smartindent   = true,

    infercase     = true,

    expandtab     = true,

    shiftwidth    = 4,
    softtabstop   = 4,
    tabstop       = 4,

    textwidth     = 80,
    wrap          = true,
    formatoptions = "jcroql",

    omnifunc      = 'v:lua.vim.lsp.omnifunc',
}

for k, v in pairs(opts) do
	vim.opt[k] = v
end

--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------

require('plugins')

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


    ['<leader>ld'] = {'<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',  {silent = true, nowait = true, noremap = true}},
    ['<leader>d']  = {'<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',            {silent = true, nowait = true, noremap = true}},
    ['<leader>i']  = {'<cmd>lua vim.lsp.buf.incoming_calls()<CR>',                {silent = true, nowait = true, noremap = true}},
    ['<leader>o']  = {'<cmd>lua vim.lsp.buf.outgoing_calls()<CR>',                {silent = true, nowait = true, noremap = true}},
    ['<leader>s']  = {'<cmd>lua vim.lsp.buf.document_symbol()<CR>',               {silent = true, nowait = true, noremap = true}},
    ['<leader>w']  = {'<cmd>lua vim.lsp.buf.workspace_symbol()<CR>',              {silent = true, nowait = true, noremap = true}},

    -- gopher
    -- ['<leader>ge'] = '<Plug>(gopher-error)',
    -- ['<leader>gi'] = '<Plug>(gopher-if)',
    -- ['<leader>gm'] = '<Plug>(gopher-implement)',
    -- ['<leader>gr'] = '<Plug>(gopher-return)',
    -- ['<leader>gf'] = '<Plug>(gopher-fillstruct)',
}

local imap = {
    ['jk']        = '<ESC>',
    ['<F13>']     = {'<Plug>(completion_smart_tab)',             {silent = true}},
    ['<C-space>'] = {'<Plug>(completion_trigger)',             {silent = true}},
    ['<c-p>']     = {'<Plug>(completion_trigger)',             {silent = true}},

    ['<TAB>']     = {'pumvisible() ? "\\<C-n>" : "\\<TAB>"',   {silent = true, noremap = true, expr = true}},
    ['<S-TAB>']   = {'pumvisible() ? "\\<C-p>" : "\\<S-TAB>"', {silent = true, noremap = true, expr = true}},

    ['<c-S>']     = {'<cmd>lua vim.lsp.buf.signature_help()<CR>', {noremap = true}},


    -- ['<C-k>e'] = '<Plug>(gopher-error)',
    -- ['<C-k>i'] = '<Plug>(gopher-if)',
    -- ['<C-k>m'] = '<Plug>(gopher-implement)',
    -- ['<C-k>r'] = '<Plug>(gopher-return)',
    -- ['<C-k>f'] = '<Plug>(gopher-fillstruct)',
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

    -- UltiSnipsExpandTrigger       = '<nop>',
    -- UltiSnipsJumpForwardTrigger  = '<nop>',
    -- UltiSnipsJumpBackwardTrigger = '<nop>',

    -- VSnip

    vsnip_filetypes = {
        javascriptreact = {'javascript'},
        typescriptreact = {'typescript'},
    },

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
            lsp_status     = '%{v:lua.status()}%<',
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
        go         = {'staticcheck', 'golangci-lint'},
        python     = {'mypy', 'pylint'},
    },
    ale_fix_on_save              = 1,
    ale_fix_on_save_ignore       = {
        julia      = {'remove_trailing_lines', 'trim_whitespace'},
    },
    ale_go_imports_executable    = 'gofumports',
    ale_go_golangci_lint_package = 1,
    ale_disable_lsp              = 1,

    -- completion nvim

    completion_enable_snippet    = 'vim-vsnip',
    completion_enable_auto_paren = 1,

    -- diagnostic

    diagnostic_enable_virtual_text = 1,
    diagnostic_virtual_text_prefix = ' ',
    diagnostic_insert_delay = 1,

    -- gopher

    -- gopher_map = 0, -- diable gopher default mappings

    -- editor config

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
    packer_compile = {
        'BufWritePost plugins.lua PackerCompile',
    },
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
    highlight_on_yank = {
        'TextYankPost * silent! lua vim.highlight.on_yank()',
    },
    spell_check = {
        'FileType markdown,gitcommit,latex,text,tex setlocal spell',
    },
    spell_check_journal_lang = {
        'BufRead,BufNewFile,BufEnter */journal/* setlocal spelllang=ca',
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

function _G.show_documentation()
	if vim.tbl_contains({'vim', 'help'}, vim.bo.filetype) then
		vim.api.nvim_command('help ' .. vim.fn.expand('<cword>'))
	else
        vim.lsp.buf.hover()
	end
end

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
