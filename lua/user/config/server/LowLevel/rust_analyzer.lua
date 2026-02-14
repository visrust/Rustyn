-- 1. Define the server configuration manually
vim.lsp.config('rust_analyzer', {
  -- The command to launch the server
  cmd = { 'rust-analyzer' },
  -- Tell Neovim which files this server handles
  filetypes = { 'rust' },
  -- Logic to find the project root (looks for Cargo.toml)
  root_marker = 'Cargo.toml',
  -- Standard rust-analyzer settings
  settings = {
    ['rust-analyzer'] = {
      check = { command = "clippy" },
      cargo = { allFeatures = true },
      procMacro = { enable = true },
    },
  },
})

-- 2. Start/Enable the server
vim.lsp.enable('rust_analyzer')

-- 3. Basic Keymaps (Native)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    
    -- Optional: Enable Inlay Hints if you like them
    vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
  end,
})
