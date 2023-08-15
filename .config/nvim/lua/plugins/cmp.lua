---@diagnostic disable: missing-fields

return {
	-- Autocompletion
	"hrsh7th/nvim-cmp",
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		-- Snippets are actually handled by cmp (see the Tab and S-Tab mappings)
		{ "L3MON4D3/LuaSnip" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "rafamadriz/friendly-snippets" },

		-- Adds LSP completion capabilities
		{ "hrsh7th/cmp-nvim-lsp" },

		-- Extra cmp sources
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },

		-- Adds a number of user-friendly snippets
		-- Auto pairs
		{
			"windwp/nvim-autopairs",
			opts = {
				check_ts = true,
				enable_check_bracket_line = false,
			}, -- this is equalent to setup({}) function
		},
		-- Prettier cmp formatting
		{
			"onsails/lspkind.nvim",
		},
		-- Copilot (just to make sure it's installed before config is called)
		-- I don't personally like copilot as a cmp source, so it's not here.
		-- Do not use config or opts here.
		{ "zbirenbaum/copilot.lua" },
	},
	config = function()
		-- [[ Configure nvim-cmp ]]
		-- See `:help cmp`
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		local select_opts = { behavior = cmp.SelectBehavior.Select }

		require("luasnip.loaders.from_vscode").lazy_load()
		luasnip.config.setup({})

		-- Appends function call '()' after completion
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		cmp.setup({
			-- Preselects the first item
			preselect = "item",
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text", -- show only symbol annotations
					maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
				}),
			},
			-- window = {
			-- 	documentation = cmp.config.window.bordered(),
			-- 	completion = cmp.config.window.bordered({
			-- 		winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
			-- 	}),
			-- },
			experimental = {
				-- true makes me confused on what is cmp and what is copilot
				ghost_text = false,
			},

			-- These mappings are activie even if cmp menu is not open!
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(select_opts),
				["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-e>"] = cmp.mapping.abort(),

				["<C-Space>"] = cmp.mapping.complete({}),
				["<CR>"] = cmp.mapping.confirm({
					select = true,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					-- Checks if copilot is visible, and accept completion if it is
					local copilot_available, copilot_suggestion = pcall(require, "copilot.suggestion")

					if copilot_available and copilot_suggestion.is_visible() then
						copilot_suggestion.accept()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip", keyword_length = 2 },
				{ name = "buffer", keyword_length = 3 },
				{ name = "path" },
			},
		})
	end,
}
