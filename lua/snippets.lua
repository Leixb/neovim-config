local ls = require'luasnip'
-- some shorthands...
-- local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local l = require'luasnip.extras'.lambda
-- local r = require'luasnip.extras'.rep
-- local p = require'luasnip.extras'.partial
-- local m = require'luasnip.extras'.match
-- local n = require'luasnip.extras'.nonempty
-- local dl = require'luasnip.extras'.dynamic_lambda
-- local fmt = require'luasnip.extras.fmt'.fmt
-- local fmta = require'luasnip.extras.fmt'.fmta
local types = require'luasnip.util.types'
-- local conds = require'luasnip.extras.conditions'

-- Every unspecified option will be set to the default.
ls.config.set_config({
	history = true,
	-- Update more often, :h events for more info.
	updateevents = 'TextChanged,TextChangedI',
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { 'choiceNode', 'Comment' } },
			},
		},
	},
	-- treesitter-hl has 100, use something higher (default is 200).
	ext_base_prio = 300,
	-- ext_prio_increase = 1,
	-- enable_autosnippets = true,
})

-- in a cpp file: search c-snippets, then all-snippets only (no cpp-snippets!!).
ls.filetype_set('cpp', { 'c' })

--[[
-- Beside defining your own snippets you can also load snippets from 'vscode-like' packages
-- that expose snippets in json files, for example <https://github.com/rafamadriz/friendly-snippets>.
-- Mind that this will extend  `ls.snippets` so you need to do it after your own snippets or you
-- will need to extend the table yourself instead of setting a new one.
]]

-- You can also use lazy loading so you only get in memory snippets of languages you use
require'luasnip/loaders/from_vscode'.lazy_load() -- You can pass { paths = './my-snippets/'} as well
