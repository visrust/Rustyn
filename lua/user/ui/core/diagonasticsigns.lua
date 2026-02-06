--------------------------------------------------------------------------------
-- DYNAMIC STEALTH ECHO: Final "No-Confirm" Version
--------------------------------------------------------------------------------


-- Define the icons you want to see in the gutter
local icons = { Error = ' ', Warn = ' ', Hint = '󰌶 ', Info = ' ' }


-- 2. The Logic
local echo_timer = vim.loop.new_timer()

local function dynamic_stealth_echo()
    if not vim.api.nvim_buf_is_valid(0) then return end

    local line = vim.api.nvim_win_get_cursor(0)[1] - 1
    local diags = vim.diagnostic.get(0, { lnum = line })

    if #diags == 0 then
        if vim.o.cmdheight ~= 1 then
            vim.o.cmdheight = 1
            vim.cmd.redraw()
        end
        vim.api.nvim_echo({}, false, {})
        return
    end

    table.sort(diags, function(a, b) return a.severity < b.severity end)
    local d = diags[1]
    local severity_map = { [1] = 'Error', [2] = 'Warn', [3] = 'Info', [4] = 'Hint' }
    local hl = 'Diagnostic' .. severity_map[d.severity]
    local icon = icons[severity_map[d.severity]]


    -- 1. Get the message
    local raw_msg = d.message

    -- 2. Replace newlines with spaces
    raw_msg = raw_msg:gsub('\n', ' ')

    -- 3. THE FIX: Collapse multiple spaces/tabs into a single space
    -- %s+ matches one or more whitespace characters
    raw_msg = raw_msg:gsub('%s%s+', ' ')

    -- 4. Trim leading/trailing whitespace just in case
    raw_msg = vim.trim(raw_msg)

    -- 5. Build final message
    local full_msg = icon .. '  ' .. raw_msg
    local screen_width = vim.o.columns
    local message_len = #full_msg

    -- Logic Chain:
    -- We use a 10-character buffer to be absolutely safe from the hit-enter prompt
    local target_height = 1
    if message_len >= (screen_width - 10) then
        target_height = 2
    end

    -- Update UI
    if vim.o.cmdheight ~= target_height then
        vim.o.cmdheight = target_height
        -- Crucial: Redraw right now so the echo doesn't collide with the resize
        vim.cmd.redraw()
    end

    -- Cap the message to the available space of the target height
    local max_cap = (screen_width * target_height) - 15
    if message_len > max_cap then
        full_msg = full_msg:sub(1, max_cap) .. '...'
    end

    vim.api.nvim_echo({ { full_msg, hl } }, false, {})
end

local safe_echo = vim.schedule_wrap(dynamic_stealth_echo)

vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
    callback = function()
        echo_timer:stop()
        echo_timer:start(20, 0, safe_echo)
    end,
})

-- 3. The "Silence" Settings
-- 'F' hides the "Hit ENTER" for messages that don't fit
-- 'W' hides "written" messages
-- 'c' hides completion messages
vim.opt.shortmess:append('AFWc')

vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.Error,
            [vim.diagnostic.severity.WARN]  = icons.Warn,
            [vim.diagnostic.severity.INFO]  = icons.Info,
            [vim.diagnostic.severity.HINT]  = icons.Hint,
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticLineError',
            [vim.diagnostic.severity.WARN]  = 'DiagnosticLineWarn',
            [vim.diagnostic.severity.INFO]  = 'DiagnosticLineInfo',
            [vim.diagnostic.severity.HINT]  = 'DiagnosticLineHint',
        },
    },
    severity_sort = true,
    update_in_insert = false,
})

-- Make unnecessary code use Warn color but NO underline
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { link = "DiagnosticWarn" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineUnnecessary", { 
    fg = "NONE",
    bg = "NONE",
    sp = "NONE",
    undercurl = false,
    underline = false,
})
