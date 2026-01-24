-- SGT: Safe Global Theme setter
local init_path = vim.fn.stdpath("config") .. "/init.lua"

local function replace_colorscheme_in_init(theme_name)
  -- Read init.lua
  local file = io.open(init_path, "r")
  if not file then
    vim.notify("✗ Could not read init.lua", vim.log.levels.ERROR)
    return false
  end
  
  local content = file:read("*all")
  file:close()
  
  -- Match: vim.cmd.colorscheme("anything") or vim.cmd.colorscheme('anything')
  local pattern = '(vim%.cmd%.colorscheme%s*%(%s*["\'])([^"\']+)(["\']%s*%))'
  
  -- Check if pattern exists
  if not content:match(pattern) then
    vim.notify("✗ No vim.cmd.colorscheme() found in init.lua", vim.log.levels.ERROR)
    return false
  end
  
  -- Create backup
  local backup_path = init_path .. ".backup"
  local backup_file = io.open(backup_path, "w")
  if backup_file then
    backup_file:write(content)
    backup_file:close()
  end
  
  -- Replace theme name only (preserves quotes and formatting)
  local new_content = content:gsub(pattern, "%1" .. theme_name .. "%3")
  
  -- Write back
  file = io.open(init_path, "w")
  if not file then
    vim.notify("✗ Could not write to init.lua", vim.log.levels.ERROR)
    return false
  end
  
  file:write(new_content)
  file:close()
  
  vim.notify("✓ Theme saved to init.lua (backup created)", vim.log.levels.INFO)
  return true
end

-- SGT Command
vim.api.nvim_create_user_command("SGT", function(opts)
  local theme = opts.args
  
  if theme == "" then
    -- Show picker
    local themes = vim.fn.getcompletion("", "color")
    vim.ui.select(themes, {
      prompt = "Set Global Theme:",
    }, function(choice)
      if choice then
        if pcall(vim.cmd.colorscheme, choice) then
          replace_colorscheme_in_init(choice)
        else
          vim.notify("✗ Theme not found: " .. choice, vim.log.levels.ERROR)
        end
      end
    end)
  else
    -- Direct theme
    if pcall(vim.cmd.colorscheme, theme) then
      replace_colorscheme_in_init(theme)
    else
      vim.notify("✗ Theme not found: " .. theme, vim.log.levels.ERROR)
    end
  end
end, {
  nargs = "?",
  complete = "color",
  desc = "Set Global Theme (writes to init.lua)"
})
