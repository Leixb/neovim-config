" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
	\ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
	\ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
	\ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
	\ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
	\ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
	\ denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
  imap <silent><buffer> jk <Plug>(denite_filter_quit)
endfunction

" Change file/rec command.
call denite#custom#var('file/rec', 'command',
      \ ['rg', '--files', '--glob', '!.git'])
" Add custom menus
let s:menus = {}

let s:menus.zsh = {
      \ 'description': 'Edit your import zsh configuration'
      \ }
let s:menus.zsh.file_candidates = [
      \ ['zshrc', '~/.config/zsh/.zshrc'],
      \ ['zshenv', '~/.zshenv'],
      \ ]

let s:menus.my_commands = {
      \ 'description': 'Example commands'
      \ }
let s:menus.my_commands.command_candidates = [
      \ ['Split the window', 'vnew'],
      \ ['Open zsh menu', 'Denite menu:zsh'],
      \ ['Format code', 'FormatCode', 'go,python'],
      \ ]

call denite#custom#var('menu', 'menus', s:menus)


" Ripgrep command on grep source
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
      \ ['-i', '--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Change ignore_globs
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])
