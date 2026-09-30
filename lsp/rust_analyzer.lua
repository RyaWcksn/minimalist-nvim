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
vim.lsp.commands['rust-analyzer.showReferences'] = function(command, ctx)
	local args = command.arguments
	local uri = args[1] -- string
	local position = args[2] -- Position
	local references = args[3] -- Location[]

	-- Client context: gives you the position encoding for this buffer
	local client = ctx and vim.lsp.get_client_by_id(ctx.client_id)
	local encoding = client and client.offset_encoding or 'utf-16'

	-- items for the location list; no numeric offset on your nightly
	local items = vim.lsp.util.locations_to_items(references, encoding)

	vim.fn.setloclist(0, items, 'r')
	vim.cmd('lopen')
end
local function package_name(cwd)
	local f = io.open(cwd .. '/Cargo.toml')
	if not f then return nil end
	for line in f:lines() do
		-- first [package] name, before [dependencies]
		if line:match('^%[.-') and not line:match('^%[package') then break end
		local n = line:match('^%s*name%s*=%s*"([^"]+)"')
		if n then
			f:close()
			return n
		end
	end
	f:close()
end

vim.lsp.commands['rust-analyzer.debugSingle'] = function(command)
	local r = command.arguments[1]
	local args = r.args -- { cargoArgs, executableArgs, cwd, workspaceRoot, ... }

	local build = vim.system({ 'cargo', 'build', unpack(args.cargoArgs) }, { cwd = args.cwd }):wait()
	if build.code ~= 0 then
		vim.notify(build.stderr, vim.log.levels.ERROR)
		return
	end

	local bin = package_name(args.cwd)
	if not bin then
		vim.notify('debugSingle: could not read package name from Cargo.toml', vim.log.levels.ERROR)
		return
	end

	require('dap').run({
		type = 'codelldb', -- or 'lldb' if you configured that adapter
		request = 'launch',
		program = args.cwd .. '/target/debug/' .. bin,
		args = args.executableArgs or {},
		cwd = args.cwd,
	})
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
	capabilities = {
		experimental = {
			commands = {
				commands = {
					'rust-analyzer.showReferences',
					'rust-analyzer.runSingle',
					'rust-analyzer.debugSingle',
				}
			}
		}
	},
	settings = {
		['rust-analyzer'] = {
			files = { watcher = "server" },
			cargo = { targetDir = true },
			check = { command = "clippy" },
			diagnostics = {
				enable = true,
			},
			checkOnSave = {
				enable = true, -- Keeps cargo check running on save for deep compiler errors
				command = "check",
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
				enable = true,
				run = { enable = true },
				implementations = { enable = true },
				references = {
					adt = { enable = true },
					method = { enable = true },
					trait = { enable = true },
					enumVariant = { enable = true }
				}
			}
		}
	},
}
