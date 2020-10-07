filetype plugin on

" Set space as map leader
nnoremap <Space> <Nop>
let mapleader=" "

" File configuration for nvim
if !has('nvim')
    echoerr "not nvim"
    exit 1
endif

" Install vim-plug
if empty(stdpath('config') . '/autoload/plug.vim')
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin(stdpath('data') . '/plugged')

Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" colorschemes
Plug 'sainnhe/sonokai'
"Plug 'nvim-treesitter/nvim-treesitter'

Plug 'ryanoasis/vim-devicons'

" linters
Plug 'dense-analysis/ale'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'Shougo/echodoc.vim'

" go
" Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'sebdah/vim-delve'
Plug 'arp242/gopher.vim'

" Latex
Plug 'lervag/vimtex'

" helpers
" Plug 'jiangmiao/auto-pairs'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
" Plug 'mattn/emmet-vim'
" Plug 'romainl/vim-qf'

Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

" Smooth scrolling and window openings
" Plug 'psliwka/vim-smoothie'
" Plug 'camspiers/animate.vim'

" Plug 'scrooloose/nerdtree'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-eunuch'

Plug 'junegunn/vim-easy-align'

" git
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/vim-gitbranch'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

call plug#end()

" Colorscheme
set termguicolors     " enable true colors support
"
" Coc lightline config
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
\ },
\ 'tabline': {
\   'left': [ ['buffers'] ],
\   'right': [ ['tabs'] ]
\ },
\ 'component_function': {
\   'cocstatus': 'coc#status'
\ },
\ 'component_expand': {
\   'buffers': 'lightline#bufferline#buffers'
\ },
\ 'component_type': {
\   'buffers': 'tabsel'
\ },
\ }

let g:sonokai_style = 'atlantis'
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 1

colorscheme sonokai

" Options

set encoding=utf-8

let g:tex_flavor = 'latex'

set showtabline=2

set cursorline

set autoindent
set smartindent

set backspace=indent,eol,start

set complete-=i
set completeopt+=noselect

set hidden

set hlsearch
set incsearch

set nobackup
set noshowmode

set number
set ruler

set scrolloff=10

set expandtab
set shiftwidth=4
set smarttab
set softtabstop=4
set tabstop=4

set textwidth=80

set title

set updatetime=100

set wildmenu
set virtualedit=block

set ignorecase smartcase infercase
set splitbelow

" coc recomended settings
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see coc #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Mappings

inoremap jk <ESC>
cnoremap jk <ESC>

tnoremap <ESC> <C-\><C-n>

nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-h> <C-W><C-h>

nnoremap <silent> <F1> :tabprevious<CR>
nnoremap <silent> <F2> :bprevious!<CR>
nnoremap <silent> <F3> :bnext!<CR>
nnoremap <silent> <F4> :tabnext<CR>

nnoremap Y y$

nnoremap n nzzzv
nnoremap N Nzzzv

" Commands

command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
            \ | wincmd p | diffthis

command! VimConfig edit $MYVIMRC


" Plugin configs
"

" Emmet
" let g:user_emmet_mode='a'
" let g:user_emmet_leader_key='<Tab>'
" let g:user_emmet_settings= {
"     \ 'javascript.jsx' : {
"     \ 'extends': 'jsx',
"     \ },
" \}

" vim go
let g:go_fmt_autosave = 0 " Let ALE handle gofmt on save
let g:go_code_completion_enabled = 0 "Let coc handle it
let g:go_gopls_enabled = 0 "Disable gopls (let coc handle it)

" let g:go_highlight_structs = 1
" let g:go_highlight_interfaces = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_function_parameters = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_types = 1
" let g:go_hightlight_fields = 1
" let g:go_highlight_generate_tags = 1
" let g:go_highlight_variable_declarations = 1
" let g:go_highlight_variable_assignments = 1
" let g:go_addtags_transform = "snakecase"

" netrw
let g:netrw_banner = 0     " Hide annoying 'help' banner
let g:netrw_liststyle = 3  " Use tree view
let g:netrw_winsize = '30' " Smaller default window size

" load custom configs
for s:name in ['ale', 'coc', 'denite']
    execute 'source ' . stdpath('config') . '/' . s:name . '.vim'
endfor

" vimtex

let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_use_temp_files = 1
let g:vimtex_compiler_latexmk = {
    \ 'backend' : 'nvim',
    \ 'background' : 1,
    \ 'build_dir' : '',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-shell-escape',
    \   '-interaction=nonstopmode',
    \ ],
    \}

" Disable ultisnips mappings
let g:UltiSnipsExpandTrigger="<Nop>"
let g:UltiSnipsJumpForwardTrigger="<Nop>"
let g:UltiSnipsJumpBackwardTrigger="<Nop>"
