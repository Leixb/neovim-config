require'rust-tools'.setup({
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        runnables = { use_telescope = true },

        inlay_hints = {
            show_parameter_hints = true,
        },
    },
    server = {},
})
