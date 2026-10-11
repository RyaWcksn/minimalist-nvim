local palette = {
	base00 = '#141419', -- Deep royal charcoal (Dress fabric base)
	base01 = '#1c1c24', -- Dark dress panel shadows
	base02 = '#282934', -- Medium border shadow
	base03 = '#65585a', -- Muted dusty rose-gray for comments
	base04 = '#d0b0b5', -- Soft metallic pink highlights
	base05 = '#f7ebed', -- Ice white with pink tint (General text)
	base06 = '#ffffff', -- Pure white accent
	base07 = '#ffdca3', -- Warm pale skin tone cream

	base08 = '#ff7da0', -- Luka Rose Pink (Keywords / Structural layout)
	base09 = '#ffb3c6', -- Soft Pastel Pink (Standard variables & parameters)
	base0A = '#e0a94a', -- Antique Brass Gold (Numbers / Constants)
	base0B = '#00e5ff', -- Luka Chest Emblem Cyan (Strings / Hardcoded literals)
	base0C = '#ffd700', -- Shining Bright Gold (Struct members / Fields / Operators)
	base0D = '#cca043', -- Deep Metallic Gold (Functions & definitions)
	base0E = '#ffccd5', -- Light Pink Blush (Types & Structs declarations)
	base0F = '#ff2b55' -- High-saturation pink-red peak indicator (Errors)
}

vim.cmd.highlight("clear")
vim.o.background = "dark"
vim.g.colors_name = "luka"

local set_hl = vim.api.nvim_set_hl

-- ============================================================================
-- Editor & UI Group
-- ============================================================================
set_hl(0, "Normal", { fg = palette.base05, bg = palette.base00 })
set_hl(0, "LineNr", { fg = palette.base03 })
set_hl(0, "CursorLineNr", { fg = palette.base08, bold = true }) -- Active line number glows pink
set_hl(0, "Visual", { bg = palette.base02 })
set_hl(0, "StatusLine", { fg = palette.base08, bg = palette.base01, bold = true })

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
set_hl(0, "Identifier", { fg = palette.base09 })
set_hl(0, "Operator", { fg = palette.base0C })

-- ============================================================================
-- Tree-sitter: Global Variables & Properties
-- ============================================================================
set_hl(0, "@variable", { fg = palette.base09 })           -- Variables show in Luka's pastel hair pink
set_hl(0, "@variable.builtin", { fg = palette.base0C, italic = true })
set_hl(0, "@variable.parameter", { fg = palette.base09 }) -- Parameters share pastel pink
set_hl(0, "@variable.member", { fg = palette.base0C })    -- Object fields match glowing gold trim
set_hl(0, "@property", { fg = palette.base0C })           -- Struct keys match glowing gold trim
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
set_hl(0, "@string", { fg = palette.base0B }) -- Strings break out in gorgeous emblem cyan
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
