vim.defer_fn(function()
    require('autopairs.autopairs')
    require('autopairs.autopair_rule')
end, 200)

vim.defer_fn(function ()
    require("keymaps.general")
end, 50)
require('themes.gruvbox')
