local api = vim.api

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
    api.nvim_command('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
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

    expandtab     = true,
    smarttab      = true,

    ignorecase    = true,
    smartcase     = true,
    infercase     = true,

    splitbelow    = true,
    splitright    = true,

    showmode      = false,

    cmdheight     = 2,

    updatetime    = 300,

    title         = true,

    wildmenu      = true,
    hidden        = true,
    scrolloff     = 10,
    showtabline   = 2,

    hlsearch      = true,
    incsearch     = true,

    virtualedit   = 'block',
    backspace     = 'indent,eol,start',
}

local win_opts = {
    cursorline = true,
    number     = true,
    signcolumn = 'yes',
}

local buf_opts = {
    autoindent  = true,
    smartindent = true,

    shiftwidth  = 4,
    softtabstop = 4,
    tabstop     = 4,

    textwidth   = 80,
}

for k, v in pairs(global_opts) do
	vim.o[k] = v
    -- api.nvim_set_option(k, v)
end

for k, v in pairs(buf_opts) do
	vim.o[k] = v
	vim.bo[k] = v
    -- api.nvim_set_option(k, v)
    -- api.nvim_buf_set_option(0, k, v)
end

for k, v in pairs(win_opts) do
	vim.o[k] = v
	vim.wo[k] = v
    -- api.nvim_set_option(k, v)
    -- api.nvim_win_set_option(0, k, v)
end

--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------

