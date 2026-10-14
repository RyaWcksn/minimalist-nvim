-- Array containing our three distinct theme palettes

---@alias VocaloidTheme
---| "miku"
---| "rin_len"
---| "luka"
---| "kaito"
---| "gumi"
---| "ia"
---| "teto"
local vocaloid_themes = { "miku", "rin_len", "luka", "kaito", "gumi", "ia", "teto" }

local current_theme_index = 1

-- 1. Definition for the Rin/Len and Luka palettes to feed the reloader loop
local theme_palettes = {
	miku = {
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
	},
	rin_len = {
		base00 = '#1a1a1c',
		base01 = '#242528',
		base02 = '#333438',
		base03 = '#5c5e65',
		base04 = '#b7adae',
		base05 = '#edebee',
		base06 = '#ffffff',
		base07 = '#fff79b',
		base08 = '#e68a00',
		base09 = '#fcda90',
		base0A = '#ffd633',
		base0B = '#ffea00',
		base0C = '#e1e4e6',
		base0D = '#ffaa00',
		base0E = '#ffd29a',
		base0F = '#ff3333'
	},
	luka = {
		base00 = '#141419',
		base01 = '#1c1c24',
		base02 = '#282934',
		base03 = '#65585a',
		base04 = '#d0b0b5',
		base05 = '#f7ebed',
		base06 = '#ffffff',
		base07 = '#ffdca3',
		base08 = '#ff7da0',
		base09 = '#ffb3c6',
		base0A = '#e0a94a',
		base0B = '#00e5ff',
		base0C = '#ffd700',
		base0D = '#cca043',
		base0E = '#ffccd5',
		base0F = '#ff2b55'
	},
	kaito = {
		base00 = '#0a0d14', -- Deep midnight navy canvas
		base01 = '#101424', -- Cobalt longcoat shadow
		base02 = '#1a2238', -- Medium coat seam highlight
		base03 = '#504440', -- Warm ice-cream dessert brown for comments
		base04 = '#8fa3cc', -- Muted steel blue
		base05 = '#eef2fa', -- Snow white variable text base
		base06 = '#ffffff', -- Pure boot white accent
		base07 = '#cce0ff', -- Ice blue tone

		base08 = '#2b5cff', -- Kaito Royal Blue (Keywords / Structure layout)
		base09 = '#759aff', -- Soft Light Cobalt (Standard variables & parameters)
		base0A = '#e6a100', -- Gold Badge Trim (Numbers / Constants)
		base0B = '#00d9ff', -- Shimmering Scarf Cyan (Strings / Paths)
		base0C = '#8ce8ff', -- Electric Ice Cyan (Struct members / Fields / Operators)
		base0D = '#1a44cc', -- Dark Sapphire Blue (Functions & definitions)
		base0E = '#b0c4de', -- Light Powder Blue (Types & Structs declarations)
		base0F = '#ff3355' -- High-contrast error red
	},
	gumi = {
		base00 = '#0b120c', -- Dark forest-moss canvas background
		base01 = '#121e14', -- Medium dark green dress shadow
		base02 = '#1d2f20', -- High-contrast panel borders
		base03 = '#526055', -- Muted olive green for comments
		base04 = '#9bb0a2', -- Sage silver trim
		base05 = '#eef5f0', -- Crisp off-white text
		base06 = '#ffffff', -- Stark pure white accents
		base07 = '#d4edd8', -- Light green highlight

		base08 = '#39cc53', -- Gumi Vibrant Green (Keywords / Syntax structure)
		base09 = '#ffa64d', -- Carrot Orange (Variables & parameters)
		base0A = '#ff7f00', -- Bright Goggle Orange (Numbers / Constants)
		base0B = '#b3ff00', -- Glowing Neon Lime (Strings & paths)
		base0C = '#73e68c', -- Light Mint Cyan (Struct members / Fields / Operators)
		base0D = '#28993c', -- Deep Leaf Green (Functions & definitions)
		base0E = '#ffcc99', -- Soft Cream Orange (Types & Structs declarations)
		base0F = '#ff3333' -- Neon red error flag
	},
	ia = {
		base00 = '#0f0e17', -- Haunting midnight violet background
		base01 = '#171524', -- Dark dress layer shadow
		base02 = '#232038', -- Contrast pane borders
		base03 = '#595066', -- Muted plum-gray for comments
		base04 = '#ab9ebb', -- Silver lavender trim
		base05 = '#f7f4fc', -- Ice off-white variable text
		base06 = '#ffffff', -- Pure white highlights
		base07 = '#e5deff', -- Light lavender glow

		base08 = '#fca1ba', -- IA Pastel Cream Pink (Keywords / Structural layout)
		base09 = '#caa6ff', -- Soft Light Violet (Variables & parameters)
		base0A = '#f07178', -- Coral Ribbon Accent (Numbers / Constants)
		base0B = '#00f0ff', -- Crystal Aura Cyan (Strings & paths)
		base0C = '#84ffff', -- Radiant Neon Ice Blue (Struct members / Fields / Operators)
		base0D = '#a066ff', -- Vibrant Cosmic Violet (Functions & definitions)
		base0E = '#ffd1dc', -- Pale Rose Cream (Types & Structs declarations)
		base0F = '#ff3366' -- High-saturation error magenta-red
	},
	teto = {
		base00 = '#121214', -- Gunmetal dark coat background
		base01 = '#19191d', -- Heavy dress seam panel shadow
		base02 = '#25262c', -- Visual selection panel gray
		base03 = '#4e5058', -- Muted iron gray for comments
		base04 = '#a4a8b5', -- Metallic belt silver
		base05 = '#f5f6f8', -- Off-white text base
		base06 = '#ffffff', -- Stark pure white accents
		base07 = '#ffd9e2', -- Light rose pink highlight

		base08 = '#ff2b55', -- Teto Drill-Hair Red (Keywords / Structural layout)
		base09 = '#ff6b8b', -- Soft Pastel Coral Pink (Standard variables & parameters)
		base0A = '#e69d00', -- Muted Brass (Numbers / Constants)
		base0B = '#ffcc00', -- Electric Neon Yellow Trim (Strings & paths)
		base0C = '#ff557f', -- Radiant Synth Pink (Struct members / Fields / Operators)
		base0D = '#c7153a', -- Deep Crimson Wine (Functions & definitions)
		base0E = '#ffa6c9', -- Pale Carnation (Types & Structs declarations)
		base0F = '#ff0033' -- Red peak failure accent
	}
}

