-- For nvim-cmp setuf, see plugins/cmp.lua

return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		-- Setup should be called first for mason and after for mason-lspconfig!
		{ "williamboman/mason.nvim" },
		"williamboman/mason-lspconfig.nvim",

		-- Additional lua configuration, makes nvim stuff amazing!
		"folke/neodev.nvim",
		"ray-x/lsp_signature.nvim",
	},

	config = function()
		-- [[ Configure LSP ]]

		-- Very important
		-- Load Mason first
		require("mason").setup()

		-- Setup neovim lua configuration
		require("neodev").setup()

		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		-- Should be loaded after mason
		-- Ensure the servers above are installed
		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup()

		-- Use this to avoid setting up servers you don't want
		local ignored_servers = {
			"tsserver",
		}

		mason_lspconfig.setup_handlers({
			function(server_name)
				if vim.tbl_contains(ignored_servers, server_name) then
					return
				end
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["tsserver"] = function()
				local ts_tools_s, ts_tools = pcall(require, "typescript-tools")
				if ts_tools_s then
					ts_tools.setup({
						settings = {
							expose_as_code_action = {
								"fix_all",
								"add_missing_imports",
								"remove_unused",
							},
						},
					})
				else
					print("typescript-tools not installed, skipping and using default tsserver")
					require("lspconfig")["tsserver"].setup({
						capabilities = capabilities,
					})
				end
			end,
			["jdtls"] = function()
				local jdtls_s, _ = pcall(require, "jdtls")
				if jdtls_s then
					vim.api.nvim_create_autocmd("FileType", {
						pattern = { "java" },
						callback = function()
							require("jdtls").start_or_attach({
								cmd = {
									"jdtls",
									"--jvm-arg=" .. string.format(
										"-javaagent:%s",
										vim.fn.expand("$MASON/share/jdtls/lombok.jar")
									),
								},
								root_dir = vim.fs.dirname(
									vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]
								),
							})
						end,
					})
				else
					require("lspconfig")["jdtls"].setup({
						capabilities = capabilities,
					})
				end
			end,
		})

		-- Diagnostic message setup
		vim.diagnostic.config({
			-- Keep virtual text simple to avoid clutter
			virtual_text = {
				signs = true,
				severity_sort = true,
			},
			-- Use a custom format for the message in line diagnostics (E)
			float = {
				signs = true,
				severity_sort = true,
				format = function(diagnostic)
					return string.format("%s [%s] (%s)", diagnostic.message, diagnostic.code, diagnostic.source)
				end,
				suffix = "",
			},
		})

		-- Signature help
		require("lsp_signature").setup({
			bind = true,
			hint_enable = false,
			handler_opts = {
				border = "rounded",
			},
		})

		-- Autoformat setup --
		-- Switch for controlling whether you want autoformatting.
		--  Use :LspFormatToggle to toggle autoformatting on or off
		local format_is_enabled = true
		vim.api.nvim_create_user_command("LspFormatToggle", function()
			format_is_enabled = not format_is_enabled
		end, {})

		vim.api.nvim_create_user_command("LspFormat", function()
			vim.lsp.buf.format()
			vim.diagnostic.enable(0)
		end, {})

		-- Create an augroup that is used for managing our formatting autocmds.
		--      We need one augroup per client to make sure that multiple clients
		--      can attach to the same buffer without interfering with each other.
		local _augroups = {}
		local get_formatting_augroup = function(client)
			if not _augroups[client.id] then
				local group_name = "lsp-attach-" .. client.name
				local id = vim.api.nvim_create_augroup(group_name, { clear = true })
				_augroups[client.id] = id
			end

			return _augroups[client.id]
		end

		-- Setup for autoformatting
		--
		-- See `:help LspAttach` for more information about this autocmd event.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach-main", { clear = true }),
			-- This is where we attach the autoformatting for reasonable clients
			callback = function(args)
				local client_id = args.data.client_id
				local client = vim.lsp.get_client_by_id(client_id)
				local bufnr = args.buf
				local buf_ft = vim.bo.filetype

				if client == nil or bufnr == nil then
					return
				end

				-- Sets up an formatting AutoCommand
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = get_formatting_augroup(client),
					buffer = bufnr,
					callback = function()
						-- Only attach to clients that support document formatting
						if not client.server_capabilities.documentFormattingProvider then
							return
						end

						-- Tsserver usually works poorly. Sorry you work with bad languages
						-- You can remove this line if you know what you're doing :)
						if client.name == "tsserver" then
							return
						end
						-- From the format_is_enabled variable defined above
						if not format_is_enabled then
							return
						end

						vim.lsp.buf.format({
							async = false,
							filter = function(c)
								return c.id == client.id
							end,
						})

						-- Re-enable diagnostics, following this:
						-- https://www.reddit.com/r/neovim/comments/15dfx4g/help_lsp_diagnostics_are_not_being_displayed/?utm_source=share&utm_medium=web2x&context=3
						vim.diagnostic.enable(bufnr)
					end,
				})
			end,
		})
	end,
}
