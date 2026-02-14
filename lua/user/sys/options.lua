-- UI & Display
vim.o.number = false
vim.o.relativenumber = false
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.signcolumn = "no"
vim.o.showtabline = 2
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Indentation & Formatting
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.smartindent = true
vim.o.textwidth = 0
vim.o.backspace = "indent,eol,start"

-- Search
vim.o.incsearch = true
vim.o.hlsearch = true

-- Folding (Treesitter-based)
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldnestmax = 10

-- Syntax & Filetype
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

-- Keymaps: Spelling
vim.keymap.set('n', '<leader>fw', function()
    local word = vim.fn.expand('<cword>')
    local suggestions = vim.fn.spellsuggest(word, 1)
    
    if #suggestions > 0 then
        vim.cmd('normal! ciw' .. suggestions[1])
        vim.cmd('stopinsert')
    else
        vim.notify('No spelling suggestions found', vim.log.levels.WARN)
    end
end, { desc = 'Fix spelling (first suggestion)' })

vim.keymap.set('n', '<C-x>s', 'z=', { desc = 'Spelling suggestions' })
