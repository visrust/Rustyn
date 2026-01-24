-- Force float windows to use theme background and clear borders
vim.opt.fillchars = { eob = " " }
local M = {}

-- Get the most prominent highlight group's foreground color
local function get_theme_border_color()
  -- Priority order of highlight groups to check for border color
  local priority_groups = {
    'Normal',
    'Comment',
    'Special',
    'Statement',
    'Identifier',
    'Constant',
  }
  
  for _, group in ipairs(priority_groups) do
    local hl = vim.api.nvim_get_hl(0, { name = group })
    if hl.fg then
      return string.format("#%06x", hl.fg)
    end
  end
  
  return "#ffffff" -- fallback
end

-- Get normal background color
local function get_normal_bg()
  local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal' })
  if normal_hl.bg then
    return string.format("#%06x", normal_hl.bg)
  end
  return "NONE"
end

-- Setup function to configure float windows
function M.setup()
  local normal_bg = get_normal_bg()
  local border_color = get_theme_border_color()
  
  -- Set float window highlight groups
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = normal_bg })
  vim.api.nvim_set_hl(0, 'FloatBorder', { fg = border_color, bg = normal_bg })
  
  -- Also fix split borders to be more visible
  vim.api.nvim_set_hl(0, 'VertSplit', { fg = border_color })
  vim.api.nvim_set_hl(0, 'WinSeparator', { fg = border_color })
  
  -- Set default border style for floating windows
  vim.g.float_border_style = 'rounded'
end

-- Create a float window with proper styling
function M.create_float(opts)
  opts = opts or {}
  
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)
  
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)
  
  local buf = vim.api.nvim_create_buf(false, true)
  
  local win_opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = opts.border or 'rounded',
  }
  
  local win = vim.api.nvim_open_win(buf, true, win_opts)
  
  return buf, win
end

-- Auto-refresh on colorscheme change
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    M.setup()
  end,
  desc = 'Fix float window colors on colorscheme change'
})

-- Initial setup
M.setup()

return M
