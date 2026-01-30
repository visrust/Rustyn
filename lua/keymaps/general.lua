map('n', '<leader>rc', '<cmd>source $MYVIMRC<cr>', { desc = 'Reload init.lua' })

-- Lazy
map("n", "<leader>lp", "<cmd>Lazy profile<cr>", {desc = "Lazy profile"})
map("n", "<leader>lu", "<cmd>Lazy update<cr>", {desc = "Lazy update"})
map("n", "<leader>ls", "<cmd>Lazy sync<cr>", {desc = "Lazy sync"})
