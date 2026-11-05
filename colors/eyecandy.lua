-- Eyecandy for Neovim, ported from the Zed theme (themes/eyecandy.json).
-- Follows 'background': dark is the default, `:set background=light` switches.

vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') == 1 then
	vim.cmd('syntax reset')
end
vim.g.colors_name = 'eyecandy'

-- Zed colours carry alpha; Neovim doesn't, so blend them onto the background.
local function blend(hex, alpha, base)
	local function rgb(h) return tonumber(h:sub(2, 3), 16), tonumber(h:sub(4, 5), 16), tonumber(h:sub(6, 7), 16) end
	local r1, g1, b1 = rgb(hex)
	local r2, g2, b2 = rgb(base)
	local function mix(a, b) return math.floor(a * alpha + b * (1 - alpha) + 0.5) end
	return string.format('#%02x%02x%02x', mix(r1, r2), mix(g1, g2), mix(b1, b2))
end

local c
if vim.o.background == 'light' then
	local bg, ink = '#fcfcfc', '#141414'
	local function a(alpha) return blend(ink, alpha, bg) end
	c = {
		bg = bg,
		surface = '#f3f3f3',
		gutter = bg,
		cursorline = '#ededed',
		fg = a(0.92),
		muted = a(0.68),
		placeholder = a(0.48),
		line_nr = a(0.48),
		cursor_nr = a(0.68),
		border = a(0.15),
		indent = a(0.07),
		indent_active = a(0.15),
		hover = a(0.07),
		comment = '#A5A5A5',
		keyword = '#b8448b',
		variable = a(0.92),
		punctuation = a(0.92),
		escape = a(0.68),
		hint = '#6f9ba6',
	}
else
	local bg = '#131110'
	c = {
		bg = bg,
		surface = '#1A1714',
		gutter = '#151311',
		cursorline = '#201c19',
		fg = '#B6B0A7',
		muted = '#6E6760',
		placeholder = '#4E4842',
		line_nr = '#3a3530',
		cursor_nr = '#777069',
		border = '#25211d',
		indent = '#2D2925',
		indent_active = '#3E3934',
		hover = '#1A1714',
		comment = '#3a3530',
		keyword = '#4E4842',
		variable = '#329AC0',
		punctuation = '#6E6760',
		escape = '#3a3530',
		hint = '#6f9ba6',
	}
end

-- Accents are shared between both variants.
c.blue = '#3c7cab'
c.teal = '#4c7f8c'
c.green = '#1f8a65'
c.amber = '#c08532'
c.red = '#cf2d56'
c.magenta = '#b8448b'
c.orange = '#db704b'
c.info = '#206595'
c.selection = blend(c.blue, 0.24, c.bg)
c.search = blend(c.hint, 0.36, c.bg)
c.diff_add = blend(c.green, 0.10, c.bg)
c.diff_change = blend(c.amber, 0.10, c.bg)
c.diff_delete = blend(c.red, 0.10, c.bg)
c.diff_text = blend(c.amber, 0.25, c.bg)

