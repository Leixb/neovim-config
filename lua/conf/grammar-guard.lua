require("grammar-guard").init()

require("lspconfig").grammar_guard.setup({
    cmd = {"/home/leix/.local/share/nvim/lsp_servers/ltex/ltex-ls/bin/ltex-ls"},
    settings = {
        ltex = {
            enabled = { "latex", "tex", "bib", "markdown" },
            language = "en",
            diagnosticSeverity = "information",
            setenceCacheSize = 2000,
            additionalRules = {
                enablePickyRules = true,
                motherTongue = "en",
            },
            trace = { server = "verbose" },
            dictionary = {},
            disabledRules = {},
            hiddenFalsePositives = {},
        },
    },
})
