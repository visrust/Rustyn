local M = {}

local function hl_fg(name)
    local hl = vim.api.nvim_get_hl(0, { name = name })
    return hl.fg and string.format('#%06x', hl.fg) or nil
end

local function hl_bg(name)
    local hl = vim.api.nvim_get_hl(0, { name = name })
    return hl.bg and string.format('#%06x', hl.bg) or nil
end

function M.setup()
    local bg = hl_bg('Normal')
    local border_fg =
      hl_fg('Special')
      or hl_fg('NonText')
      or hl_fg('Normal')

    -- Float background
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = bg })

    -- 👇 THIS was missing
    vim.api.nvim_set_hl(0, 'FloatTitle', {
        fg = bg,
        bg = border_fg,
    })


    -- Borders = UI decoration → Special
    vim.api.nvim_set_hl(0, 'FloatBorder', {
        fg = border_fg,
        bg = bg,
    })

    -- Splits / separators are also decorations
    vim.api.nvim_set_hl(0, 'WinSeparator', { fg = border_fg })
    vim.api.nvim_set_hl(0, 'VertSplit', { fg = border_fg })

    vim.g.float_border_style = 'rounded'
end

vim.api.nvim_create_autocmd('ColorScheme', {
    callback = M.setup,
})

M.setup()
return M
