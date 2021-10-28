local lspconfig = require('lspconfig')

local function lsp_attach(client)
    require"lsp_signature".on_attach()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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

local system_name
if vim.fn.has("mac") == 1 then
    system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
    system_name = "Windows"
else
    print("Unsupported system for sumneko")
end

local sumneko_root_path = vim.fn.stdpath('cache')..'/nvim_lsp/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

lspconfig.sumneko_lua.setup{
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    on_attach = lsp_attach,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT', path = vim.split(package.path, ';'), },
            completion = { keywordSnippet = 'Disable', },
            diagnostics = { enable = true, globals = {
                'vim', 'describe', 'it', 'before_each', 'after_each' },
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                }
            }
        }
    },
    capabilities = capabilities,
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