local plugins = {
    'itchyny/lightline.vim',
    'mengelbrecht/lightline-bufferline',

    'sainnhe/sonokai',

    'ryanoasis/vim-devicons',

    'dense-analysis/ale',

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

    'airblade/vim-gitgutter',
    'itchyny/vim-gitbranch',
    'junegunn/gv.vim',
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    {'neoclide/coc.nvim', { branch ='release' } },
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
-- Mappings
--------------------------------------------------------------------------------

local nmap = {
    ['<Space>'] = '',

    ['<C-j>'] = '<C-w><C-j>',
    ['<C-k>'] = '<C-w><C-k>',
    ['<C-l>'] = '<C-w><C-l>',
    ['<C-h>'] = '<C-w><C-h>',

    ['<F1>'] = {':tabprevious<CR>', { noremap = true , silent = true}},
    ['<F2>'] = {':bprevious!<CR>',  { noremap = true , silent = true}},
    ['<F3>'] = {':bnext!<CR>',      { noremap = true , silent = true}},
    ['<F4>'] = {':tabnext<CR>',     { noremap = true , silent = true}},

    ['Y'] = 'y$',
    ['n'] = 'nzzzv',
    ['N'] = 'Nzzzv',

-- Denite mappings

    ['<C-p>'] = ':DeniteProjectDir file/rec<CR>',
    ['\\']    = ':Denite buffer<CR>',
    ['<Bs>']  = ':Denite grep:. -no-empty<CR>',

-- Coc mappings

    ['[g']         = {'<Plug>(coc-diagnostic-prev)',         { silent = true }},
    [']g']         = {'<Plug>(coc-diagnostic-next)',         { silent = true }},
    ['gd']         = {'<Plug>(coc-definition)',              { silent = true }},
    ['gy']         = {'<Plug>(coc-type-definition)',         { silent = true }},
    ['gi']         = {'<Plug>(coc-implementation)',          { silent = true }},
    ['gr']         = {'<Plug>(coc-references)',              { silent = true }},

    ['<leader>rn'] = {'<Plug>(coc-rename)',                  {}},
    ['<leader>f']  = {'<Plug>(coc-format-selected)',         {}},
    ['<leader>a']  = {'<Plug>(coc-codeaction-selected)',     {}},

    ['K']          = {':call v:lua.show_documentation()<CR>', {silent = true, noremap = true}},

-- Remap keys for applying codeAction to the current buffer.
    ['<leader>ac'] = {'<Plug>(coc-codeaction)',              {}},
    ['<leader>qf'] = {'<Plug>(coc-fix-current)',             {}},

    ['<C-s>']      = { '<Plug>(coc-range-select)',           {silent = true}},

-- Coclist mappings

    ['<leader>a']  = {':<C-u>CocList diagnostics<cr>',       {silent = true, nowait = true, noremap = true}},
    ['<leader>e']  = {':<C-u>CocList extensions<cr>',        {silent = true, nowait = true, noremap = true}},
    ['<leader>c']  = {':<C-u>CocList commands<cr>',          {silent = true, nowait = true, noremap = true}},
    ['<leader>o']  = {':<C-u>CocList outline<cr>',           {silent = true, nowait = true, noremap = true}},
    ['<leader>s']  = {':<C-u>CocList -I symbols<cr>',        {silent = true, nowait = true, noremap = true}},
    ['<leader>j']  = {':<C-u>CocNext<CR>',                   {silent = true, nowait = true, noremap = true}},
    ['<leader>k']  = {':<C-u>CocPrev<CR>',                   {silent = true, nowait = true, noremap = true}},
    ['<leader>p']  = {':<C-u>CocListResume<CR>',             {silent = true, nowait = true, noremap = true}},
}

local imap = {
    ['jk']        = '<ESC>',
    ['<F13>']     = { [[ pumvisible() ? coc#_select_confirm() : coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" : v:lua.check_back_space() ? "\<F13>" : coc#refresh() ]] , {silent = true, noremap = true, expr = true}},
    ['<S-F13>']   = {'<C-p>',                                                                               {silent = true, noremap = true}},
    ['<TAB>']     = {'pumvisible() ? "\\<C-n>" : "\\<TAB>"',                                                {silent = true, noremap = true, expr = true}},
    ['<S-TAB>']   = {'pumvisible() ? "\\<C-p>" : "\\<C-h>"',                                                {silent = true, noremap = true, expr = true}},
    ['<C-space>'] = {'coc#refresh()',                                                                       {silent = true, noremap = true, expr = true}},
    ['<CR>']      = {'pumvisible() ? coc#_select_confirm() : "\\<C-g>u\\<CR>\\<c-r>=coc#on_enter()\\<CR>"', {silent = true, noremap = true, expr = true}},
}

-- Map function and class text objects
local xmap = {
    ['if']        = '<Plug>(coc-funcobj-i)',
    ['af']        = '<Plug>(coc-funcobj-a)',
    ['ic']        = '<Plug>(coc-classobj-i)',
    ['ac']        = '<Plug>(coc-classobj-a)',
    ['<leader>f'] = '<Plug>(coc-format-selected)',
    ['<leader>a'] = '<Plug>(coc-codeaction-selected)',
    ['<C-s>']     = {'<Plug>(coc-range-select)', { silent = true }}}

local omap = {
    ['if']        = '<Plug>(coc-funcobj-i)',
    ['af']        = '<Plug>(coc-funcobj-a)',
    ['ic']        = '<Plug>(coc-classobj-i)',
    ['ac']        = '<Plug>(coc-classobj-a)',
}

local vmap = { }

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
            api.nvim_set_keymap(mode, from, to[1], to[2])
        else
            api.nvim_set_keymap(mode, from, to, default_args)
        end
    end
end

--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------

local vars = {
    mapleader                      = ' ';

    sonokai_style                  = 'atlantis';
    sonokai_enable_italic          = 0;
    sonokai_disable_italic_comment = 1;

    netrw_banner    = 0;
    netrw_liststyle = 3;
    netrw_winsize   = 30;

    tex_flavor = 'latex';

    vimtex_compiler_progname   = 'nvr';
    vimtex_view_method         = 'zathura';
    vimtex_view_use_temp_files = 1;
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
    };

    UltiSnipsExpandTrigger       = '<Nop>';
    UltiSnipsJumpForwardTrigger  = '<Nop>';
    UltiSnipsJumpBackwardTrigger = '<Nop>';

    lightline = {
        colorscheme        = 'wombat',
        active             = {
            left           = { { 'mode', 'paste' }, { 'cocstatus', 'readonly', 'filename', 'modified' } }
        },
        tabline            = {
            left           = { { 'buffers' } },
            right          = { { 'tabs' } }
        },
        component_function = {
            cocstatus      = 'coc#status'
        },
        component_expand   = {
            buffers        = 'lightline#bufferline#buffers'
        },
        component_type     = {
            buffers        = 'tabsel'
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
        go = {'staticcheck', 'golangci-lint'},
    },
    ale_fix_on_save = 1,
    ale_go_imports_executable = 'gofumports',
    ale_go_golangci_lint_package = 1,
    ale_disable_lsp = 1,

    -- COC

    coc_global_extensions = {
        'coc-clangd',
        'coc-css',
        'coc-dictionary',
        'coc-emoji',
        'coc-git',
        'coc-go',
        'coc-highlight',
        'coc-html',
        'coc-java',
        'coc-json',
        'coc-lists',
        'coc-pairs',
        'coc-prettier',
        'coc-python',
        'coc-rls',
        'coc-snippets',
        'coc-syntax',
        'coc-tag',
        'coc-tsserver',
        'coc-vimlsp',
        'coc-vimtex',
        'coc-word',
        'coc-yank',
    },
    coc_snippet_next = '<F13>',
    coc_snippet_prev = '<S-F13>',
}

for k,v in pairs(vars) do
	vim.g[k] = v
    -- api.nvim_set_var(k, v)
end

--------------------------------------------------------------------------------
-- Colorscheme
--------------------------------------------------------------------------------

api.nvim_command('colorscheme sonokai')

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
    coc = {
        "CompleteDone * if pumvisible() == 0 | pclose | endif",
        "CursorHold * silent call CocActionAsync('highlight')",
        "FileType typescript,json setl formatexpr=CocAction('formatSelected')",
        "User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')",
    },
    lightline = {
        'User CocStatusChange,CocDiagnosticChange call lightline#update()'
    },
}

for augroup, autocmds in pairs(augroups) do
    api.nvim_command(('augroup leixb-%s'):format(augroup))
    api.nvim_command('autocmd!')
    for _, autocmd in ipairs(autocmds) do api.nvim_command(('autocmd %s'):format(autocmd)) end
    api.nvim_command('augroup end')
end

--------------------------------------------------------------------------------
-- commands
--------------------------------------------------------------------------------

local commands = {
    'DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis',
    'VimConfig edit $MYVIMRC',
    "-nargs=0 Format :call CocAction('format')",
    "-nargs=? Fold   :call CocAction('fold', <f-args>)",
    "-nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')",
}

for _, c in pairs(commands) do
    api.nvim_command('command! ' .. c)
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

function denite_filter_settings()
    local bindings = {
        ['<CR>']  = 'do_action',
        ['<ESC>'] = 'quit',
        ['<C-t>'] = {'do_action', 'tabopen'},
        ['<C-v>'] = {'do_action', 'vsplit'},
        ['<C-h>'] = {'do_action', 'split'},
        ['.']     = 'toggle_select',
    }
    for k,v in pairs(bindings) do
        denite_map('i', k, v)
    end
    local bindings_noexpr = {
        ['<C-o>'] = '<Plug>(denite_filter_quit)',
        ['jk']    = '<Plug>(denite_filter_quit)',
    }
    for k,v in pairs(bindings_noexpr) do
        denite_map_noexpr(k, v)
    end
end

function denite_window_settings()
    local bindings = {
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
    }
    for k,v in pairs(bindings) do
        denite_map('n', k, v)
    end
end

function denite_map_noexpr(key, action)
    api.nvim_buf_set_keymap(0, 'i', key, action, { silent = true, noremap = true })
end

function denite_map(mode, key, action)
    if type(action) == 'table' then
        action = ("denite#do_map('%s', '%s')"):format(action[1], action[2])
    else
        action = ("denite#do_map('%s')"):format(action)
    end
    api.nvim_buf_set_keymap(0, mode, key, action, { silent = true, expr = true, noremap = true })
end

--------------------------------------------------------------------------------
-- Helper funcitons
--------------------------------------------------------------------------------

function check_back_space()
  local pos = api.nvim_win_get_cursor(0)
  if pos[2] == 0 then return true end

  local line = api.nvim_get_current_line()
  local c = string.sub(line, pos[2], pos[2])
  return vim.regex('^\\s$"'):match_str(c)
end

function show_documentation()
	if vim.tbl_contains({'vim', 'help'}, vim.bo.filetype) then
		local cword = vim.fn.expand('<cword>')
		api.nvim_command('help ' .. cword)
	else
		vim.fn.CocActionAsync('doHover')
	end
end