local groups = {
	-- Editor
	Normal = { fg = c.fg, bg = c.bg },
	NormalNC = { fg = c.fg, bg = c.bg },
	NormalFloat = { fg = c.fg, bg = c.surface },
	FloatBorder = { fg = c.border, bg = c.surface },
	FloatTitle = { fg = c.fg, bg = c.surface, bold = true },
	Cursor = { fg = c.bg, bg = c.blue },
	CursorLine = { bg = c.cursorline },
	CursorColumn = { bg = c.cursorline },
	ColorColumn = { bg = c.surface },
	LineNr = { fg = c.line_nr, bg = c.gutter },
	CursorLineNr = { fg = c.cursor_nr, bg = c.cursorline },
	SignColumn = { bg = c.gutter },
	FoldColumn = { fg = c.line_nr, bg = c.gutter },
	Folded = { fg = c.muted, bg = c.surface },
	VertSplit = { fg = c.border },
	WinSeparator = { fg = c.border },
	EndOfBuffer = { fg = c.bg },
	NonText = { fg = c.line_nr },
	Whitespace = { fg = c.indent },
	SpecialKey = { fg = c.line_nr },
	Visual = { bg = c.selection },
	VisualNOS = { bg = c.selection },
	Search = { bg = c.search },
	IncSearch = { fg = c.bg, bg = c.amber },
	CurSearch = { fg = c.bg, bg = c.amber },
	Substitute = { fg = c.bg, bg = c.red },
	MatchParen = { bg = c.indent_active, bold = true },
	Pmenu = { fg = c.fg, bg = c.surface },
	PmenuSel = { bg = c.selection },
	PmenuSbar = { bg = c.surface },
	PmenuThumb = { bg = c.border },
	StatusLine = { fg = c.muted, bg = c.surface },
	StatusLineNC = { fg = c.placeholder, bg = c.bg },
	TabLine = { fg = c.placeholder, bg = c.bg },
	TabLineSel = { fg = c.fg, bg = c.surface },
	TabLineFill = { bg = c.bg },
	WinBar = { fg = c.muted, bg = c.bg },
	WinBarNC = { fg = c.placeholder, bg = c.bg },
	Title = { fg = c.red },
	Directory = { fg = c.blue },
	Question = { fg = c.blue },
	MoreMsg = { fg = c.blue },
	ModeMsg = { fg = c.muted },
	ErrorMsg = { fg = c.red },
	WarningMsg = { fg = c.orange },
	Conceal = { fg = c.placeholder },
	SpellBad = { sp = c.red, undercurl = true },
	SpellCap = { sp = c.orange, undercurl = true },
	SpellRare = { sp = c.magenta, undercurl = true },
	SpellLocal = { sp = c.teal, undercurl = true },

	-- Diff
	DiffAdd = { bg = c.diff_add },
	DiffChange = { bg = c.diff_change },
	DiffDelete = { fg = c.red, bg = c.diff_delete },
	DiffText = { bg = c.diff_text },
	Added = { fg = c.green },
	Changed = { fg = c.amber },
	Removed = { fg = c.red },

	-- Syntax
	Comment = { fg = c.comment, italic = true },
	Constant = { fg = c.amber },
	String = { fg = c.green },
	Character = { fg = c.green },
	Number = { fg = c.amber },
	Boolean = { fg = c.amber },
	Float = { fg = c.amber },
	Identifier = { fg = c.variable },
	Function = { fg = c.blue },
	Statement = { fg = c.keyword },
	Conditional = { fg = c.keyword },
	Repeat = { fg = c.keyword },
	Label = { fg = c.blue },
	Operator = { fg = c.teal },
	Keyword = { fg = c.keyword },
	Exception = { fg = c.keyword },
	PreProc = { fg = c.fg },
	Include = { fg = c.keyword },
	Define = { fg = c.keyword },
	Macro = { fg = c.amber },
	PreCondit = { fg = c.keyword },
	Type = { fg = c.teal },
	StorageClass = { fg = c.keyword },
	Structure = { fg = c.teal },
	Typedef = { fg = c.teal },
	Special = { fg = c.amber },
	SpecialChar = { fg = c.escape },
	Tag = { fg = c.blue },
	Delimiter = { fg = c.punctuation },
	SpecialComment = { fg = c.comment, italic = true },
	Debug = { fg = c.red },
	Underlined = { underline = true },
	Error = { fg = c.red },
	Todo = { fg = c.amber, bold = true },

	-- Treesitter
	['@variable'] = { fg = c.variable },
	['@variable.builtin'] = { fg = c.amber },
	['@variable.parameter'] = { fg = c.variable },
	['@variable.member'] = { fg = c.red },
	['@property'] = { fg = c.red },
	['@constant'] = { fg = c.amber },
	['@constant.builtin'] = { fg = c.amber },
	['@module'] = { fg = c.fg },
	['@label'] = { fg = c.blue },
	['@string'] = { fg = c.green },
	['@string.escape'] = { fg = c.escape },
	['@string.regexp'] = { fg = c.amber },
	['@string.special'] = { fg = c.amber },
	['@string.special.symbol'] = { fg = c.amber },
	['@string.special.url'] = { fg = c.teal, underline = true },
	['@character'] = { fg = c.green },
	['@number'] = { fg = c.amber },
	['@boolean'] = { fg = c.amber },
	['@type'] = { fg = c.teal },
	['@type.builtin'] = { fg = c.teal },
	['@attribute'] = { fg = c.blue },
	['@function'] = { fg = c.blue },
	['@function.builtin'] = { fg = c.blue },
	['@function.call'] = { fg = c.blue },
	['@function.method'] = { fg = c.blue },
	['@function.method.call'] = { fg = c.blue },
	['@constructor'] = { fg = c.blue },
	['@operator'] = { fg = c.teal },
	['@keyword'] = { fg = c.keyword },
	['@punctuation'] = { fg = c.punctuation },
	['@punctuation.bracket'] = { fg = c.punctuation },
	['@punctuation.delimiter'] = { fg = c.punctuation },
	['@punctuation.special'] = { fg = c.punctuation },
	['@comment'] = { link = 'Comment' },
	['@tag'] = { fg = c.blue },
	['@tag.attribute'] = { fg = c.red },
	['@tag.delimiter'] = { fg = c.punctuation },
	['@markup.heading'] = { fg = c.red },
	['@markup.strong'] = { bold = true },
	['@markup.italic'] = { italic = true },
	['@markup.link'] = { fg = c.blue },
	['@markup.link.url'] = { fg = c.teal, underline = true },
	['@markup.raw'] = { fg = c.green },
	['@markup.list'] = { fg = c.punctuation },
	['@diff.plus'] = { fg = c.green },
	['@diff.minus'] = { fg = c.red },
	['@diff.delta'] = { fg = c.amber },

	-- LSP semantic tokens
	['@lsp.type.enum'] = { fg = c.red },
	['@lsp.type.enumMember'] = { fg = c.blue },
	['@lsp.type.namespace'] = { fg = c.fg },
	['@lsp.type.property'] = { fg = c.red },
	['@lsp.type.variable'] = { fg = c.variable },
	['@lsp.type.parameter'] = { fg = c.variable },
	LspReferenceText = { bg = c.hover },
	LspReferenceRead = { bg = c.hover },
	LspReferenceWrite = { bg = c.indent_active },
	LspInlayHint = { fg = c.placeholder, italic = true },

	-- Diagnostics
	DiagnosticError = { fg = c.red },
	DiagnosticWarn = { fg = c.orange },
	DiagnosticInfo = { fg = c.info },
	DiagnosticHint = { fg = c.hint },
	DiagnosticOk = { fg = c.green },
	DiagnosticUnderlineError = { sp = c.red, undercurl = true },
	DiagnosticUnderlineWarn = { sp = c.orange, undercurl = true },
	DiagnosticUnderlineInfo = { sp = c.info, undercurl = true },
	DiagnosticUnderlineHint = { sp = c.hint, undercurl = true },
	DiagnosticVirtualTextError = { fg = c.red, bg = c.diff_delete },
	DiagnosticVirtualTextWarn = { fg = c.orange, bg = blend(c.orange, 0.10, c.bg) },
	DiagnosticVirtualTextInfo = { fg = c.info, bg = blend(c.info, 0.10, c.bg) },
	DiagnosticVirtualTextHint = { fg = c.hint, bg = blend(c.hint, 0.10, c.bg) },

	-- Gitsigns
	GitSignsAdd = { fg = c.green, bg = c.gutter },
	GitSignsChange = { fg = c.amber, bg = c.gutter },
	GitSignsDelete = { fg = c.red, bg = c.gutter },
	GitSignsCurrentLineBlame = { fg = c.placeholder, italic = true },

	-- Telescope
	TelescopeNormal = { fg = c.fg, bg = c.surface },
	TelescopeBorder = { fg = c.border, bg = c.surface },
	TelescopeTitle = { fg = c.muted, bold = true },
	TelescopeSelection = { bg = c.selection },
	TelescopeMatching = { fg = c.blue, bold = true },
	TelescopePromptPrefix = { fg = c.blue },

	-- Neo-tree
	NeoTreeNormal = { fg = c.muted, bg = c.bg },
	NeoTreeNormalNC = { fg = c.muted, bg = c.bg },
	NeoTreeWinSeparator = { fg = c.border, bg = c.bg },
	NeoTreeDirectoryName = { fg = c.muted },
	NeoTreeDirectoryIcon = { fg = c.placeholder },
	NeoTreeRootName = { fg = c.fg, bold = true },
	NeoTreeFileName = { fg = c.fg },
	NeoTreeIndentMarker = { fg = c.indent },
	NeoTreeCursorLine = { bg = c.cursorline },
	NeoTreeGitAdded = { fg = c.green },
	NeoTreeGitModified = { fg = c.amber },
	NeoTreeGitDeleted = { fg = c.red },
	NeoTreeGitUntracked = { fg = c.green },
	NeoTreeGitIgnored = { fg = c.placeholder },

	-- nvim-cmp
	CmpItemAbbrMatch = { fg = c.blue, bold = true },
	CmpItemAbbrMatchFuzzy = { fg = c.blue },
	CmpItemKind = { fg = c.teal },
	CmpItemMenu = { fg = c.placeholder },
}

for group, opts in pairs(groups) do
	vim.api.nvim_set_hl(0, group, opts)
end

-- Terminal buffers use the Zed terminal palette.
local ansi = vim.o.background == 'light'
	and { '#141414', '#cf2d56', '#1f8a65', '#a16900', '#3c7cab', '#b8448b', '#4c7f8c', '#fcfcfc',
		'#5b5b5b', '#e75e78', '#55a583', '#c08532', '#6299c3', '#d06ba6', '#6f9ba6', '#ffffff' }
	or { '#25211d', '#e75e78', '#55a583', '#dba35e', '#6299c3', '#d06ba6', '#6f9ba6', '#fcfcfc',
		'#6E6760', '#f28da0', '#7fc4a4', '#ecc08a', '#8db9db', '#e494c4', '#98c0ca', '#ffffff' }
for i, color in ipairs(ansi) do
	vim.g['terminal_color_' .. (i - 1)] = color
end
