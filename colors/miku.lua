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

-- ============================================================================
-- Editor & UI Group
-- ============================================================================
set_hl(0, "Normal", { fg = palette.base05, bg = palette.base00 })
set_hl(0, "LineNr", { fg = palette.base03 })
set_hl(0, "CursorLineNr", { fg = palette.base0B, bold = true })
set_hl(0, "Visual", { bg = palette.base02 })
set_hl(0, "StatusLine", { fg = palette.base0B, bg = palette.base01, bold = true })

-- ============================================================================
-- Classic Vim Highlights
-- ============================================================================
set_hl(0, "Comment", { fg = palette.base03, italic = true })
set_hl(0, "String", { fg = palette.base0B })
set_hl(0, "Function", { fg = palette.base0D, bold = true })
set_hl(0, "Keyword", { fg = palette.base08, italic = true })
set_hl(0, "Statement", { fg = palette.base08 })
set_hl(0, "Type", { fg = palette.base0E, bold = true })
set_hl(0, "Number", { fg = palette.base0A })
set_hl(0, "Constant", { fg = palette.base0A, bold = true })
set_hl(0, "Identifier", { fg = palette.base09 }) -- Shifted from base05 white to mint
set_hl(0, "Operator", { fg = palette.base0C })

-- ============================================================================
-- Tree-sitter: Global Variables & Properties
-- ============================================================================
set_hl(0, "@variable", { fg = palette.base09 })           -- Standard variables stand out in mint
set_hl(0, "@variable.builtin", { fg = palette.base0C, italic = true })
set_hl(0, "@variable.parameter", { fg = palette.base09 }) -- Function parameters share the mint look
set_hl(0, "@variable.member", { fg = palette.base0C })    -- Object/Struct fields use electric blue
set_hl(0, "@property", { fg = palette.base0C })           -- Struct keys use electric blue
set_hl(0, "@field", { fg = palette.base0C })

-- ============================================================================
-- Tree-sitter: Functions & Keywords
-- ============================================================================
set_hl(0, "@function", { fg = palette.base0D, bold = true })
set_hl(0, "@function.call", { fg = palette.base0D })
set_hl(0, "@function.builtin", { fg = palette.base0D, bold = true })

set_hl(0, "@keyword", { fg = palette.base08, italic = true })
set_hl(0, "@keyword.function", { fg = palette.base08, bold = true })
set_hl(0, "@keyword.return", { fg = palette.base08, bold = true })
set_hl(0, "@keyword.conditional", { fg = palette.base08 })
set_hl(0, "@keyword.repeat", { fg = palette.base08 })
set_hl(0, "@keyword.import", { fg = palette.base08 })

-- ============================================================================
-- Tree-sitter: Types, Classes & Interfaces
-- ============================================================================
set_hl(0, "@type", { fg = palette.base0E, bold = true })
set_hl(0, "@type.builtin", { fg = palette.base0E })
set_hl(0, "@type.qualifier", { fg = palette.base0C })
set_hl(0, "@lsp.type.interface", { fg = palette.base0C, bold = true })
set_hl(0, "@lsp.type.struct", { fg = palette.base0E, bold = true })
set_hl(0, "@lsp.type.class", { fg = palette.base0E, bold = true })
set_hl(0, "@constructor", { fg = palette.base0E, bold = true })

-- ============================================================================
-- Tree-sitter: Structure & Punctuation
-- ============================================================================
set_hl(0, "@punctuation.bracket", { fg = palette.base0C })
set_hl(0, "@punctuation.delimiter", { fg = palette.base0C })

-- ============================================================================
-- Tree-sitter: Data Types & Literals
-- ============================================================================
set_hl(0, "@string", { fg = palette.base0B })
set_hl(0, "@constant", { fg = palette.base0A, bold = true })
set_hl(0, "@constant.builtin", { fg = palette.base0A, bold = true })
set_hl(0, "@boolean", { fg = palette.base0A, bold = true })
set_hl(0, "@number", { fg = palette.base0A })

-- ============================================================================
-- Tree-sitter: Explicit Rust Overrides
-- ============================================================================
set_hl(0, "@type.rust", { fg = palette.base0E, bold = true })
set_hl(0, "@type.builtin.rust", { fg = palette.base0E })
set_hl(0, "@constructor.rust", { fg = palette.base0E, bold = true })

set_hl(0, "@function.macro.rust", { fg = palette.base0D, bold = true })
set_hl(0, "@macro.rust", { fg = palette.base0D, bold = true })
set_hl(0, "@method.rust", { fg = palette.base0D })
set_hl(0, "@method.call.rust", { fg = palette.base0D })

set_hl(0, "@variable.rust", { fg = palette.base09 })
set_hl(0, "@variable.parameter.rust", { fg = palette.base09 })
set_hl(0, "@field.rust", { fg = palette.base0C })
set_hl(0, "@selfParameter.rust", { fg = palette.base0C, italic = true })
set_hl(0, "@variable.builtin.rust", { fg = palette.base0C, italic = true })

set_hl(0, "@attribute.rust", { fg = palette.base0A })
set_hl(0, "@namespace.rust", { fg = palette.base0C })

-- ============================================================================
-- Tree-sitter: Explicit Go Overrides
-- ============================================================================
set_hl(0, "@module.go", { fg = palette.base0C })
set_hl(0, "@namespace.go", { fg = palette.base0C })
set_hl(0, "@type.go", { fg = palette.base0E, bold = true })
set_hl(0, "@type.builtin.go", { fg = palette.base0E })

set_hl(0, "@function.go", { fg = palette.base0D, bold = true })
set_hl(0, "@function.call.go", { fg = palette.base0D })
set_hl(0, "@method.go", { fg = palette.base0D })
set_hl(0, "@method.call.go", { fg = palette.base0D })

set_hl(0, "@variable.go", { fg = palette.base09 })
set_hl(0, "@variable.member.go", { fg = palette.base0C })
set_hl(0, "@property.go", { fg = palette.base0C })

set_hl(0, "@constant.builtin.go", { fg = palette.base0A, bold = true })
set_hl(0, "@boolean.go", { fg = palette.base0A, bold = true })
