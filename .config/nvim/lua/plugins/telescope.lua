return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"ahmedkhalf/project.nvim",
				config = function()
					require("project_nvim").setup({
						-- your configuration comes here
						-- or leave it empty to use the default settings
						-- refer to the configuration section below
						silent_chdir = false,
					})
				end,
			},

			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				defaults = {
					prompt_prefix = " ",
					select_caret = "",
					entry_prefix = "  ",
				},
				pickers = {
					find_files = {
						previewer = false,
						layout_config = {
							width = 0.6,
						},
					},
					live_grep = {
						only_sort_text = true,
					},
					grep_string = {
						only_sort_text = true,
					},
					colorscheme = {
						previewer = true,
						enable_preview = true,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("projects")
		end,
	},
}
