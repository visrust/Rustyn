-- ============================================================================
-- Nvim-treesitter Configuration for 'main' branch
-- Installation: { "nvim-treesitter/nvim-treesitter", branch = 'main', build = ":TSUpdate" }
-- ============================================================================

require('nvim-treesitter.configs').setup({
    -- ============================================================================
    -- PARSER INSTALLATION MANAGEMENT
    -- ============================================================================

    -- List of parser names, or "all" (parsers listed here MUST always be installed)
    ensure_installed = {
        "c", "lua", "vim", "vimdoc", "query",
        "markdown", "markdown_inline",
        "python", "javascript", "typescript", "tsx",
        "rust", "go", "bash", "json", "yaml", "toml",
        "html", "css", "regex"
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    ignore_install = {},

    -- Custom parser installation directory (optional)
    -- parser_install_dir = "/some/path/to/store/parsers",

    -- ============================================================================
    -- HIGHLIGHTING MODULE
    -- ============================================================================

    highlight = {
        enable = true,

        -- Disable for large files
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        -- Keep false to prevent conflicts
        additional_vim_regex_highlighting = false,
    },

    -- ============================================================================
    -- INCREMENTAL SELECTION - Smart nvim motions
    -- ============================================================================

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },

    -- ============================================================================
    -- INDENTATION MODULE
    -- ============================================================================

    indent = {
        enable = true,
        disable = {},
    },

    -- ============================================================================
    -- TEXT OBJECTS (requires nvim-treesitter-textobjects plugin)
    -- ============================================================================

    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
            },
        },

        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
                ["]a"] = "@parameter.inner",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
                ["]A"] = "@parameter.inner",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
                ["[a"] = "@parameter.inner",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
                ["[A"] = "@parameter.inner",
            },
        },

        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },

    fold = { enable = true },
})

-- ============================================================================
-- FOLDING SETUP
-- ============================================================================
-- -- Add these after the treesitter setup
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.opt.foldlevelstart = 99
-- vim.opt.foldenable = true

-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 99
-- vim.opt.foldenable = true
--
-- --
-- -- Lua config
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 99
-- vim.opt.foldenable = true

-- ============================================================================
-- REMOVE ONLY UNDERLINES AND INDENT GUIDES (KEEP ALL COLORS)
-- ============================================================================

-- local function remove_visual_clutter()
--     -- Get all treesitter highlight groups
--     local hl_groups = {
--         -- Functions
--         '@function', '@function.call', '@function.builtin', '@function.macro',
--         '@method', '@method.call',
--         -- Variables
--         '@variable', '@variable.builtin', '@variable.parameter', '@variable.member',
--         '@parameter',
--         -- Types
--         '@type', '@type.builtin', '@type.definition',
--         '@property', '@field',
--         -- Keywords and constants
--         '@keyword', '@keyword.function', '@keyword.operator', '@keyword.return',
--         '@constant', '@constant.builtin',
--         -- Strings and numbers
--         '@string', '@string.escape', '@string.special',
--         '@number', '@boolean', '@float',
--         -- Operators and punctuation
--         '@operator', '@punctuation', '@punctuation.bracket', '@punctuation.delimiter',
--         -- Comments
--         '@comment', '@comment.documentation',
--         -- All other common captures
--         '@constructor', '@label', '@namespace', '@attribute',
--     }
--
--     for _, group in ipairs(hl_groups) do
--         -- Get existing highlight definition
--         local hl = vim.api.nvim_get_hl(0, { name = group })
--
--         -- Only modify if the group exists and has properties
--         if next(hl) ~= nil then
--             -- Keep all existing properties (fg, bg, bold, italic, etc.)
--             -- but explicitly remove underline and undercurl
--             hl.underline = false
--             hl.undercurl = false
--             hl.underdouble = false
--             hl.underdotted = false
--             hl.underdashed = false
--
--             -- Reapply the highlight with underlines removed
--             vim.api.nvim_set_hl(0, group, hl)
--         end
--     end
--
--     -- Clear indent line highlighting (doesn't affect text colors)
--     vim.api.nvim_set_hl(0, '@indent', {})
--     vim.api.nvim_set_hl(0, '@whitespace', {})
--     vim.api.nvim_set_hl(0, 'IndentBlanklineChar', {})
--     vim.api.nvim_set_hl(0, 'IndentBlanklineSpaceChar', {})
--     vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', {})
--     vim.api.nvim_set_hl(0, 'IblIndent', {})
--     vim.api.nvim_set_hl(0, 'IblScope', {})
--
--     -- === REMOVE RECTANGULAR SCOPE/CONTEXT BOXES ===
--     -- These create the blue boxes around code blocks
--     vim.api.nvim_set_hl(0, 'TreesitterContext', {})
--     vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', {})
--     vim.api.nvim_set_hl(0, 'TreesitterContextBottom', {})
--     vim.api.nvim_set_hl(0, 'TreesitterContextSeparator', {})
--
--     -- Clear scope highlights that create rectangular boxes
--     vim.api.nvim_set_hl(0, '@local.scope', {})
--     vim.api.nvim_set_hl(0, '@scope', {})
--
--     -- Clear any cursor column/line highlights that might show blocks
--     vim.api.nvim_set_hl(0, 'CursorColumn', {})
--     vim.api.nvim_set_hl(0, 'ColorColumn', {})
--
--     -- Clear matchparen and bracket matching highlights
--     vim.api.nvim_set_hl(0, 'MatchParen', { bold = true }) -- Keep bold but no box
-- end
--
-- -- Apply immediately and on colorscheme changes
-- vim.api.nvim_create_autocmd({ 'VimEnter', 'ColorScheme' }, {
--     callback = remove_visual_clutter,
-- })
--
-- remove_visual_clutter()
--
-- -- Disable nvim-treesitter-context plugin if installed (creates sticky context at top)
-- vim.g.treesitter_context_enabled = false
--
-- -- Disable LSP semantic tokens that might add underlines (but keep LSP colors)
-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(args)
--         local client = vim.lsp.get_client_by_id(args.data.client_id)
--         if client then
--             -- Only disable semantic tokens to prevent underlines
--             -- LSP will still provide diagnostics and other features
--             client.server_capabilities.semanticTokensProvider = nil
--         end
--     end,
-- })
--
-- -- ============================================================================
-- -- USEFUL COMMANDS
-- -- ============================================================================
--
-- --[[
-- Parser Management:
--   :TSInstall <language>        - Install a parser
--   :TSInstallInfo              - Show installation info
--   :TSUpdate [language]        - Update parser(s)
--   :TSUninstall <language>     - Uninstall a parser
--
-- Module Control:
--   :TSBufEnable <module>       - Enable module on current buffer
--   :TSBufDisable <module>      - Disable module on current buffer
--   :TSEnable <module> [ft]     - Enable module globally
--   :TSDisable <module> [ft]    - Disable module globally
--   :TSModuleInfo [module]      - Show module state
--
-- Diagnostics:
--   :checkhealth nvim-treesitter - Check treesitter health
--
-- View Highlights:
--   :Inspect                    - Show highlight groups under cursor
--   :InspectTree                - Show treesitter syntax tree
-- ]]

