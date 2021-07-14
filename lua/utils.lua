
local M = {}

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand '%:t') == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

function M.clear_registers()
    -- vim.api.nvim_command('rshada')
    local alphabet = 'abcdefghijklmnopqrstuvwxyz'
    for i = 1, #alphabet do
        local c = alphabet:sub(i,i)
        vim.fn.setreg(c, '')
    end
    -- vim.api.nvim_command('wshada!')
end

return M
