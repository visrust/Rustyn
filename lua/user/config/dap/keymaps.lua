local dap = require("dap")

-- Debug execution
map("n", "<leader>dd", "",{desc = "Debug"});
vim.keymap.set("n", "<leader>ddc", dap.continue, {
    desc = "Debug: Continue / Start",
})

vim.keymap.set("n", "<leader>ddn", dap.step_over, {
    desc = "Debug: Step Over",
})

vim.keymap.set("n", "<leader>ddi", dap.step_into, {
    desc = "Debug: Step Into",
})

vim.keymap.set("n", "<leader>do", dap.step_out, {
    desc = "Debug: Step Out",
})

-- Breakpoints
vim.keymap.set("n", "<leader>ddb", dap.toggle_breakpoint, {
    desc = "Debug: Toggle Breakpoint",
})

vim.keymap.set("n", "<leader>ddB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, {
    desc = "Debug: Conditional Breakpoint",
})