-- 2. Master function that completely overwrites highlighters with the active theme
---@param theme_name VocaloidTheme
local function apply_vocaloid_theme(theme_name)
	local palette = theme_palettes[theme_name]
	vim.cmd.highlight("clear")
	vim.o.background = "dark"
	vim.g.colors_name = theme_name

	local set_hl = vim.api.nvim_set_hl

	-- UI Colors
	set_hl(0, "Normal", { fg = palette.base05, bg = palette.base00 })
	set_hl(0, "LineNr", { fg = palette.base03 })
	set_hl(0, "CursorLineNr", { fg = palette.base08, bold = true })
	set_hl(0, "Visual", { bg = palette.base02 })
	set_hl(0, "StatusLine", { fg = palette.base08, bg = palette.base01, bold = true })

	-- Basic Text Tokens
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

	-- Tree-sitter Captures
	set_hl(0, "@variable", { fg = palette.base09 })
	set_hl(0, "@variable.builtin", { fg = palette.base0C, italic = true })
	set_hl(0, "@variable.parameter", { fg = palette.base09 })
	set_hl(0, "@variable.member", { fg = palette.base0C })
	set_hl(0, "@property", { fg = palette.base0C })
	set_hl(0, "@field", { fg = palette.base0C })
	set_hl(0, "@function", { fg = palette.base0D, bold = true })
	set_hl(0, "@function.call", { fg = palette.base0D })
	set_hl(0, "@function.builtin", { fg = palette.base0D, bold = true })
	set_hl(0, "@keyword", { fg = palette.base08, italic = true })
	set_hl(0, "@keyword.function", { fg = palette.base08, bold = true })
	set_hl(0, "@keyword.return", { fg = palette.base08, bold = true })
	set_hl(0, "@keyword.conditional", { fg = palette.base08 })
	set_hl(0, "@keyword.repeat", { fg = palette.base08 })
	set_hl(0, "@keyword.import", { fg = palette.base08 })
	set_hl(0, "@type", { fg = palette.base0E, bold = true })
	set_hl(0, "@type.builtin", { fg = palette.base0E })
	set_hl(0, "@type.qualifier", { fg = palette.base0C })
	set_hl(0, "@lsp.type.interface", { fg = palette.base0C, bold = true })
	set_hl(0, "@lsp.type.struct", { fg = palette.base0E, bold = true })
	set_hl(0, "@lsp.type.class", { fg = palette.base0E, bold = true })
	set_hl(0, "@constructor", { fg = palette.base0E, bold = true })
	set_hl(0, "@punctuation.bracket", { fg = palette.base0C })
	set_hl(0, "@punctuation.delimiter", { fg = palette.base0C })
	set_hl(0, "@string", { fg = palette.base0B })
	set_hl(0, "@constant", { fg = palette.base0A, bold = true })
	set_hl(0, "@constant.builtin", { fg = palette.base0A, bold = true })
	set_hl(0, "@boolean", { fg = palette.base0A, bold = true })
	set_hl(0, "@number", { fg = palette.base0A })

	-- Language Specific Overrides (Rust & Go)
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
end

-- 3. Cycle function that advances the index and calls the reloader
_G.toggle_vocaloid_theme = function()
	current_theme_index = current_theme_index + 1
	if current_theme_index > #vocaloid_themes then
		current_theme_index = 1
	end
	local next_theme = vocaloid_themes[current_theme_index]
	apply_vocaloid_theme(next_theme)
end

-- 4. Set the global keyboard shortcut mapping (<Leader> + t + m)
vim.keymap.set("n", "<Leader>tm", "<cmd>lua toggle_vocaloid_theme()<CR>", {
	desc = "Toggle Vocaloid Syntax Themes",
	silent = true
})

-- Initialize default starter theme on file launch
apply_vocaloid_theme("luka")
