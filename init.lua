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

    laststatus    = 3, -- Global statusline
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

    ['<F1>']  = {'<cmd>Neotree toggle<CR>', { noremap = true , silent = true, desc = "Neotree toggle" }},
    ['<F2>']  = {'<cmd>BufferPrevious<CR>',  { noremap = true , silent = true, desc = "BufferPrevious" }},
    ['<F3>']  = {'<cmd>BufferNext<CR>',      { noremap = true , silent = true, desc = "BufferNext" }},
    ['<F4>']  = {'<cmd>SymbolsOutline<CR>',     { noremap = true , silent = true, desc = "SymbolsOutline toggle" }},

    ['<F5>']  = {function() require'dapui'.toggle() end,     { noremap = true , silent = true, desc = "DapUI toggle" }},


    ['<F6>']       = {function() require'dap'.continue() end,                                             { noremap = true , silent = true, desc = "DAP continue"}},
    ['<F7>']       = {function() require'dap'.step_over() end,                                            { noremap = true , silent = true, desc = "DAP step over" }},
    ['<F8>']       = {function() require'dap'.step_into() end,                                            { noremap = true , silent = true, desc = "DAP step into"}},
    ['<F9>']       = {function() require'dap'.step_out() end,                                             { noremap = true , silent = true, desc = "DAP setp out" }},
    ['<leader>b']  = {function() require'dap'.toggle_breakpoint() end,                                    { noremap = true , silent = true, desc = "DAP toggle breakpoint"}},
    ['<leader>B']  = {function() require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { noremap = true , silent = true, desc = "DAP set conditional breakpoint"}},
    ['<leader>lp'] = {function() require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,{ noremap = true , silent = true, desc = "DAP log point" }},
    ['<leader>dr'] = {function() require'dap'.repl.open() end,                                            { noremap = true , silent = true, desc = "DAP repl"}},
    ['<leader>dl'] = {function() require'dap'.run_last() end,                                             { noremap = true , silent = true, desc = "DAP run last" }},

    ['<leader>bd'] = {'<cmd>BufferClose<CR>', {noremap = true, silent = true, desc = "BufferClose"}},

    ['<F12>'] = {'magg=G`a',             { noremap = true , silent = true, desc = "Reindent"}},

    ['Y'] = {'y$', {desc = "Yank till eol"}},

    ['n'] = {'nzzzv', {desc = "Next centered"}},
    ['N'] = {'Nzzzv', {desc = "Backwards Next centered"}},

    ['<leader>m'] = {'<cmd>Make<CR>', { noremap = true , silent = true, desc = "Make"}},

-- Telescope mappings

    ['<C-S-p>']          = {function() require'telescope.builtin'.git_files() end, {desc = "Telescope git_files"}},
    ['<C-p>']            = {function() require'telescope.builtin'.fd() end, {desc = "Telescope fd"}},
    ['<leader><leader>'] = {function() require'telescope.builtin'.buffers() end, {desc = "Telescope buffers"}},
    ['<Bs>']             = {function() require'telescope.builtin'.live_grep() end, {desc = "Telescope live_grep"}},
    ['<CR>']             = {function()
        if vim.bo.buftype == '' then
            require'telescope.builtin'.builtin()
        else
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, true, true), 'n')
        end
    end, {desc = 'Telescope'}},

