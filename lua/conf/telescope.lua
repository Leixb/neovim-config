local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<c-k>"] = actions.move_selection_previous,
                ["<c-j>"] = actions.move_selection_next,
                ["<c-d>"] = actions.close,
            },
        },
    }
}
