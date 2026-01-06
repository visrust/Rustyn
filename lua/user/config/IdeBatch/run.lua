local ok, toggleterm = pcall(require, "toggleterm.terminal")
if not ok then
    return
end

local function run_filetype_command()
    local ft = vim.bo.filetype
    local cwd = vim.fn.getcwd()
    local filename = vim.fn.expand("%")
    local cmd = ""

    if ft == "rust" then
        cmd = "cd " .. cwd .. " && cargo run"
    elseif ft == "python" then
        cmd = "cd " .. cwd .. " && python3 " .. filename
    elseif ft == "lua" then
        cmd = "cd " .. cwd .. " && lua " .. filename
    elseif ft == "c" then
        cmd = "cd " ..
            cwd .. " && gcc " .. filename .. " -o " .. vim.fn.expand("%:r") .. " && ./" .. vim.fn.expand("%:r")
    elseif ft == "cpp" then
        cmd = "cd " ..
            cwd .. " && g++ " .. filename .. " -o " .. vim.fn.expand("%:r") .. " && ./" .. vim.fn.expand("%:r")
    elseif ft == "java" then
        cmd = "cd " .. cwd .. " && javac " .. filename .. " && java " .. vim.fn.expand("%:r")
    elseif ft == "go" then
        cmd = "cd " .. cwd .. " && go run " .. filename
    elseif ft == "javascript" then
        cmd = "cd " .. cwd .. " && node " .. filename
    elseif ft == "typescript" then
        cmd = "cd " .. cwd .. " && ts-node " .. filename
    elseif ft == "bash" or ft == "sh" then
        cmd = "cd " .. cwd .. " && bash " .. filename
    elseif ft == "ruby" then
        cmd = "cd " .. cwd .. " && ruby " .. filename
    elseif ft == "php" then
        cmd = "cd " .. cwd .. " && php " .. filename
    elseif ft == "kotlin" then
        cmd = "cd " ..
            cwd ..
            " && kotlinc " ..
            filename ..
            " -include-runtime -d " .. vim.fn.expand("%:r") .. ".jar && java -jar " .. vim.fn.expand("%:r") .. ".jar"
    elseif ft == "dart" then
        cmd = "cd " .. cwd .. " && dart run " .. filename
    elseif ft == "scala" then
        cmd = "cd " .. cwd .. " && scalac " .. filename .. " && scala " .. vim.fn.expand("%:r")
    elseif ft == "r" then
        cmd = "cd " .. cwd .. " && Rscript " .. filename
    elseif ft == "perl" then
        cmd = "cd " .. cwd .. " && perl " .. filename
    elseif ft == "haskell" then
        cmd = "cd " .. cwd .. " && runhaskell " .. filename
    else
        print("No command configured for filetype: " .. ft)
        return
    end

    -- Load ToggleTerm lazily
    local Terminal = require("toggleterm.terminal").Terminal
    local term = Terminal:new({
        cmd = cmd,
        hidden = true,
        direction = "float",
        close_on_exit = false, -- keeps terminal open
    })
    term:toggle()
end

vim.keymap.set("n", "<leader>zz", run_filetype_command, { noremap = true, silent = true })
