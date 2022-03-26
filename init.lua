--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------

local opts = {
    encoding      = 'utf-8',
    termguicolors = true,

    backup        = false,
    writebackup   = false,
    undofile      = true,

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
    lazyredraw    = true,

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
    formatoptions = 'jcroql',

    omnifunc      = 'v:lua.vim.lsp.omnifunc',
}

for k, v in pairs(opts) do
	vim.opt[k] = v
end

--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------

-- Bootstrap packer into data (.local/share/nvim)
package.path = package.path .. ';'.. vim.fn.stdpath('data') .. '/plugin/packer_compiled.lua'
local ok, _ = pcall(require, 'packer_compiled')
-- vim.g.did_load_filetypes = 1
require'plugins'
if not ok then
    require'packer'.sync()
end

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

    ['<F1>']  = {'<cmd>NvimTreeToggle<CR>', { noremap = true , silent = true }},
    ['<F2>']  = {'<cmd>BufferPrevious!<CR>',  { noremap = true , silent = true }},
    ['<F3>']  = {'<cmd>BufferNext!<CR>',      { noremap = true , silent = true }},
    ['<F4>']  = {'<cmd>SymbolsOutline<CR>',     { noremap = true , silent = true }},

    ['<F5>']  = {function() require'dapui'.toggle() end,     { noremap = true , silent = true }},


    ['<F6>']       = {function() require'dap'.continue() end,                                             { noremap = true , silent = true }},
    ['<F7>']       = {function() require'dap'.step_over() end,                                            { noremap = true , silent = true }},
    ['<F8>']       = {function() require'dap'.step_into() end,                                            { noremap = true , silent = true }},
    ['<F9>']       = {function() require'dap'.step_out() end,                                             { noremap = true , silent = true }},
    ['<leader>b']  = {function() require'dap'.toggle_breakpoint() end,                                    { noremap = true , silent = true }},
    ['<leader>B']  = {function() require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { noremap = true , silent = true }},
    ['<leader>lp'] = {function() require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,{ noremap = true , silent = true }},
    ['<leader>dr'] = {function() require'dap'.repl.open() end,                                            { noremap = true , silent = true }},
    ['<leader>dl'] = {function() require'dap'.run_last() end,                                             { noremap = true , silent = true }},

    ['<leader>bd'] = {'<cmd>BufferClose<CR>', {noremap = true, silent = true}},

    ['<F12>'] = {'magg=G`a',             { noremap = true , silent = true }},

    ['Y'] = 'y$',

    ['n'] = 'nzzzv',
    ['N'] = 'Nzzzv',

    ['<leader>m'] = {'<cmd>Make<CR>', { noremap = true , silent = true }},

-- Telescope mappings

    ['<C-S-p>']          = function() require'telescope.builtin'.git_files() end,
    ['<C-p>']            = function() require'telescope.builtin'.fd() end,
    ['<leader><leader>'] = function() require'telescope.builtin'.buffers() end,
    ['<Bs>']             = function() require'telescope.builtin'.live_grep() end,

-- LSP mappings

    ['[g']         = { vim.lsp.diagnostic.goto_prev, { silent = true }},
    [']g']         = { vim.lsp.diagnostic.goto_next, { silent = true }},

    ['gd']         = { vim.lsp.buf.definition,      { silent = true }},

    ['gy']         = { vim.lsp.buf.type_definition, { silent = true }},
    ['gi']         = { vim.lsp.buf.implementation,  { silent = true }},
    ['gr']         = { vim.lsp.buf.references,      { silent = true }},

    ['<leader>rn'] = {function() require'lspsaga.rename'.rename() end,          { noremap = true, silent = true }},
    ['<leader>f']  = {vim.lsp.buf.formatting,                    {}},
    ['<leader>a']  = {function() require'lspsaga.codeaction'.code_action() end, { noremap = true, silent = true }},

    -- Close location, quickfix and help windows
    ['<leader>c']  = {'<cmd>ccl <bar> lcl <bar> helpc <CR>', {}},

    ['K']          = {function() require'lspsaga.hover'.render_hover_doc() end,         {silent = true, noremap = true}},
    ['<c-S>']      = {function() require'lspsaga.signaturehelp'.signature_help() end, { noremap = true, silent = true }},

    ['<leader>ld'] = {vim.lsp.diagnostic.show_line_diagnostics,  {silent = true, nowait = true, noremap = true}},
    ['<leader>d']  = {vim.lsp.diagnostic.set_loclist,            {silent = true, nowait = true, noremap = true}},
    ['<leader>i']  = {vim.lsp.buf.incoming_calls,                {silent = true, nowait = true, noremap = true}},
    ['<leader>o']  = {vim.lsp.buf.outgoing_calls,                {silent = true, nowait = true, noremap = true}},
    ['<leader>s']  = {vim.lsp.buf.document_symbol,               {silent = true, nowait = true, noremap = true}},
    ['<leader>w']  = {vim.lsp.buf.workspace_symbol,              {silent = true, nowait = true, noremap = true}},
}

