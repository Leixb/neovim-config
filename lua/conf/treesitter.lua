local parser_configs = require'nvim-treesitter.parsers'.get_parser_configs()

require'nvim-treesitter.configs'.setup {
    highlight = {enable = true},
    indent = {enable = true},
    autopairs = {enable = true},
    rainbow = {enable = true},
    autotag = {enable = true},
    context_commentstring = {enable = true},
}
