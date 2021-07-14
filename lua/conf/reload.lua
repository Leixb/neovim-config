local reload = require('nvim-reload')

reload.modules_reload_external = { 'packer' }
reload.post_reload_hook = function()
    vim.api.nvim_command('colorscheme ' .. 'nightfly')
end