local imap = {
    ['jk']        = '<ESC>',
    ['<F13>']     = {'<Plug>luasnip-next-choice',     {silent = true}},
    ['']         = {'<Plug>luasnip-next-choice',     {silent = true}},
    ['<C-e>']     = {"compe#close('<C-e>')",          {silent = true, noremap = true, expr = true}},
    ['<C-k>']     = {"compe#scroll({ 'delta': +4 })", {silent = true, noremap = true, expr = true}},
    ['<C-j>']     = {"compe#scroll({ 'delta': -4 })", {silent = true, noremap = true, expr = true}},

    ['<c-S>']     = {vim.lsp.buf.signature_help, {noremap = true}},
}

local smap = {
    ['<F13>']     = {'<Plug>luasnip-next-choice',                 {silent = true}},
    ['']         = {'<Plug>luasnip-next-choice',                 {silent = true}},
}
local xmap = {}
local omap = {}
local vmap = { }

local tmap = {
    ['<ESC>'] = '<C-\\><C-n>',
}

local cmap = {
    ['jk'] = '<ESC>',
}

local default_args = { noremap = true }

for mode, map in pairs({ n = nmap, v = vmap, s = smap, t = tmap, c = cmap, i = imap, x = xmap, o = omap }) do
    for from, to in pairs(map) do
        if type(to) == 'table' then
            vim.keymap.set(mode, from, to[1], to[2])
        else
            vim.keymap.set(mode, from, to, default_args)
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

    -- diagnostic

    diagnostic_enable_virtual_text = 1,
    diagnostic_virtual_text_prefix = ' ',
    diagnostic_insert_delay = 1,

    -- editor config

    EditorConfig_exclude_patterns = {'fugitive://.*'},

    -- barbar

    bufferline = {
        closable = false,
    },

    -- nvim-R

    -- R_user_maps_only = 1,
    R_assign = 0,
}

for k,v in pairs(vars) do
	vim.g[k] = v
    -- vim.api.nvim_set_var(k, v)
end

--------------------------------------------------------------------------------
-- augroups
--------------------------------------------------------------------------------

local group_id = vim.api.nvim_create_augroup('init.lua.group', {})

vim.api.nvim_create_autocmd(
    'TermOpen',
    {
        pattern = 'term://*',
        callback = function()
            vim.wo.number = false
        end,
        group = group_id
    })

vim.api.nvim_create_autocmd(
    'TermOpen',
    {
        pattern = '*',
        command = 'startinsert',
        group = group_id
    })

vim.api.nvim_create_autocmd(
    'TextYankPost',
    {
        pattern = '*',
        callback = vim.highlight.on_yank,
        group = group_id
    })

vim.api.nvim_create_autocmd(
    'FileType',
    {
        pattern = {
            'gitcommit',
            'gitrebase',
            'latex',
            'markdown',
            'rmd',
            'tex',
            'text',
        },
        command = 'setlocal spell',
        group = group_id
    })

--------------------------------------------------------------------------------
-- commands
--------------------------------------------------------------------------------

vim.api.nvim_add_user_command(
    'DiffOrig',
    'vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis',
    {}
)

vim.api.nvim_add_user_command(
    'T',
    'split | terminal <args>',
    { nargs='*' }
)

vim.api.nvim_add_user_command(
    'VT',
    'vsplit | terminal <args>',
    { nargs='*' }
)

vim.api.nvim_add_user_command(
    'ClearRegisters',
    function() require'utils'.clear_registers() end,
    {}
)

vim.api.nvim_add_user_command(
    'Make',
    function() require'async_make'.make() end,
    {}
)

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
