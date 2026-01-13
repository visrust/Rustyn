-- Smart and toggleable diagnostic configuration for Neovim

-- Create augroup for cleanup
local diagnostic_group = vim.api.nvim_create_augroup("CustomDiagnostics", { clear = true })

-- State variables
local diagnostics_state = {
    enabled = true,
    virtual_text = false,
    signs = true,
    underline = true,
    auto_popup = true,
    update_in_insert = false,
}

-- Apply diagnostic configuration
local function apply_diagnostic_config()
    vim.diagnostic.config({
        update_in_insert = diagnostics_state.update_in_insert,
        severity_sort = true,
        virtual_text = diagnostics_state.virtual_text and {
            spacing = 4,
            prefix = '●',
            severity = {
                min = vim.diagnostic.severity.HINT,
            },
        } or false,
        signs = diagnostics_state.signs and {
            text = {
                [vim.diagnostic.severity.ERROR] = "󰅙",
                [vim.diagnostic.severity.WARN]  = "󰀩",
                [vim.diagnostic.severity.HINT]  = "󰋼",
                [vim.diagnostic.severity.INFO]  = "󰌵",
            },
            numhl = {
                [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            },
        } or false,
        underline = diagnostics_state.underline,
        float = {
            border = "rounded",
            source = "always",
            header = "",
            prefix = function(diagnostic, i, total)
                local severity = diagnostic.severity
                local prefix_map = {
                    [vim.diagnostic.severity.ERROR] = "[E] ",
                    [vim.diagnostic.severity.WARN] = "[W] ",
                    [vim.diagnostic.severity.HINT] = "[H] ",
                    [vim.diagnostic.severity.INFO] = "[I] ",
                }
                return i .. ". " .. (prefix_map[severity] or ""),
                    "DiagnosticFloating" .. vim.diagnostic.severity[severity]
            end,
        },
    })

    if not diagnostics_state.enabled then
        vim.diagnostic.disable()
    else
        vim.diagnostic.enable()
    end
end

-- Initialize configuration
apply_diagnostic_config()

-- Auto-show diagnostics ONLY in Normal mode
local function setup_auto_popup()
    -- Clear ALL autocmds in the group
    vim.api.nvim_clear_autocmds({ group = diagnostic_group, event = "CursorHold" })

    if diagnostics_state.auto_popup and diagnostics_state.enabled then
        vim.api.nvim_create_autocmd("CursorHold", {
            group = diagnostic_group,
            pattern = "*",
            callback = function()
                local mode = vim.api.nvim_get_mode().mode
                -- Don't open if ANY floating window is already open
                if mode == 'n' then
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        if vim.api.nvim_win_get_config(win).relative ~= "" then
                            return -- A floating window is open, don't interfere
                        end
                    end
                    
                    vim.diagnostic.open_float(nil, {
                        focus = false,
                        scope = "cursor",
                        border = "rounded",
                    })
                end
            end,
        })
    end
end

setup_auto_popup()

-- Reduce delay for cursor hold
vim.opt.updatetime = 300

-- Toggle functions
local function toggle_diagnostics()
    diagnostics_state.enabled = not diagnostics_state.enabled
    apply_diagnostic_config()
    setup_auto_popup()
    vim.notify('Diagnostics: ' .. (diagnostics_state.enabled and 'enabled' or 'disabled'), vim.log.levels.INFO)
end

local function toggle_virtual_text()
    diagnostics_state.virtual_text = not diagnostics_state.virtual_text
    apply_diagnostic_config()
    vim.notify('Virtual text: ' .. (diagnostics_state.virtual_text and 'enabled' or 'disabled'), vim.log.levels.INFO)
end

local function toggle_signs()
    diagnostics_state.signs = not diagnostics_state.signs
    apply_diagnostic_config()
    vim.notify('Diagnostic signs: ' .. (diagnostics_state.signs and 'enabled' or 'disabled'), vim.log.levels.INFO)
end

local function toggle_underline()
    diagnostics_state.underline = not diagnostics_state.underline
    apply_diagnostic_config()
    vim.notify('Diagnostic underline: ' .. (diagnostics_state.underline and 'enabled' or 'disabled'), vim.log.levels.INFO)
end

local function toggle_auto_popup()
    diagnostics_state.auto_popup = not diagnostics_state.auto_popup
    setup_auto_popup()
    vim.notify('Auto popup: ' .. (diagnostics_state.auto_popup and 'enabled' or 'disabled'), vim.log.levels.INFO)
end

local function toggle_update_in_insert()
    diagnostics_state.update_in_insert = not diagnostics_state.update_in_insert
    apply_diagnostic_config()
    vim.notify('Update in insert: ' .. (diagnostics_state.update_in_insert and 'enabled' or 'disabled'), vim.log.levels.INFO)
end

-- Cycle through diagnostic modes
local diagnostic_modes = {
    { name = "Full",    enabled = true,  virtual_text = false, signs = true,  underline = true,  auto_popup = false },
    { name = "Minimal", enabled = true,  virtual_text = false, signs = true,  underline = false, auto_popup = false },
    { name = "Silent",  enabled = true,  virtual_text = false, signs = false, underline = false, auto_popup = false },
    { name = "Off",     enabled = false, virtual_text = false, signs = false, underline = false, auto_popup = false },
}
local current_mode = 1

local function cycle_diagnostic_mode()
    current_mode = (current_mode % #diagnostic_modes) + 1
    local mode = diagnostic_modes[current_mode]

    diagnostics_state.enabled = mode.enabled
    diagnostics_state.virtual_text = mode.virtual_text
    diagnostics_state.signs = mode.signs
    diagnostics_state.underline = mode.underline
    diagnostics_state.auto_popup = mode.auto_popup

    apply_diagnostic_config()
    setup_auto_popup()
    vim.notify('Diagnostic mode: ' .. mode.name, vim.log.levels.INFO)
end

-- Manual diagnostic popup
local function show_diagnostic_popup()
    vim.diagnostic.open_float(nil, {
        focus = false,
        scope = "cursor",
        border = "rounded",
    })
end

-- Create user commands
vim.api.nvim_create_user_command('ToggleDiagnostics', toggle_diagnostics, { desc = 'Toggle all diagnostics' })
vim.api.nvim_create_user_command('ToggleVirtualText', toggle_virtual_text, { desc = 'Toggle diagnostic virtual text' })
vim.api.nvim_create_user_command('ToggleSigns', toggle_signs, { desc = 'Toggle diagnostic signs' })
vim.api.nvim_create_user_command('ToggleUnderline', toggle_underline, { desc = 'Toggle diagnostic underline' })
vim.api.nvim_create_user_command('ToggleAutoPopup', toggle_auto_popup, { desc = 'Toggle auto diagnostic popup' })
vim.api.nvim_create_user_command('ToggleUpdateInInsert', toggle_update_in_insert, { desc = 'Toggle update in insert mode' })
vim.api.nvim_create_user_command('CycleDiagnosticMode', cycle_diagnostic_mode, { desc = 'Cycle through diagnostic modes' })
vim.api.nvim_create_user_command('ShowDiagnostic', show_diagnostic_popup, { desc = 'Show diagnostic popup' })

-- Diagnostics Toggles
vim.keymap.set('n', '<leader>udt', toggle_diagnostics, { desc = 'Toggle All Diagnostics' })
vim.keymap.set('n', '<leader>udm', cycle_diagnostic_mode, { desc = 'Cycle Diagnostic Mode' })
vim.keymap.set('n', '<leader>udv', toggle_virtual_text, { desc = 'Toggle Virtual Text' })
vim.keymap.set('n', '<leader>uds', toggle_signs, { desc = 'Toggle Signs' })
vim.keymap.set('n', '<leader>udu', toggle_underline, { desc = 'Toggle Underline' })
vim.keymap.set('n', '<leader>udp', toggle_auto_popup, { desc = 'Toggle Auto Popup' })
vim.keymap.set('n', '<leader>udi', toggle_update_in_insert, { desc = 'Toggle Update in Insert' })
vim.keymap.set('n', '<leader>udS', show_diagnostic_popup, { desc = 'Show Diagnostic' })
vim.keymap.set('n', 'gl', show_diagnostic_popup, { desc = 'Show Line Diagnostic' })

-- Diagnostic count in statusline
vim.api.nvim_create_autocmd({ "DiagnosticChanged", "BufEnter" }, {
    group = diagnostic_group,
    pattern = "*",
    callback = function()
        local diagnostics = vim.diagnostic.get(0)
        local count = { error = 0, warn = 0, info = 0, hint = 0 }
        for _, diagnostic in ipairs(diagnostics) do
            if diagnostic.severity == vim.diagnostic.severity.ERROR then
                count.error = count.error + 1
            elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                count.warn = count.warn + 1
            elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                count.info = count.info + 1
            elseif diagnostic.severity == vim.diagnostic.severity.HINT then
                count.hint = count.hint + 1
            end
        end
        vim.b.diagnostic_count = count
    end,
})

-- REMOVED the problematic LspAttach autocmd entirely
-- LSP diagnostics update automatically, no manual triggering needed
