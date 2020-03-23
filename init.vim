" Install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'

Plug 'tpope/vim-abolish'
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'

" Async Make
Plug 'neomake/neomake'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-denite'

Plug 'tmhedberg/matchit'

Plug 'Raimondi/delimitMate'

" Syntax check
Plug 'dense-analysis/ale'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Language specific
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['latex']
Plug 'lervag/vimtex'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_use_temp_files = 1
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'vimwiki/vimwiki'

" Theming

Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons', ($TERM == 'xterm-256color')? {} : {'on' : []}
call plug#end()

" Plugin Configuration

let g:go_fmt_autosave = 0 " Let ALE handle gofmt on save
let g:go_code_completion_enabled = 0 "Let coc handle it

" denite option
source $HOME/.config/nvim/denite.vim

let g:ale_linters = {'go': ['gofmt', 'golint', 'govet']}

let g:ale_sign_error = ' '
let g:ale_sign_warning = ' '

let g:delimitMate_expand_cr=1
let g:delimitMate_expand_space=1

" let g:UltiSnipsExpandTrigger="<F13>"
" let g:UltiSnipsJumpForwardTrigger="<F13>"
" let g:UltiSnipsJumpBackwardTrigger="<S-F13>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<Nop>"
let g:UltiSnipsJumpForwardTrigger="<Nop>"
let g:UltiSnipsJumpBackwardTrigger="<Nop>"
let g:UltiSnipsSnippetsDir="$HOME/.config/nvim/UltiSnips"

let g:coc_snippet_next = '<F13>'
let g:coc_snippet_prev = '<S-F13>'

let g:coc_global_extensions = ['coc-snippets', 'coc-java', 'coc-json', 'coc-tsserver', 'coc-python', 'coc-html', 'coc-css']

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight symbol under cursor on CursorHold

augroup CocAuGroup
    autocmd!
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" let g:ale_fix_on_save = 1
let g:ale_fixers = {
            \		'*': [
            \			'remove_trailing_lines',
            \			'trim_whitespace'
            \		],
            \		'go' : [
            \			'gofmt',
            \		],
            \		'python' : [
            \			'black',
            \			'add_blank_lines_for_python_control_statements',
            \			'reorder-python-imports',
            \		],
            \		'elm' : [
            \			'elm-format'
            \ 	],
            \		'java' : [
            \			'google_java_format'
            \		]
            \	}
let g:ale_java_google_java_format_options = '--aosp --skip-sorting-imports'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1

if &term!~'linux'
    let g:airline_powerline_fonts = 1
endif

" Mappings

let mapleader=" "
inoremap jk <Esc>
cnoremap jk <C-c>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

tnoremap <Esc> <C-\><C-n>

nnoremap Y y$

nnoremap <silent> <F1> :tabprevious<CR>
nnoremap <silent> <F2> :bp!<CR>
nnoremap <silent> <F3> :bn!<CR>
nnoremap <silent> <F4> :tabnext<CR>

nnoremap <F12> mtgg=G`t

inoremap <C-U> <C-G>u<C-U>

" Plugin Maps

nnoremap <C-p> :Denite file/rec -start-filter<CR>

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <F13> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<F13>"

let g:coc_snippet_next = '<F13>'
let g:coc_snippet_prev = '<S-F13>'


" imap <F13> <Plug>(coc-snippets-expand)
" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf <Plug>(coc-refactor)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Settings
set ignorecase smartcase infercase

set title

" coc.nvim recommended settings
set hidden
set updatetime=300
set shortmess+=c

set number

set synmaxcol=200

set noshowmode

set tabstop=4
set sw=4
set expandtab

set scrolloff=3

command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
            \ | wincmd p | diffthis

command! VimConfig edit ~/.config/nvim/init.vim

" Colorscheme

if &term=~'linux'
    colorscheme elflord
else
    colorscheme base16-gruvbox-dark-medium
    set termguicolors
endif

" set default tex flavor to LaTeX
let g:tex_flavor = "latex"

autocmd FileType markdown autocmd BufWritePost <buffer> !pandoc % -o %:r.pdf
