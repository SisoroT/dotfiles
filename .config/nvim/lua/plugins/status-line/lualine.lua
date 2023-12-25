-- bottom status bar
return {
    "nvim-lualine/lualine.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",

    config = function()
        local lualine = require("lualine")
        -- stylua: ignore
        local colors = {
            bg      = "#1c1c1c",
            fg      = "#f8f8f2",
            yellow  = "#f1fa8c",
            cyan    = "#8be9fd",
            green   = "#50fa7b",
            orange  = "#ffb86c",
            purple  = "#bd93f9",
            pink    = "#ff79c6",
            red     = "#ff5555",
            lightbg = "#28282B",
        }

        -- git conditions
        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
            end,
            hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end,
            check_git_workspace = function()
                local filepath = vim.fn.expand("%:p:h")
                local gitdir = vim.fn.finddir(".git", filepath .. ";")
                return gitdir and #gitdir > 0 and #gitdir < #filepath
            end,
        }

        --
        --
        -- CONFIG
        --
        --
        local config = {
            options = {
                -- Disable sections and component separators
                component_separators = "",
                section_separators = "",
                -- theme = {
                -- 	-- We are going to use lualine_c an lualine_x as left and
                -- 	-- right section. Both are highlighted by c theme .  So we
                -- 	-- are just setting default looks o statusline
                -- 	normal = { c = { fg = colors.fg, bg = colors.bg } },
                -- 	inactive = { c = { fg = colors.fg, bg = colors.bg } },
                -- },
            },
            sections = {
                -- these are to remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                -- These will be filled later
                lualine_c = {},
                lualine_x = {},
            },
            inactive_sections = {
                -- these are to remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
        }

        -- Inserts a component in lualine_c at left section
        local function ins_left(component)
            table.insert(config.sections.lualine_c, component)
        end

        -- Inserts a component in lualine_x at right section
        local function ins_right(component)
            table.insert(config.sections.lualine_x, component)
        end

        --
        --
        -- LEFT
        --
        --

        -- show letter and icon of current mode
        ins_left({
            -- mode component
            function()
                -- auto change icon based on mode
                local icons = {
                    n = "  ",
                    i = "  ",
                    c = " ﲵ ",
                    V = "  ",
                    [""] = "  ",
                    v = "  ",
                    C = " ﲵ ",
                    R = " ﯒ ",
                    s = " 麗",
                    t = "  ",
                }
                -- auto change letter based on mode
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
                    [""] = "SELECT ",
                    ["r"] = "HIT-ENTER ",
                    t = "T ",
                    ["!"] = "SH ",
                }

                local vim_mode = vim.fn.mode()
                return icons[vim.fn.mode()] .. alias[vim_mode]
            end,
            -- auto change color according to neovims mode
            color = function()
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
                return { fg = mode_color[vim.fn.mode()] }
            end,
            padding = 0,
        })

        -- file icon
        ins_left({
            "filetype",
            colored = true, -- Displays filetype icon in color if set to true
            icon_only = true, -- Display only an icon for filetype
            padding = { left = 1 },
        })

        -- file name
        ins_left({
            "filename",
            cond = conditions.buffer_not_empty,
            color = { fg = colors.fg, gui = "bold,italic" },
        })

        -- file size
        ins_left({
            "filesize",
            cond = conditions.buffer_not_empty,
            padding = { right = 1 },
        })

        -- diagnostics
        ins_left({
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " " },
            diagnostics_color = {
                color_error = { fg = colors.red },
                color_warn = { fg = colors.yellow },
                color_info = { fg = colors.cyan },
            },
        })

        --
        --
        -- RIGHT
        --
        --

        -- git icon
        ins_right({
            "branch",
            icon = "",
            color = { fg = colors.green },
        })

        -- git symbols
        ins_right({
            "diff",
            -- Is it me or the symbol for modified is really weird
            symbols = { added = " ", modified = "柳", removed = " " },
            diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.orange },
                removed = { fg = colors.red },
            },
            cond = conditions.hide_in_width,
        })

        -- line number
        ins_right({
            function()
                local line = vim.fn.line(".")
                local max_lines = vim.fn.line("$")
                return string.format("%3d/%d", line, max_lines)
            end,
        })

        -- colored separator
        ins_right({
            function()
                return "|"
            end,
            color = { fg = colors.pink },
            padding = 0,
        })

        -- progress percentage
        ins_right({
            "progress",
            icon = "",
            color = { fg = colors.purple },
        })

        -- progress bar
        ins_right({
            function()
                local current_line = vim.fn.line(".")
                local total_lines = vim.fn.line("$")
                local default_chars =
                { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
                local chars = default_chars
                local index = 1

                if current_line == 1 then
                    index = 1
                elseif current_line == total_lines then
                    index = #chars
                else
                    local line_no_fraction = vim.fn.floor(current_line) / vim.fn.floor(total_lines)
                    index = vim.fn.float2nr(line_no_fraction * #chars)
                    if index == 0 then
                        index = 1
                    end
                end
                return chars[index]
            end,
            color = { fg = colors.purple },
            padding = { right = 1 },
        })
        lualine.setup(config)
    end,
}
