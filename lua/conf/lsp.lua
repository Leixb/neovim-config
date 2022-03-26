local lspconfig = require'lspconfig'

local function lsp_attach(client, bufnr)
    require'lsp_signature'.on_attach()

    if client.resolved_capabilities.code_lens then
        vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh,
        })
    end

    if client.resolved_capabilities.document_highlight then

        local group_id = vim.api.nvim_create_augroup('lsp-highlight', { clear = true })

        vim.api.nvim_create_autocmd(
            {'CursorHold', 'CursorHoldI'},
            {
                buffer = bufnr,
                callback = vim.lsp.buf.document_highlight,
                group = group_id
            })

        vim.api.nvim_create_autocmd(
            'CursorMoved',
            {
                buffer = bufnr,
                callback = vim.lsp.buf.clear_references,
                group = group_id
            })
    end

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)

local lsp_list = {
    -- 'bashls', -- high CPU usage...
    'clangd',
    'cssls',
    'dartls',
    'dockerls',
    'gopls',
    -- 'hls',
    'html',
    'jdtls',
    'jsonls',
    'julials',
    -- 'kotlin_language_server',
    'pylsp',
    'rnix',
    'r_language_server',
    -- 'rls',
    'texlab',
    'tsserver',
    'vimls',
    'yamlls',
}

for _,val in pairs(lsp_list) do
    lspconfig[val].setup{
        on_attach = lsp_attach,
        capabilities = capabilities,
    }
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
    capabilities = capabilities,
    on_attach = lsp_attach,
}

-- Diagnostics

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Enable underline, use default values
        underline = true,
        -- Enable virtual text, override spacing to 4
        virtual_text = {
            spacing = 4,
            prefix = '~',
        },
        -- Use a function to dynamically turn signs off
        -- and on, using buffer local variables
        signs = function(bufnr, _)
            local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
            -- No buffer local variable set, so just enable by default
            if not ok then
                return true
            end

            return result
        end,
        -- Disable a feature
        update_in_insert = false,
    }
)
