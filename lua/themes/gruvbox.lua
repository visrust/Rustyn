require('gruvbox').setup({
    terminal_colors = true,
    bold = true,
    italic = {
        strings = true,
        emphasis = true,
        comments = true,
        folds = true,
    },
    contrast = 'hard',
})

local function gruvbox_overrides()
  local hl = vim.api.nvim_get_hl
  local set = vim.api.nvim_set_hl

  local normal = hl(0, { name = "Normal" })

  set(0, "SignColumn", { link = "Normal" })

  set(0, "DiagnosticSignError", { link = "Error" })
  set(0, "DiagnosticSignWarn",  { link = "WarningMsg" })
  set(0, "DiagnosticSignInfo",  { link = "Identifier" })
  set(0, "DiagnosticSignHint",  { link = "Comment" })

  -- enforce background match
  for _, g in ipairs({
    "DiagnosticSignError",
    "DiagnosticSignWarn",
    "DiagnosticSignInfo",
    "DiagnosticSignHint",
  }) do
    local fg = hl(0, { name = g }).fg
    set(0, g, { fg = fg, bg = normal.bg })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "gruvbox",
  callback = gruvbox_overrides,
})
