vim.cmd [[packadd nvim-web-devicons]]

require'lualine'.setup({
    options     = { globalstatus = true, theme = 'catppuccin' },
    sections    = {
        lualine_c = { 'filename', {'diagnostics', sources = {'nvim_diagnostic'}}, 'lsp_progress' },
    },
})
