local luasnip = require'luasnip'
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ['<C-f>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),

    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'calc' },
        { name = 'path' },
        { name = 'nvim_lua' },
        { name = 'latex_symbols' },
        { name = 'neorg' },
    },
    formatting = {
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = require'lspkind'.presets.default[vim_item.kind] .. ' ' .. vim_item.kind

            -- set a name for each source
            vim_item.menu = ({
                buffer = '[Buffer]',
                nvim_lsp = '[LSP]',
                luasnip = '[LuaSnip]',
                nvim_lua = '[Lua]',
                latex_symbols = '[Latex]',
                path = '[Path]',
                calc = '[Calc]',
                neorg = '[Neorg]',
            })[entry.source.name]
            return vim_item
        end,
    },
})

local cmp_autopairs = require'nvim-autopairs.completion.cmp'
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done())