-- LSP mappings

    ['[g']         = { vim.diagnostic.goto_prev,    { silent = true, desc = "Goto prev diagnostic"}},
    [']g']         = { vim.diagnostic.goto_next,    { silent = true, desc = "Goto next diagnostic" }},

    ['gd']         = { vim.lsp.buf.definition,      { silent = true, desc = "Goto definition" }},

    ['gy']         = { vim.lsp.buf.type_definition, { silent = true, desc = "Goto type definition" }},
    ['gi']         = { vim.lsp.buf.implementation,  { silent = true, desc = "Goto implementation" }},
    ['gr']         = { vim.lsp.buf.references,      { silent = true, desc = "Goto references"}},

    ['<leader>rn'] = {vim.lsp.buf.rename,                                               { noremap = true, silent = true, desc = "Rename" }},
    ['<leader>f']  = {vim.lsp.buf.formatting,                                           { desc = "Format buffer" }},
    ['<leader>a']  = {function() require'code_action_menu'.open_code_action_menu() end, { noremap = true, silent = true, desc = "Open code action menu"}},

    -- Close location, quickfix and help windows
    ['<leader>c']  = {'<cmd>ccl <bar> lcl <bar> helpc <CR>', {desc = "Close location, qf and help windows"}},

    ['K']          = {vim.lsp.buf.hover,         { silent = true, noremap = true, desc = "Hover definition"}},
    ['<c-S>']      = {vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = "Show signature help" }},

    ['<leader>ld'] = {vim.diagnostic.open_float,                 {silent = true, nowait = true, noremap = true, desc = "Show line diagnostics"}},
    ['<leader>d']  = {vim.diagnostic.setloclist,                 {silent = true, nowait = true, noremap = true, desc = "Set location list"}},
    ['<leader>i']  = {vim.lsp.buf.incoming_calls,                {silent = true, nowait = true, noremap = true, desc = "Show incoming calls"}},
    ['<leader>o']  = {vim.lsp.buf.outgoing_calls,                {silent = true, nowait = true, noremap = true, desc = "Show outgoing calls"}},
    ['<leader>s']  = {vim.lsp.buf.document_symbol,               {silent = true, nowait = true, noremap = true, desc = "Show document symbols"}},
    ['<leader>w']  = {vim.lsp.buf.workspace_symbol,              {silent = true, nowait = true, noremap = true, desc = "Show workspace symbols"}},
}

local imap = {
    ['jk']        = '<ESC>',
    ['<F13>']     = {'<Plug>luasnip-next-choice',     {silent = true, desc = "Luasnip next choice"}},
    ['']         = {'<Plug>luasnip-next-choice',     {silent = true, desc = "Luasnip next choice"}},
    ['<C-e>']     = {"compe#close('<C-e>')",          {silent = true, noremap = true, expr = true, desc = "compe close"}},
    ['<C-j>']     = {"compe#scroll({ 'delta': -4 })", {silent = true, noremap = true, expr = true, desc = "compe scroll up"}},
    ['<C-k>']     = {"compe#scroll({ 'delta': +4 })", {silent = true, noremap = true, expr = true, desc = "compe scroll down"}},

    ['<c-S>']     = {vim.lsp.buf.signature_help, {noremap = true, desc = "Show signature help"}},

    ['<M-;>']     = {'copilot#Accept("<M-;>")', {silent = true, noremap = true, expr = true, desc = "Copilot accept"}}
}

local smap = {
    ['<F13>']     = {'<Plug>luasnip-next-choice',                 {silent = true, desc = "Luasnip next choice"}},
    ['']         = {'<Plug>luasnip-next-choice',                 {silent = true, desc = "Luasnip next choice"}},
}
local xmap = {}
local omap = {}
local vmap = { }

local tmap = {
    ['<ESC>'] = {'<C-\\><C-n>', {desc = "Terminal ESC"}}
}

local cmap = {
    ['jk'] = {'<ESC>', {desc = "ESC"}}
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

    -- copilot
    copilot_no_tab_map = true,
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
    'BufRead',
    {
        pattern = 'flake.lock',
        callback = function()
            vim.bo.ft = 'json'
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
        callback = function() vim.highlight.on_yank() end,
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

vim.api.nvim_create_user_command(
    'DiffOrig',
    'vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis',
    {}
)

vim.api.nvim_create_user_command(
    'T',
    'split | terminal <args>',
    { nargs='*' }
)

vim.api.nvim_create_user_command(
    'VT',
    'vsplit | terminal <args>',
    { nargs='*' }
)

vim.api.nvim_create_user_command(
    'ClearRegisters',
    function() require'utils'.clear_registers() end,
    {}
)

vim.api.nvim_create_user_command(
    'Make',
    function() require'async_make'.make() end,
    {}
)
