vim.cmd [[packadd nvim-web-devicons]]

require'lualine'.setup({
    options     = { theme = 'nightfly', },
    sections    = {
        lualine_c = { 'filename', {'diagnostics', sources = {'nvim_diagnostic'}}, 'lsp_progress' },
    },
})
