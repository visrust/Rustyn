-- =====================================================
-- Refined Auto Diagnostic Float (Fixed)
-- =====================================================

-- 1. Modern Sign Definitions
local signs = {
    Error = " ", 
    Warn  = " ", 
    Hint  = "󰌵 ", 
    Info  = " ",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl,
        numhl = hl,
    })
end

vim.diagnostic.config({
    signs = true,
    underline = true,
    virtual_text = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = function(diagnostic, _, _)
            -- Map severity to icon with appropriate highlighting
            local severity = diagnostic.severity
            local icon = ""
            local hl = ""
            
            if severity == vim.diagnostic.severity.ERROR then
                icon = signs.Error
                hl = "DiagnosticError"
            elseif severity == vim.diagnostic.severity.WARN then
                icon = signs.Warn
                hl = "DiagnosticWarn"
            elseif severity == vim.diagnostic.severity.HINT then
                icon = signs.Hint
                hl = "DiagnosticHint"
            elseif severity == vim.diagnostic.severity.INFO then
                icon = signs.Info
                hl = "DiagnosticInfo"
            end
            
            return icon .. " ", hl
        end,
    },
})

vim.o.updatetime = 100
local diag_auto_enabled = true
local diag_float_winid = nil

-- 2. Helper: Check if any hover/documentation float exists
local function hover_float_exists()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local config = vim.api.nvim_win_get_config(win)
        if config.relative ~= "" then
            local buf = vim.api.nvim_win_get_buf(win)
            local ft = vim.api.nvim_buf_get_option(buf, "filetype")
            if ft == "markdown" or ft == "lsp-hover" or ft == "" then
                return true
            end
        end
    end
    return false
end

-- 3. Optimized Float Logic
local function open_diagnostic_float()
    if hover_float_exists() then
        return
    end
    
    if diag_float_winid and vim.api.nvim_win_is_valid(diag_float_winid) then
        vim.api.nvim_win_close(diag_float_winid, true)
    end
    
    local _, winid = vim.diagnostic.open_float(nil, {
        focusable = true,
        close_events = { "CursorMoved", "CursorMovedI", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        scope = "line",
        prefix = function(diagnostic, _, _)
            local severity = diagnostic.severity
            local icon = ""
            local hl = ""
            
            if severity == vim.diagnostic.severity.ERROR then
                icon = signs.Error
                hl = "DiagnosticError"
            elseif severity == vim.diagnostic.severity.WARN then
                icon = signs.Warn
                hl = "DiagnosticWarn"
            elseif severity == vim.diagnostic.severity.HINT then
                icon = signs.Hint
                hl = "DiagnosticHint"
            elseif severity == vim.diagnostic.severity.INFO then
                icon = signs.Info
                hl = "DiagnosticInfo"
            end
            
            return icon .. " ", hl
        end,
    })
    
    diag_float_winid = winid
    return winid
end

-- 4. Autocommands
local diag_group = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })

vim.api.nvim_create_autocmd("CursorHold", {
    group = diag_group,
    callback = function()
        if diag_auto_enabled and not vim.api.nvim_get_mode().mode:find("i") then
            open_diagnostic_float()
        end
    end,
})

vim.api.nvim_create_autocmd("WinClosed", {
    group = diag_group,
    callback = function(ev)
        if diag_float_winid and tonumber(ev.match) == diag_float_winid then
            diag_float_winid = nil
        end
    end,
})

-- Add this autocmd to your diagnostic group
vim.api.nvim_create_autocmd("VimResized", {
    group = diag_group,
    callback = function()
        -- Close the existing float if it exists
        if diag_float_winid and vim.api.nvim_win_is_valid(diag_float_winid) then
            vim.api.nvim_win_close(diag_float_winid, true)
            diag_float_winid = nil
            
            -- Reopen if auto-float is enabled and there are diagnostics
            if diag_auto_enabled and not vim.api.nvim_get_mode().mode:find("i") then
                -- Small delay to let the UI settle after resize
                vim.defer_fn(function()
                    open_diagnostic_float()
                end, 50)
            end
        end
    end,
})

-- =====================================================
-- Keymaps
-- =====================================================

vim.keymap.set("n", "<leader>dt", function()
    diag_auto_enabled = not diag_auto_enabled
    local status = diag_auto_enabled and "ON" or "OFF"
    vim.notify("Diagnostic Auto-Float: " .. status, vim.log.levels.INFO)
end, { desc = "Toggle diagnostic auto float" })

vim.keymap.set("n", "gl", function()
    vim.diagnostic.open_float({ 
        border = "rounded", 
        focusable = true,
        prefix = function(diagnostic, _, _)
            local severity = diagnostic.severity
            local icon = ""
            local hl = ""
            
            if severity == vim.diagnostic.severity.ERROR then
                icon = signs.Error
                hl = "DiagnosticError"
            elseif severity == vim.diagnostic.severity.WARN then
                icon = signs.Warn
                hl = "DiagnosticWarn"
            elseif severity == vim.diagnostic.severity.HINT then
                icon = signs.Hint
                hl = "DiagnosticHint"
            elseif severity == vim.diagnostic.severity.INFO then
                icon = signs.Info
                hl = "DiagnosticInfo"
            end
            
            return icon .. " ", hl
        end,
    })
end, { desc = "Open diagnostic float (focusable)" })

vim.keymap.set("n", "<M-j>", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "<M-k>", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev diagnostic" })

vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
