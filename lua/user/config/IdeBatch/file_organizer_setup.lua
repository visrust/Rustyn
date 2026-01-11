-- File Organizer Setup
-- Save file_organizer.lua to: ~/.config/nvim/lua/file_organizer.lua
-- Then add this to your config

local file_organizer = require('user.config.IdeBatch.file_organizer')

-- Configure display mode (default: 'float')
-- Options: 'float', 'vsplit', 'hsplit', 'full'
file_organizer.config.display_mode = 'float'

-- Customize float window (optional)
file_organizer.config.float_opts = {
    relative = 'editor',
    width = 0.8,        -- 80% of screen width
    height = 0.8,       -- 80% of screen height
    border = 'rounded', -- 'single', 'double', 'rounded', 'solid', 'shadow'
    title = ' 📂 File Organizer ',
    title_pos = 'center',
}

-- Keybindings
vim.keymap.set('n', '<leader>ao', file_organizer.open,
    { desc = 'Open file organizer' })
vim.keymap.set('n', '<leader>ad', file_organizer.quick_add,
    { desc = 'Quick add current file to organizer' })

-- Open with specific modes
vim.keymap.set('n', '<leader>aof', function() file_organizer.open('float') end,
    { desc = 'Open organizer in float' })
vim.keymap.set('n', '<leader>aov', function() file_organizer.open('vsplit') end,
    { desc = 'Open organizer in vsplit' })
vim.keymap.set('n', '<leader>aoh', function() file_organizer.open('hsplit') end,
    { desc = 'Open organizer in hsplit' })
vim.keymap.set('n', '<leader>aoF', function() file_organizer.open('full') end,
    { desc = 'Open organizer fullscreen' })

-- User commands
vim.api.nvim_create_user_command('FileOrganizer', function(opts)
    file_organizer.open(opts.args ~= '' and opts.args or nil)
end, {
    nargs = '?',
    complete = function() return { 'float', 'vsplit', 'hsplit', 'full' } end,
    desc = 'Open file organizer buffer'
})

vim.api.nvim_create_user_command('FileOrganizerAdd', function(opts)
    file_organizer.quick_add(opts.args ~= '' and opts.args or nil)
end, {
    nargs = '?',
    complete = function() return { 'float', 'vsplit', 'hsplit', 'full' } end,
    desc = 'Add current file to organizer'
})

vim.api.nvim_create_user_command('FileOrganizerMode', function(opts)
    file_organizer.set_display_mode(opts.args)
end, {
    nargs = 1,
    complete = function() return { 'float', 'vsplit', 'hsplit', 'full' } end,
    desc = 'Set display mode (float|vsplit|hsplit|full)'
})

-- Auto-commands for better UX
vim.api.nvim_create_autocmd('BufLeave', {
    pattern = 'file-organizer://*',
    callback = function()
        vim.notify('Press :w to save changes', vim.log.levels.INFO)
    end,
})

-- USAGE GUIDE:
--
-- DISPLAY MODES:
-- - <leader>ao   : Open with default mode (float)
-- - <leader>aof  : Open in floating window
-- - <leader>aov  : Open in vertical split
-- - <leader>aoh  : Open in horizontal split
-- - <leader>aoF  : Open fullscreen
--
-- COMMANDS:
-- - :FileOrganizer [mode]     : Open organizer
-- - :FileOrganizerAdd [mode]  : Add current file
-- - :FileOrganizerMode float  : Change default mode
--
-- WORKFLOW:
-- 1. Press <leader>ad on any file to copy it
-- 2. Opens the organizer buffer (default: float)
-- 3. Edit like a text file:
--
--    MyProject/
--      ~/code/app.js
--      ~/code/api.py
--
--    Documentation/
--      ~/docs/README.md
--
-- 4. Press :w to save
-- 5. Prompt appears: "Save changes? y/n"
-- 6. If new folders detected: "Create folders: MyProject? Y/N"
-- 7. Press Y to confirm
--
-- KEYBINDINGS IN ORGANIZER:
-- - p        : Paste copied file
-- - <CR>     : Open file under cursor
-- - dd       : Delete line (normal vim)
-- - yy       : Yank file path to clipboard
-- - R        : Refresh buffer
-- - q/Esc    : Close (float mode only)
-- - :w       : Save (with confirmation prompt)
--
-- Data stored in: ~/.local/share/nvim/file_organizer/folders.json
