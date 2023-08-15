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
					})
				end,
			},

			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				pickers = {
					find_files = {
						previewer = false,
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
					undo = {
						layout_config = {
							preview_height = 0.8,
						},
						mapping = {
							i = {
								-- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
								-- you want to replicate these defaults and use the following actions. This means
								-- installing as a dependency of telescope in it's `requirements` and loading this
								-- extension from there instead of having the separate plugin definition as outlined
								-- above.
								["<cr>"] = require("telescope-undo.actions").restore,
								["<S-cr>"] = require("telescope-undo.actions").yank_additions,
								["<C-cr>"] = require("telescope-undo.actions").yank_deletions,
							},
						},
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("projects")
			telescope.load_extension("undo")
		end,
	},
}
