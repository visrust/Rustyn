local M = {}

-- State
local state = {
    enabled = true,
    virtual_text = false,
    signs = true,
    underline = true,
    auto_popup = false,
}

-- Icons
local icons = {
    error = "󰅙",
    warn = "󰀩",
    hint = "󰋼",
    info = "󰌵",
}

-- Apply config
local function apply()
    vim.diagnostic.config({
        update_in_insert = false,
        severity_sort = true,
        virtual_text = state.virtual_text and { spacing = 4, prefix = '●' } or false,
        signs = state.signs and {
            text = {
                [vim.diagnostic.severity.ERROR] = icons.error,
                [vim.diagnostic.severity.WARN] = icons.warn,
                [vim.diagnostic.severity.HINT] = icons.hint,
                [vim.diagnostic.severity.INFO] = icons.info,
            },
        } or false,
        underline = state.underline,
        float = {
            border = "rounded",
            source = "always",
            header = "",
            prefix = function(diagnostic, i, total)
                local icon = icons[vim.diagnostic.severity[diagnostic.severity]:lower()] or ""
                local prefix = i .. ". " .. icon .. " "
                
                -- Add separator line after each diagnostic (except the last one)
                if i < total then
                    prefix = prefix .. "\n" .. string.rep("─", 50) .. "\n"
                end
                
                return prefix, "DiagnosticFloating" .. vim.diagnostic.severity[diagnostic.severity]
            end,
        },
    })
    
    if state.enabled then
        vim.diagnostic.enable()
    else
        vim.diagnostic.disable()
    end
end

-- Initialize
apply()
vim.opt.updatetime = 300

-- Auto-popup setup
local group = vim.api.nvim_create_augroup("Diagnostics", { clear = true })

local function setup_auto_popup()
    vim.api.nvim_clear_autocmds({ group = group, event = "CursorHold" })
    
    if state.auto_popup and state.enabled then
        vim.api.nvim_create_autocmd("CursorHold", {
            group = group,
            callback = function()
                if vim.api.nvim_get_mode().mode ~= 'n' then return end
                
                -- Don't open if float already exists
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    if vim.api.nvim_win_get_config(win).relative ~= "" then
                        return
                    end
                end
                
                vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
            end,
        })
    end
end

setup_auto_popup()

-- Toggle functions
function M.toggle()
    state.enabled = not state.enabled
    apply()
    setup_auto_popup()
    vim.notify('Diagnostics ' .. (state.enabled and 'ON' or 'OFF'))
end

function M.toggle_auto_popup()
    state.auto_popup = not state.auto_popup
    setup_auto_popup()
    vim.notify('Auto popup ' .. (state.auto_popup and 'ON' or 'OFF'))
end

function M.show()
    vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
end

-- Modes
local modes = {
    { name = "Full", enabled = true, signs = true, underline = true },
    { name = "Minimal", enabled = true, signs = true, underline = false },
    { name = "Silent", enabled = true, signs = false, underline = false },
    { name = "Off", enabled = false, signs = false, underline = false },
}
local mode_idx = 1

function M.cycle_mode()
    mode_idx = (mode_idx % #modes) + 1
    local mode = modes[mode_idx]
    
    state.enabled = mode.enabled
    state.signs = mode.signs
    state.underline = mode.underline
    
    apply()
    setup_auto_popup()
    vim.notify('Mode: ' .. mode.name)
end

-- Keymaps (minimal - just aa and ee like you wanted)
vim.keymap.set('n', 'aa', M.toggle_auto_popup, { desc = 'Toggle Auto Popup' })
vim.keymap.set('n', 'ee', M.show, { desc = 'Show Diagnostic' })
vim.keymap.set('n', '<leader>dt', M.toggle, { desc = 'Toggle Diagnostics' })
vim.keymap.set('n', '<leader>dm', M.cycle_mode, { desc = 'Cycle Mode' })

-- Navigation
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })
vim.keymap.set('n', '[e', function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = 'Previous Error' })
vim.keymap.set('n', ']e', function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = 'Next Error' })

return M
