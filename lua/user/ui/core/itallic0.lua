local function remove_italics()
  local groups_to_fix = {
    "Comment",
    "Keyword",
    "Function",
    "Type",
    "String",
    "Special",
    -- Add more specific groups as needed
  }
  
  for _, group in ipairs(groups_to_fix) do
    local hl = vim.api.nvim_get_hl(0, { name = group })
    if hl and hl.italic then
      hl.italic = false
      vim.api.nvim_set_hl(0, group, hl)
    end
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = remove_italics,
})

remove_italics() -- Run once for current theme
