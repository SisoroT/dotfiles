local gl = require("galaxyline")
local gls = gl.section

gl.short_line_list = { " " } -- keeping this table { } as empty will show inactive statuslines

-- stylua: ignore
local colors = {
    bg       =  "#1c1c1c",
    lightbg  =  "#28282B",
    fg       =  "#f8f8f2",
    cyan     =  "#8be9fd",
    green    =  "#50fa7b",
    orange   =  "#ffb86c",
    pink     =  "#ff79c6",
    purple   =  "#bd93f9",
    red      =  "#ff5555",
    yellow   =  "#f1fa8c",
}

--
--
--
--
-- LEFT SIDE
--
--
--
--
gls.left[1] = {
	ViMode = {
		icon = function()
			local icons = {
				n = "   ",
				i = "   ",
				c = "  ﲵ ",
				V = "   ",
				[""] = "   ",
				v = "   ",
				C = "  ﲵ ",
				R = "  ﯒ ",
				t = "   ",
			}
			return icons[vim.fn.mode()]
		end,
		provider = function()
			-- auto change color according the vim mode
			local alias = {
				n = "N ",
				i = "I ",
				c = "C ",
				V = "VL ",
				[""] = "VB ",
				v = "V ",
				C = "C ",
				["r?"] = ":CONFIRM ",
				rm = "--MORE ",
				R = "R ",
				Rv = "R&V ",
				s = "S ",
				S = "S ",
				["r"] = "HIT-ENTER ",
				[""] = "SELECT ",
				t = "T ",
				["!"] = "SH ",
			}
			local mode_color = {
				n = colors.purple,
				i = colors.yellow,
				v = colors.green,
				[""] = colors.green,
				V = colors.green,
				c = colors.pink,
				no = colors.red,
				s = colors.orange,
				S = colors.orange,
				[""] = colors.orange,
				ic = colors.yellow,
				R = colors.purple,
				Rv = colors.purple,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				["r?"] = colors.cyan,
				["!"] = colors.red,
				t = colors.red,
			}

			local vim_mode = vim.fn.mode()
			vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim_mode])
			return alias[vim_mode]
		end,
		highlight = { colors.bg, colors.bg },
		separator = " ",
		separator_highlight = { colors.fg, colors.bg },
	},
}

gls.left[2] = {
	FileIcon = {
		provider = "FileIcon",
		condition = buffer_not_empty,
		highlight = { require("galaxyline.providers.fileinfo").get_file_icon_color, colors.bg },
	},
}

gls.left[3] = {
	FileName = {
		provider = { "FileName", "FileSize" },
		condition = buffer_not_empty,
		highlight = { colors.fg, colors.bg },
	},
}

local checkwidth = function()
	local squeeze_width = vim.fn.winwidth(0) / 2
	if squeeze_width > 40 then
		return true
	end
	return false
end

gls.left[4] = {
	DiffAdd = {
		provider = "DiffAdd",
		condition = checkwidth,
		icon = "   ",
		highlight = { colors.green, colors.bg },
	},
}

gls.left[5] = {
	DiffModified = {
		provider = "DiffModified",
		condition = checkwidth,
		icon = " ",
		highlight = { colors.orange, colors.bg },
	},
}

gls.left[6] = {
	DiffRemove = {
		provider = "DiffRemove",
		condition = checkwidth,
		icon = " ",
		highlight = { colors.red, colors.bg },
	},
}

gls.left[7] = {
	LeftEnd = {
		provider = function()
			return " "
		end,
		separator = " ",
		separator_highlight = { colors.bg, colors.bg },
		highlight = { colors.bg, colors.bg },
	},
}

gls.left[8] = {
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = "  ",
		highlight = { colors.red, colors.bg },
	},
}

gls.left[9] = {
	Space = {
		provider = function()
			return " "
		end,
		highlight = { colors.bg, colors.bg },
	},
}

gls.left[10] = {
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = "  ",
		highlight = { colors.orange, colors.bg },
	},
}

--
--
--
--
-- RIGHT SIDE
--
--
--
--
gls.right[1] = {
	GitIcon = {
		provider = function()
			return "  "
		end,
		condition = require("galaxyline.providers.vcs").check_git_workspace,
		highlight = { colors.green, colors.bg },
	},
}

gls.right[2] = {
	GitBranch = {
		provider = "GitBranch",
		condition = require("galaxyline.providers.vcs").check_git_workspace,
		highlight = { colors.green, colors.bg },
	},
}

gls.right[3] = {
	LineInfo = {
		provider = function()
			local line = vim.fn.line(".")
			local max_lines = vim.fn.line("$")
			return string.format("%3d/%d", line, max_lines)
		end,
		separator = " ",
		separator_highlight = { colors.pink, colors.bg },
		highlight = { colors.fg, colors.bg },
	},
}

gls.right[4] = {
	some_icon = {
		provider = function()
			return "  "
		end,
		separator = " | ",
		separator_highlight = { colors.pink, colors.bg },
		highlight = { colors.fg, colors.bg },
	},
}

gls.right[5] = {
	PerCent = {
		provider = "LinePercent",
		highlight = { colors.fg, colors.bg },
	},
}

gls.right[6] = {
	ScrollBar = {
		provider = "ScrollBar",
		highlight = { colors.yellow, colors.purple },
	},
}

gls.right[7] = {
	SpaceEnd = {
		provider = function()
			return " "
		end,
		highlight = { colors.bg, colors.bg },
	},
}
