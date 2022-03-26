local parser_configs = require'nvim-treesitter.parsers'.get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = 'https://github.com/nvim-neorg/tree-sitter-norg',
        files = { 'src/parser.c', 'src/scanner.cc' },
        branch = 'main'
    },
}

require'nvim-treesitter.configs'.setup {
    highlight = {enable = true},
    ensure_installed = 'maintained',
    indent = {enable = true},
    autopairs = {enable = true},
    rainbow = {enable = true},
    autotag = {enable = true},
    context_commentstring = {enable = true},
}
