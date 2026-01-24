local mini_notify = require('mini.notify')

mini_notify.setup({
    content = {
        format = nil,
        sort = nil,
    },
    lsp_progress = {
        enable = false,
        duration_last = 1000,
    },
    window = {
        config = {
            border = "rounded",
            anchor = "NE",  -- Changed to NE (top-right is more standard)
            focusable = false,
            zindex = 100,
            style = "minimal",
        },
        winblend = 10,
        max_width_share = 0.35,
        max_height_share = 0.25,
    },
})

-- Override vim.notify
vim.notify = mini_notify.make_notify({
    ERROR = { duration = 10000, hl_group = 'DiagnosticError' },
    WARN  = { duration = 5000, hl_group = 'DiagnosticWarn' },
    INFO  = { duration = 3000, hl_group = 'DiagnosticInfo' },
    DEBUG = { duration = 3000, hl_group = 'DiagnosticHint' },
    TRACE = { duration = 3000, hl_group = 'DiagnosticHint' },
})

-- LSP message handler
vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local client_name = client and client.name or "LSP"
    
    local level_map = {
        [1] = vim.log.levels.ERROR,
        [2] = vim.log.levels.WARN,
        [3] = vim.log.levels.INFO,
        [4] = vim.log.levels.DEBUG,
    }
    
    local level = level_map[result.type] or vim.log.levels.INFO
    vim.notify(string.format("[%s] %s", client_name, result.message), level)
end

-- Keybindings

-- REMOVE the nvim-notify setup completely
