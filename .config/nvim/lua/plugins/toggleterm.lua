return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup()
		-- Lazygit with ToggleTerm
		-- Excerpt from Lunarvim
		if not vim.fn.has("lazygit") then
			print("Lazygit is not installed!")
			return
		end

		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
			float_opts = {
				border = "none",
				width = 100000,
				height = 100000,
			},
			on_open = function(_)
				vim.cmd("startinsert!")
			end,
			count = 99,
		})

		-- Bind keymap to toggle function
		vim.keymap.set("n", "<leader>sg", function()
			lazygit:toggle()
		end, {
			desc = "Lazygit",
		})

		-- Lazydocker setup

		local lazydocker = Terminal:new({
			cmd = "lazydocker",
			hidden = true,
			direction = "float",
			float_opts = {
				border = "none",
				width = 100000,
				height = 100000,
			},
			on_open = function(_)
				vim.cmd("startinsert!")
			end,
			count = 98,
		})
		-- Bind keymap to toggle function
		-- <leader> (s)ervices (d)ocker
		vim.keymap.set("n", "<leader>sd", function()
			lazydocker:toggle()
		end, {
			desc = "Lazydocker",
		})
	end,
	-- Disabled in favor of WM, <C-z>, fg, bg, etc.
	enabled = false,
}
