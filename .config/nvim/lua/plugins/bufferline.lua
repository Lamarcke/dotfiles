return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			themeable = true,
			separator_style = "thin",
			diagnostics = "nvim_lsp",
			custom_filter = function(buf_number, buf_numbers)
				local ignored_fts = {
					"oil",
					"TelescopePrompt",
				}
				local buf_ft = vim.bo[buf_number].filetype
				if not vim.tbl_contains(ignored_fts, buf_ft) then
					return true
				end
			end,
		},
	},
}
