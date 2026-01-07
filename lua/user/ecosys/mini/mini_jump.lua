require('mini.jump2d').setup({
    spotter = nil,         -- Auto-detect best spots
    view = {
        dim = true,        -- Dim background
        n_steps_ahead = 2, -- Look ahead steps
    },
    labels = 'abcdefghijklmnopqrstuvwxyz',
    allowed_lines = {
        blank = true,
        cursor_before = true,
        cursor_at = true,
        cursor_after = true,
        fold = true,
    },
})

-- Use mini for general jumping
vim.keymap.set('n', 'm', '<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<cr>')

