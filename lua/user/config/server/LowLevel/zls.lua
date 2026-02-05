local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('zls', {
    cmd = { 'zls' },
    filetypes = { 'zig', 'zir' },
    root_markers = { 'zls.json', 'build.zig', '.git' },
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 300,  -- Same as your Rust setup
    },
})

vim.lsp.enable('zls')

-- Disable annoying shutdown errors
vim.lsp.handlers["$/progress"] = function() end
