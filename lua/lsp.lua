vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "*",
	callback = function()
		vim.lsp.enable({
			"lua_ls",
			"gopls",
			"golangci_lint_ls",
			"ts_ls",
			"tailwindcss",
			"rust_analyzer",
			"dartls",
			"clangd",
			"tinymist",
			"sqls"
		})
	end,
	once = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		vim.lsp.log.set_level(vim.log.levels.ERROR)
		if client:supports_method('textDocument/completion') then
			-- ponytail: trigger via TextChangedI with Invoked kind so rust-analyzer filters by prefix instead of dumping everything
			vim.lsp.completion.enable(true, client.id, ev.buf,
				{
					autotrigger = false,
					convert = function(item)
						local abbr = item.label:match("[%w_.]+.*") or item.label
						local doc = item.documentation
						if not doc or type(doc) ~= "string" or not vim.startswith(doc, "#") then
							return {}
						end
						local color = doc:sub(1, 7) -- Make sure to get the full hex code
						local hl_color = color:sub(2) -- Remove the '#' for hl group name
						local hl_group = "lsp_color_" .. hl_color
						vim.api.nvim_set_hl(0, hl_group, { fg = color, bg = color })
						return {
							abbr = #abbr > 25 and abbr:sub(1, 24) .. "…" or abbr,
							menu = "",
							kind_hlgroup = "lsp_color_" .. hl_color,
							kind = "XX",
						}
					end,
				})
			vim.api.nvim_create_autocmd("TextChangedI", {
				buffer = ev.buf,
				callback = function()
					local col = vim.api.nvim_win_get_cursor(0)[2]
					if col == 0 then return end
					local line = vim.api.nvim_get_current_line()
					if line:sub(col, col):match("[%w_]") then
						vim.lsp.completion.get()
					end
				end,
			})
		end


		vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = "Format" })
		vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action, { desc = "Code Action" })
		vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, { desc = "Signature Help" })
		vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, { desc = "Goto Definition" })
		vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, { desc = "Code Implementation" })
		vim.keymap.set('n', '<leader>lw', vim.lsp.buf.references, { desc = "Code References" })
		vim.keymap.set('n', '<leader>ll', vim.lsp.codelens.run, { desc = "Codelens Run" })
		vim.keymap.set('n', '<leader>lL', vim.lsp.codelens.enable, { desc = "Codelens Refresh" })
		vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = "Rename" })
		vim.keymap.set('n', '<leader>lt', vim.diagnostic.setqflist, { desc = "Diagnostics" })
		vim.keymap.set('n', '<leader>lo', vim.lsp.buf.document_symbol, { desc = "Document Symbol" })
		vim.keymap.set('n', '<C-k>', vim.diagnostic.open_float, { desc = "Open diagnostic float" })
		vim.keymap.set('i', '<C-j>', vim.lsp.buf.signature_help, { desc = "Open diagnostic float" })
		vim.lsp.document_color.enable()



		if client:supports_method("textDocument/signatureHelp") then
			vim.api.nvim_create_autocmd("CursorHoldI", {
				buffer = ev.buf,
				callback = function()
					if vim.fn.pumvisible() == 1 then return end
					vim.lsp.buf.signature_help({ focusable = false })
				end,
			})
		end

		if client:supports_method('textDocument/inlayHint') then
			vim.api.nvim_create_autocmd("InsertEnter", {
				buffer = ev.buf,
				callback = function() vim.lsp.inlay_hint.enable(true) end
			})
			vim.api.nvim_create_autocmd("InsertLeave", {
				buffer = ev.buf,
				callback = function() vim.lsp.inlay_hint.enable(false) end
			})
		end

		if client:supports_method('textDocument/codeLens') then
			vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold" }, {
				buffer = ev.buf,
				callback = function() vim.lsp.codelens.enable(true, { bufnr = ev.buf }) end
			})
		end

		if client:supports_method('textDocument/documentHighlight') then
			vim.api.nvim_set_hl(ev.buf, 'LspReferenceRead', { link = 'Search' })
			vim.api.nvim_set_hl(ev.buf, 'LspReferenceText', { link = 'Search' })
			vim.api.nvim_set_hl(ev.buf, 'LspReferenceWrite', { link = 'Search' })

			vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
			vim.api.nvim_clear_autocmds({ buffer = ev.buf, group = 'lsp_document_highlight' })

			vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
				group = 'lsp_document_highlight',
				buffer = ev.buf,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
				group = 'lsp_document_highlight',
				buffer = ev.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end

		if not client:supports_method('textDocument/willSaveWaitUntil')
		    and client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('neko.lsp', { clear = false }),
				buffer = ev.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end


		vim.diagnostic.config({ virtual_text = true })

		local signs = { Error = "> ", Warn = "W ", Hint = "H ", Info = "I " }
		for type, icon in ipairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local config = {
			virtual_text = {
				source = "always",
				prefix = '>',
			},
			signs = true,
			update_in_insert = true,
			underline = true,
			severity_sort = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
			},
		}
		vim.diagnostic.config(config)

		vim.api.nvim_create_autocmd("CursorHold", {
			buffer = ev.buf,
			callback = function()
				vim.diagnostic.open_float(nil, {
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
					border = 'rounded',
					source = 'always',
					prefix = ' ',
					scope = 'line',
				})
			end
		})
	end
})
