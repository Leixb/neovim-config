" ALE
let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \   'css': ['prettier', 'stylelint'],
      \   'javascript': ['eslint', 'prettier'],
      \   'python': ['isort', 'black'],
      \   'HTML': ['HTMLHint', 'proselint'],
      \   'ruby': ['rubocop'],
      \   'go': ['gofmt', 'goimports'],
      \}

 let g:ale_linters = {
             \ 'go': ['staticcheck', 'golangci-lint'],
             \}
" let g:ale_linters = {'go': ['gofmt', 'golint', 'govet', 'golangci-lint']}

let g:ale_fix_on_save = 1

let g:ale_go_imports_executable = 'gofumports'
let g:ale_go_golangci_lint_package = 1

let g:ale_disable_lsp = 1
