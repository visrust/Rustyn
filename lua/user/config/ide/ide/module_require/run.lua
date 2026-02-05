local status_ok, toggleterm = pcall(require, 'toggleterm.terminal')
if not status_ok then
    vim.notify('toggleterm not found, falling back to FloatingTerminal', vim.log.levels.WARN)
end

local Terminal = status_ok and require('toggleterm.terminal').Terminal or nil

-- Fallback to FloatingTerminal if toggleterm is not available
local FloatingTerminal = require('user.config.ide.ide.local_module.dustTerm_module')

local RUNNER_ID = 'code_runner'
local runner_term = nil

local function run_filetype_command()
    local ft = vim.bo.filetype
    local file_dir = vim.fn.expand('%:p:h') -- Directory of current file
    local file_name = vim.fn.expand('%:t')  -- Just the filename
    local root = vim.fn.expand('%:t:r')     -- Filename without extension

    local cmd = nil

    if ft == 'rust' then
        cmd = 'cargo run'
    elseif ft == 'zig' then
        -- Smart Zig runner: detects if you're in a project or standalone file
        local build_file = vim.fn.findfile('build.zig', '.;')
        if build_file ~= '' then
            cmd = 'zig build run'         -- Project with build.zig
        else
            cmd = 'zig run ' .. file_name -- Standalone file
        end
    elseif ft == 'python' then
        cmd = 'python3 ' .. file_name
    elseif ft == 'lua' then
        cmd = 'lua ' .. file_name
    elseif ft == 'c' then
        cmd = 'gcc ' .. file_name .. ' -o ' .. root .. ' && ./' .. root
    elseif ft == 'cpp' then
        cmd = 'g++ ' .. file_name .. ' -o ' .. root .. ' && ./' .. root
    elseif ft == 'go' then
        cmd = 'go run ' .. file_name
    elseif ft == 'java' then
        cmd = 'javac ' .. file_name .. ' && java ' .. root
    elseif ft == 'javascript' then
        cmd = 'node ' .. file_name
    elseif ft == 'typescript' then
        cmd = 'ts-node ' .. file_name
    elseif ft == 'bash' or ft == 'sh' then
        cmd = 'bash ' .. file_name
    elseif ft == 'ruby' then
        cmd = 'ruby ' .. file_name
    elseif ft == 'php' then
        cmd = 'php ' .. file_name
    else
        vim.notify('No runner for filetype: ' .. ft, vim.log.levels.WARN)
        return
    end

    vim.schedule(function()
        if Terminal then
            -- Create runner terminal if it doesn't exist
            if not runner_term then
                runner_term = Terminal:new({
                    cmd = vim.o.shell,
                    hidden = true,
                    direction = 'float',
                    float_opts = {
                        border = 'curved',
                        width = math.floor(vim.o.columns * 0.9),
                        height = math.floor(vim.o.lines * 0.9),
                    },
                    on_open = function(term)
                        vim.cmd('startinsert!')
                        vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-\\>', '<cmd>close<CR>',
                            { noremap = true, silent = true })
                        vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<leader>xz', '<cmd>close<CR>',
                            { noremap = true, silent = true })
                    end,
                    on_close = function()
                        vim.cmd('startinsert!')
                    end,
                })
            end

            -- Using toggleterm
            if not runner_term:is_open() then
                runner_term:open()
            end

            -- Send commands to toggleterm
            runner_term:send('cd ' .. vim.fn.shellescape(file_dir))
            runner_term:send('clear')
            runner_term:send(cmd)
        else
            -- Fallback to FloatingTerminal
            FloatingTerminal.send('cd ' .. file_dir, RUNNER_ID)
            FloatingTerminal.send('clear', RUNNER_ID)
            FloatingTerminal.send(cmd, RUNNER_ID)
        end
    end)
end

-- Run code
vim.keymap.set('n', '<leader>zz', run_filetype_command, { silent = true, desc = 'Run code' })

-- Toggle runner terminal
vim.keymap.set('n', '<leader>xz', function()
    if Terminal and runner_term then
        runner_term:toggle()
    else
        FloatingTerminal.toggle(RUNNER_ID, 'Code Runner')
    end
end, { silent = true, desc = 'Toggle code runner terminal' })

-- important keymaps don't delete

local term = require('user.config.ide.ide.local_module.dustTerm_module')
_G.FloatingTerminal = term

-- Default terminal toggle
vim.keymap.set({ 'n', 't' }, '<C-\\>', function()
    term.toggle('default', 'Terminal')
end, { desc = 'Toggle default terminal' })

vim.keymap.set({ 'n', 't' }, '<leader>o', function()
    term.toggle('default', 'Terminal')
end, { desc = 'Open Term' })
