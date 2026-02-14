-- =====================================================
-- Minimal UI - No Sign Column, No Line Numbers
-- =====================================================

vim.o.signcolumn = "no"
vim.o.number = false
vim.o.relativenumber = false

-- Diagnostic signs (not visible, but needed for the system to work)
local signs = {
    Error = " ", 
    Warn  = " ", 
    Hint  = "󰌵 ", 
    Info  = " ",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
        text = "",
        texthl = "",
        numhl = "",
    })
end

-- Helper function to get severity summary for a line
local function get_line_severity_summary(line_diagnostics)
    local has_error = false
    local has_warn = false
    local has_hint = false
    local has_info = false
    
    for _, diag in ipairs(line_diagnostics) do
        if diag.severity == vim.diagnostic.severity.ERROR then
            has_error = true
        elseif diag.severity == vim.diagnostic.severity.WARN then
            has_warn = true
        elseif diag.severity == vim.diagnostic.severity.HINT then
            has_hint = true
        elseif diag.severity == vim.diagnostic.severity.INFO then
            has_info = true
        end
    end
    
    local parts = {}
    if has_error then table.insert(parts, "Error") end
    if has_warn then table.insert(parts, "Warning") end
    if has_hint then table.insert(parts, "Hint") end
    if has_info then table.insert(parts, "Info") end
    
    return "<-- " .. table.concat(parts, " + ")
end

vim.diagnostic.config({
    signs = false,
    underline = true,
    virtual_text = {
        spacing = 4,
        prefix = function(diagnostic, i, total)
            -- Get all diagnostics for this line
            local bufnr = vim.api.nvim_get_current_buf()
            local line = diagnostic.lnum
            local line_diagnostics = vim.diagnostic.get(bufnr, { lnum = line })
            
            -- Only show summary on first diagnostic of the line
            if i == 1 then
                return get_line_severity_summary(line_diagnostics) .. " "
            else
                return ""
            end
        end,
        format = function(diagnostic)
            -- Don't show individual diagnostic text in virtual text
            return ""
        end,
    },
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        wrap = true,
        prefix = function(diagnostic, i, total)
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
            
            -- Add numbering with line info
            local line = diagnostic.lnum + 1
            local col = diagnostic.col + 1
            return string.format("[%d]. %s [%d:%d] ", i, icon, line, col), hl
        end,
    },
})

vim.o.updatetime = 100
local diag_auto_enabled = true
local diag_float_winid = nil

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
        wrap = true,
        prefix = function(diagnostic, i, total)
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
            
            -- Add numbering with line info
            local line = diagnostic.lnum + 1
            local col = diagnostic.col + 1
            return string.format("[%d]. %s [%d:%d] ", i, icon, line, col), hl
        end,
    })
    
    diag_float_winid = winid
    return winid
end

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

vim.api.nvim_create_autocmd("VimResized", {
    group = diag_group,
    callback = function()
        if diag_float_winid and vim.api.nvim_win_is_valid(diag_float_winid) then
            vim.api.nvim_win_close(diag_float_winid, true)
            diag_float_winid = nil
            
            if diag_auto_enabled and not vim.api.nvim_get_mode().mode:find("i") then
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
        wrap = true,
        prefix = function(diagnostic, i, total)
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
            
            -- Add numbering with line info
            local line = diagnostic.lnum + 1
            local col = diagnostic.col + 1
            return string.format("[%d]. %s [%d:%d] ", i, icon, line, col), hl
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

vim.keymap.set("n", "<leader>tn", function()
    vim.o.number = not vim.o.number
end, { desc = "Toggle line numbers" })
