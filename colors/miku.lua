local palette = {
	base00 = '#0d1117',
	base01 = '#161b22',
	base02 = '#21262d',
	base03 = '#484f58',
	base04 = '#b1bac4',
	base05 = '#f0f6fc',
	base06 = '#ffffff',
	base07 = '#f0f6fc',

	base08 = '#ff4d94',
	base09 = '#39c5bb',
	base0A = '#82e8e1',
	base0B = '#00ffcc',
	base0C = '#59c2ff',
	base0D = '#39c5bb',
	base0E = '#b388ff',
	base0F = '#ff0033'
}

vim.cmd.highlight("clear")
vim.o.background = "dark"
vim.g.colors_name = "miku"

local set_hl = vim.api.nvim_set_hl

set_hl(0, "Normal", { fg = palette.base05, bg = palette.base00 })
set_hl(0, "LineNr", { fg = palette.base03 })
set_hl(0, "CursorLineNr", { fg = palette.base0B, bold = true })
set_hl(0, "Visual", { bg = palette.base02 })
set_hl(0, "StatusLine", { fg = palette.base0B, bg = palette.base01, bold = true })

set_hl(0, "Comment", { fg = palette.base03, italic = true })
set_hl(0, "String", { fg = palette.base0B })
set_hl(0, "Function", { fg = palette.base0D, bold = true })
set_hl(0, "Keyword", { fg = palette.base08, italic = true })
set_hl(0, "Statement", { fg = palette.base08 })
set_hl(0, "Type", { fg = palette.base0A, bold = true })
set_hl(0, "Number", { fg = palette.base09 })
set_hl(0, "Constant", { fg = palette.base09, bold = true })
set_hl(0, "Identifier", { fg = palette.base05 })
set_hl(0, "Operator", { fg = palette.base0C })

set_hl(0, "@variable", { fg = palette.base09 })
set_hl(0, "@variable.builtin", { fg = palette.base09, italic = true })
set_hl(0, "@variable.parameter", { fg = palette.base09 })
set_hl(0, "@variable.member", { fg = palette.base0C })
set_hl(0, "@property", { fg = palette.base0C })

set_hl(0, "@function", { fg = palette.base0D, bold = true })
set_hl(0, "@function.call", { fg = palette.base0D })
set_hl(0, "@function.builtin", { fg = palette.base0B })

set_hl(0, "@keyword", { fg = palette.base08, italic = true })
set_hl(0, "@keyword.function", { fg = palette.base08, bold = true })
set_hl(0, "@keyword.return", { fg = palette.base08, bold = true })
set_hl(0, "@keyword.conditional", { fg = palette.base08 })
set_hl(0, "@keyword.repeat", { fg = palette.base08 })

set_hl(0, "@type", { fg = palette.base0A, bold = true })
set_hl(0, "@type.builtin", { fg = palette.base09 })

set_hl(0, "@punctuation.bracket", { fg = palette.base0C })
set_hl(0, "@punctuation.delimiter", { fg = palette.base0C })

set_hl(0, "@constant", { fg = palette.base09 })
set_hl(0, "@boolean", { fg = palette.base0B, bold = true })

set_hl(0, "@string", { fg = palette.base08, bold = true })
