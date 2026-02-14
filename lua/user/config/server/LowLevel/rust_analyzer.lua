local lspconfig = require("lspconfig")
-- Note this has been intentionally optimized for termux

lspconfig.rust_analyzer.setup({
    flags = {
        debounce_text_changes = 300,
    },
    settings = {
        ["rust-analyzer"] = {
            -- IMPORTANT: avoid Cargo path mismatches
            checkOnSave = {
                enable = true,
                command = "clippy", -- Set to check use clippy instead
            },

            -- rustc = {
            --     source = "none",
            -- },

            cargo = {
                allFeatures = false,
                buildScripts = {
                    enable = true,
                },
            },

            procMacro = {
                enable = true, -- For termux optimization
            },

            files = {
                excludeDirs = {
                    ".git",
                    "target",
                    "node_modules",
                },
            },

            diagnostics = {
                enable = true,
                experimental = {
                    enable = false,
                },
            },
        },
    },
})

vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
    return vim.NIL
end
