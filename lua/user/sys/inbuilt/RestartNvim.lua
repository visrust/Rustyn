vim.api.nvim_create_user_command("RestartNvim", function()
  local args = vim.v.argv
  args[1] = vim.v.progpath -- force correct binary
  vim.fn.jobstart(args, { detach = true })
  vim.cmd("qa")
end, {})
