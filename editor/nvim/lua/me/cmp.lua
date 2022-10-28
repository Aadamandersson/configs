local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
	return
end

local types = require("cmp.types")
cmp.setup({
	preselect = types.cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp", keyword_length = 2 },
		{ name = "vsnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 2 },
		{ name = "path" },
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
		}),
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			item.menu = ({
				nvim_lsp = "",
				vsnip = "",
				path = "",
			})[entry.source.name]
			return item
		end,
	},
})
