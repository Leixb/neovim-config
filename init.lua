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

-- Bootstrap packer into data (.local/share/nvim)
package.path = package.path .. ';'.. require('packer.util').join_paths(vim.fn.stdpath('data'), 'plugin', 'packer_compiled.lua')
local ok, err = pcall(require, 'packer_compiled') 
vim.g.did_load_filetypes = 1
require('plugins')
if not ok then 
    require('packer').sync()
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

    ['<F5>']  = {'<cmd>lua require("dapui").toggle()<CR>',     { noremap = true , silent = true }},


    ['<F6>']       = {"<cmd>lua require'dap'.continue()<CR>",                                             { noremap = true , silent = true }},
    ['<F7>']       = {"<cmd>lua require'dap'.step_over()<CR>",                                            { noremap = true , silent = true }},
    ['<F8>']       = {"<cmd>lua require'dap'.step_into()<CR>",                                            { noremap = true , silent = true }},
    ['<F9>']       = {"<cmd>lua require'dap'.step_out()<CR>",                                             { noremap = true , silent = true }},
    ['<leader>b']  = {"<cmd>lua require'dap'.toggle_breakpoint()<CR>",                                    { noremap = true , silent = true }},
    ['<leader>B']  = {"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { noremap = true , silent = true }},
    ['<leader>lp'] = {"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",{ noremap = true , silent = true }},
    ['<leader>dr'] = {"<cmd>lua require'dap'.repl.open()<CR>",                                            { noremap = true , silent = true }},
    ['<leader>dl'] = {"<cmd>lua require'dap'.run_last()<CR>",                                             { noremap = true , silent = true }},

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

    -- ['<leader>rn'] = {'<cmd>lua vim.lsp.buf.rename()<CR>',      {}},
    ['<leader>rn'] =  {"<cmd>lua require('lspsaga.rename').rename()<CR>", { noremap = true, silent = true }},
    ['<leader>f']  = {'<cmd>lua vim.lsp.buf.formatting()<CR>',  {}},
    -- ['<leader>a']  = {'<cmd>lua vim.lsp.buf.code_action()<CR>', {}},
    ['<leader>a'] =  {"<cmd>lua require('lspsaga.codeaction').code_action()<CR>", { noremap = true, silent = true }},

    -- Close location, quickfix and help windows
    ['<leader>c']  = {'<cmd>ccl <bar> lcl <bar> helpc <CR>', {}},

    -- ['K']          = {'<cmd>lua show_documentation()<CR>',         {silent = true, noremap = true}},
    ['K']          = {"<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>",         {silent = true, noremap = true}},
    -- ['<c-S>']      = {'<cmd>lua vim.lsp.buf.signature_help()<CR>', {noremap = true}},
    ['<c-S>']      = {"<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", { noremap = true, silent = true }},

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
    ['<F13>']     = {'<Plug>luasnip-next-choice',                 {silent = true}},
    ['']         = {'<Plug>luasnip-next-choice',                 {silent = true}},
    -- ['<C-space>'] = {'<Plug>(completion_trigger)',             {silent = true}},
    -- ['<c-p>']     = {'<Plug>(completion_trigger)',             {silent = true}},
    -- inoremap <silent><expr> <C-Space> compe#complete()
    -- ['<C-space>']  = {'compe#complete()', {silent = true, noremap = true, expr = true}},
    -- ['<CR>']  = {[[compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))]], {silent = true, noremap = true, expr = true}},
    ['<C-e>'] = {"compe#close('<C-e>')", {silent = true, noremap = true, expr = true}},
    ['<C-k>'] = {"compe#scroll({ 'delta': +4 })", {silent = true, noremap = true, expr = true}},
    ['<C-j>'] = {"compe#scroll({ 'delta': -4 })", {silent = true, noremap = true, expr = true}},

    -- ['<TAB>']     = {'pumvisible() ? "\\<C-n>" : "\\<TAB>"',   {silent = true, noremap = true, expr = true}},
    -- ['<S-TAB>']   = {'pumvisible() ? "\\<C-p>" : "\\<S-TAB>"', {silent = true, noremap = true, expr = true}},
    -- ['<TAB>']  = {'v:lua.tab_complete()', {silent = true, noremap = false, expr = true}},
    -- ['<S-TAB>']  = {'v:lua.s_tab_complete()', {silent = true, noremap = false, expr = true}},

    -- ['<F13>']  = {'v:lua.F13_complete()', {silent = true, noremap = false, expr = true}},
    -- ['<S-F13>']  = {'v:lua.s_F13_complete()', {silent = true, noremap = false, expr = true}},

    ['<c-S>']     = {'<cmd>lua vim.lsp.buf.signature_help()<CR>', {noremap = true}},
}

local smap = {
    ['<F13>']     = {'<Plug>luasnip-next-choice',                 {silent = true}},
    ['']         = {'<Plug>luasnip-next-choice',                 {silent = true}},
}
local xmap = {}
local omap = {}
local vmap = {
    -- ['<TAB>']  = {'v:lua.tab_complete()', {silent = true, noremap = false, expr = true}},
    -- ['<S-TAB>']  = {'v:lua.s_tab_complete()', {silent = true, noremap = false, expr = true}},

    -- ['<F13>']  = {'v:lua.F13_complete()', {silent = true, noremap = false, expr = true}},
    -- ['<S-F13>']  = {'v:lua.s_F13_complete()', {silent = true, noremap = false, expr = true}},
}

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


local augroups = {
    term = {
        'TermOpen term://* setlocal nonumber',
        'TermOpen * startinsert',
    },
    lsp_highlight = {
        'CursorHold  <buffer> silent! lua vim.lsp.buf.document_highlight()',
        'CursorHoldI <buffer> silent! lua vim.lsp.buf.document_highlight()',
        'CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()',
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
    "ClearRegisters silent lua require'utils'.clear_registers()",
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
