return {
	"mg979/vim-visual-multi",
	config = function()
		-- Disable backspace mapping, conflicts with auto-pairs
		vim.g.VM_maps = {
			["I BS"] = "",
		}
	end,
}
