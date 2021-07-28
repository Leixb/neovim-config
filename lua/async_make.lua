local M = {}

function M.make()
    local lines = {""}
    local winnr = vim.fn.win_getid()
    local bufnr = vim.api.nvim_win_get_buf(winnr)

    local makeprg = vim.o.makeprg
    if not makeprg then return end

    local cmd = vim.fn.expandcmd(makeprg)

    local function on_event(job_id, data, event)
        if event == "stdout" or event == "stderr" then
            if data then
                vim.list_extend(lines, data)
            end
        end

        if event == "exit" then
            vim.fn.setqflist({}, " ", {
                title = cmd,
                lines = lines,
            })
            local height = #vim.fn.getqflist()
            if height == 0 then return end
            if height > 8 then height = 8 end
            vim.api.nvim_command("doautocmd QuickFixCmdPost")
            vim.api.nvim_command("copen " .. tostring(height))
            vim.api.nvim_set_current_win(winnr)
        end
    end

    -- local job_id =
    vim.fn.jobstart(
    cmd,
    {
        on_stderr = on_event,
        on_stdout = on_event,
        on_exit = on_event,
        stdout_buffered = true,
        stderr_buffered = true,
    }
    )
end

return M
