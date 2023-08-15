local spinners = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

local function copilot_indicator()
	local client = vim.lsp.get_active_clients({ name = "copilot" })[1]
	if client == nil then
		return ""
	end

	if vim.tbl_isempty(client.requests) then
		return ""
	end

	local ms = vim.loop.hrtime() / 1000000
	local frame = math.floor(ms / 120) % #spinners

	return spinners[frame + 1]
end

-- The LSP+copilot_active stuff is excerpt from Lunarvim
local function get_attached_clients()
	local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
	if #buf_clients == 0 then
		return "LSP Inactive"
	end

	local buf_ft = vim.bo.filetype
	local buf_client_names = {}

	-- add client
	for _, client in pairs(buf_clients) do
		-- Ignore copilot and the actuall null-ls LSP names
		if client.name ~= "copilot" and client.name ~= "null-ls" then
			table.insert(buf_client_names, client.name)
		end
	end

	-- Generally, you should use either null-ls or nvim-lint + formatter.nvim, not both.
	-- Add sources (from null-ls)
	-- null-ls registers each source as a separate attached client, so we need to filter for unique names down below.
	local null_ls_s, null_ls = pcall(require, "null-ls")
	if null_ls_s then
		local sources = null_ls.get_sources()
		for _, source in ipairs(sources) do
			if source._validated then
				for ft_name, ft_active in pairs(source.filetypes) do
					if ft_name == buf_ft and ft_active then
						table.insert(buf_client_names, source.name)
					end
				end
			end
		end
	end

	-- Add linters (from nvim-lint)
	-- local lint_s, lint = pcall(require, "lint")
	-- if lint_s then
	-- 	for ft_k, ft_v in pairs(lint.linters_by_ft) do
	-- 		if type(ft_v) == "table" then
	-- 			for _, linter in ipairs(ft_v) do
	-- 				if buf_ft == ft_k then
	-- 					table.insert(buf_client_names, linter)
	-- 				end
	-- 			end
	-- 		elseif type(ft_v) == "string" then
	-- 			if buf_ft == ft_k then
	-- 				table.insert(buf_client_names, ft_v)
	-- 			end
	-- 		end
	-- 	end
	-- end
	--
	-- Add formatters (from formatter.nvim)
	-- local formatter_s, _ = pcall(require, "formatter")
	-- if formatter_s then
	-- 	local formatter_util = require("formatter.util")
	-- 	for _, formatter in ipairs(formatter_util.get_available_formatters_for_ft(buf_ft)) do
	-- 		if formatter then
	-- 			table.insert(buf_client_names, formatter)
	-- 		end
	-- 	end
	-- end

	-- This needs to be a string only table so we can use concat below
	local unique_client_names = {}
	for _, name in pairs(buf_client_names) do
		if not vim.tbl_contains(unique_client_names, name) then
			table.insert(unique_client_names, name)
		end
	end

	local client_names_str = table.concat(unique_client_names, ", ")
	local language_servers = string.format("[%s]", client_names_str)

	return language_servers
end

-- Excerpt from Lunarvim
local function get_python_venv()
	local venv_cleanup = function(venv)
		if string.find(venv, "/") then
			local final_venv = venv
			for w in venv:gmatch("([^/]+)") do
				final_venv = w
			end
			venv = final_venv
		end
		return venv
	end

	if vim.bo.filetype == "python" then
		-- This works for venv, poetry, conda, etc.
		local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV")
		if venv then
			local icons = require("nvim-web-devicons")
			local py_icon, _ = icons.get_icon(".py")
			return string.format(" " .. py_icon .. " (%s)", venv_cleanup(venv))
		end
		-- Avoid running expensive computation "like calling python3 -V" here.
		return "(system)"
	end
end

return {
	"nvim-lualine/lualine.nvim",
	event = { "VimEnter", "BufReadPost", "BufNewFile" },
	config = function()
		local copilot_component = {
			copilot_indicator,
			color = {
				fg = "#6CC644",
				bg = "#1E1E1E",
			},
		}
		local attached_clients_component = {
			get_attached_clients,
			color = {
				gui = "bold",
			},
		}

		local spaces_component = {
			function()
				local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
				return "󰌒 " .. shiftwidth
			end,
			padding = 1,
		}

		local python_venv_component = {
			get_python_venv,
			color = {
				fg = "#6CC644",
				bg = "#1E1E1E",
			},
			cond = function()
				return vim.bo.filetype == "python"
			end,
		}
		require("lualine").setup({
			options = {
				theme = "auto",
				globalstatus = true,
				component_separators = { left = "|", right = "|" },
				refresh = {
					statusline = 250,
				},
			},

			sections = {
				lualine_b = { "branch" },
				lualine_c = { "diff", python_venv_component },
				lualine_x = {
					"diagnostics",
					attached_clients_component,
					copilot_component,
					spaces_component,
					"filetype",
				},
			},
		})
	end,
}
