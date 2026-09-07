local function reload_workspace(bufnr)
	local clients = vim.lsp.get_clients { bufnr = bufnr, name = 'rust_analyzer' }
	for _, client in ipairs(clients) do
		vim.notify 'Reloading Cargo Workspace'
		---@diagnostic disable-next-line:param-type-mismatch
		client:request('rust-analyzer/reloadWorkspace', nil, function(err)
			if err then
				error(tostring(err))
			end
			vim.notify 'Cargo workspace reloaded'
		end, 0)
	end
end



---@type vim.lsp.Config
return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml" },
	before_init = function(init_params, config)
		if config.settings and config.settings['rust-analyzer'] then
			init_params.initializationOptions = config.settings['rust-analyzer']
		end
		---@param command table{ title: string, command: string, arguments: any[] }
		vim.lsp.commands['rust-analyzer.runSingle'] = function(command)
			local r = command.arguments[1]
			local cmd = { 'cargo', unpack(r.args.cargoArgs) }
			if r.args.executableArgs and #r.args.executableArgs > 0 then
				vim.list_extend(cmd, { '--', unpack(r.args.executableArgs) })
			end

			local proc = vim.system(cmd, { cwd = r.args.cwd })

			local result = proc:wait()

			if result.code == 0 then
				vim.notify(result.stdout, vim.log.levels.INFO)
			else
				vim.notify(result.stderr, vim.log.levels.ERROR)
			end
		end
	end,
	on_attach = function(_, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, 'LspCargoReload', function()
			reload_workspace(bufnr)
		end, { desc = 'Reload current cargo workspace' })
		vim.api.nvim_buf_create_user_command(bufnr, 'LspCargoRun', function()
			vim.cmd('term cargo run')
		end, { desc = 'Run program' })
	end,
	settings = {
		['rust-analyzer'] = {
			files = { watcher = "server" },
			cargo = { targetDir = true },
			check = { command = "clippy" },
			diagnostics = {
				enable = false,
			},
			rustc = { source = "discover" },
			inlayHints = {
				bindingModeHints = {
					enable = true
				},
				chainingHints = {
					enable = true
				},
				closingBraceHints = {
					enable = true
				},
				closureCaptureHints = {
					enabled = true
				},
				closureReturnTypeHints = {
					enable = "always"
				},
				maxLength = 100,
			},
			lens = {
				debug = { enable = true },
				enable = true,
				implementations = { enable = true },
				references = {
					adt = { enable = true },
					enumVariant = { enable = true },
					method = { enable = true },
					trait = { enable = true },
				},
				run = { enable = true },
				updateTest = { enable = true },
			}
		}
	},
}
