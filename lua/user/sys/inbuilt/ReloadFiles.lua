-- best if you want a reload files after coming back to see what had changed externally
--

-- turn on auto read 
vim.opt.autoread = true

-- check time explicitly
vim.keymap.set('n', '<leader>cr', ':checktime<CR>', { desc = "Check file changes" })


