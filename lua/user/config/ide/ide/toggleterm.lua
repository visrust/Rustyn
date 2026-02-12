-- Core
require('toggleterm').setup({
    size = function(term)
        if term.direction == 'horizontal' then
            return 15
        elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
        end
    end,

    open_mapping = [[<c-\>]], -- universal toggle
    hide_numbers = true,
    -- shade_terminals = true,
    -- shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,

    direction = 'float', -- default direction
    close_on_exit = true,

    float_opts = {
        border = 'rounded',
        width = function()
            return math.floor(vim.o.columns * 0.85)
        end,
        height = function()
            return math.floor(vim.o.lines * 0.85)
        end,
        winblend = 0,
    },
})

-- Term maps
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }

    -- Close terminal
    vim.keymap.set('t', '<S-Tab>', [[<C-\><C-n>]], opts)

    vim.keymap.set('t', '<M-q>', function()
        vim.cmd('close')
    end, { buffer = 0, desc = 'Close terminal window' })

    -- Window navigation
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Float term
local Terminal = require('toggleterm.terminal').Terminal

local float_term = Terminal:new({
    direction = 'float',
    hidden = true,
})

vim.keymap.set('n', '<leader>tf', function()
    float_term:toggle()
end, { desc = 'Toggle floating terminal' })


-- Horizontal term
local hterm = Terminal:new({
    direction = 'horizontal',
    hidden = true,
})

vim.keymap.set('n', '<leader>th', function()
    hterm:toggle()
end, { desc = 'Toggle horizontal terminal' })

local vterm = Terminal:new({
    direction = 'vertical',
    hidden = true,
})

vim.keymap.set('n', '<leader>tv', function()
    vterm:toggle()
end, { desc = 'Toggle vertical terminal' })


vim.keymap.set('n', '<leader>tn', function()
    require('toggleterm').toggle(0)
end, { desc = 'New terminal' })
