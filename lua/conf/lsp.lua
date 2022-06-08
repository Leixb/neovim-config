local lspconfig = require'lspconfig'

local function lsp_attach(client, bufnr)
    require'lsp_signature'.on_attach()

    require("notify")(string.format('[lsp] %s', client.name),
                                    'info', {title = '[lsp] Active'})

    if client.server_capabilities.codeLensProvider then
        vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh,
        })
    end

    if client.server_capabilities.documentHightlightProvider then

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
    'rnix',
    'r_language_server',
    -- 'rls',
    'svelte',
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

lspconfig.pylsp.setup {
    on_attach = lsp_attach,
    capabilities = capabilities,
    settings = {
        formatCommand = { "black" },
        pylsp = {
            plugins = {
                -- pylint = {args = {'--ignore=E501', '-'}, enabled=true, debounce=200},
                pycodestyle = {
                    enabled = true,
                    ignore = {'E501'},
                    maxLineLength = 120,
                },
                pyls_mypy = {
                    enabled = true,
                },
            }
        }
    }
}

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


vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})

local notify = require 'notify'
vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local lvl = ({
    'ERROR',
    'WARN',
    'INFO',
    'DEBUG',
  })[result.type]
  notify({ result.message }, lvl, {
    title = 'LSP | ' .. client.name,
    timeout = 10000,
    keep = function()
      return lvl == 'ERROR' or lvl == 'WARN'
    end,
  })
end

local signs = {
    Error = ' ',
    Warn = ' ',
    Hint = ' ',
    Info = ' ',
}

for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

-- set up vim.diagnostics
-- vim.diagnostic.config opts
vim.diagnostic.config({
    underline = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        focusable = false,
        header = { ' ' .. ' Diagnostics:', 'Normal' },
        source = 'always',
    },
    virtual_text = {
        spacing = 4,
        source = 'always',
        severity = {
            min = vim.diagnostic.severity.HINT,
        },
    },
})
