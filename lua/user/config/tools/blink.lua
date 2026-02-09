-- ============================================================================
-- OPTIMIZED Blink.cmp Configuration
-- Loads core immediately, defers heavy UI setup
-- Do not try to do any changes
-- ============================================================================

-- Set highlight overrides first (cheap)
vim.api.nvim_set_hl(0, 'LspReferenceWrite', { underline = false, bg = 'NONE' })
vim.api.nvim_set_hl(0, 'LspReferenceRead', { underline = false, bg = 'NONE' })
vim.api.nvim_set_hl(0, 'LspReferenceText', { underline = false, bg = 'NONE' })

-- Setup blink.cmp with minimal config first
require('blink.cmp').setup({
    appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',

        kind_icons = {
            Text          = '󰉿',
            Method        = '󰆧',
            Function      = '󰊕',
            Constructor   = '󰆧',
            Field         = '󰜢',
            Variable      = '󰀫',
            Property      = '󰜢',
            Constant      = '󰏿',
            Class         = '󰠱',
            Struct        = '󰙅',
            Interface     = '󰕘',
            Module        = '󰕳',
            Enum          = '󰕘',
            EnumMember    = '󰆔',
            TypeParameter = '󰊄',
            Unit          = '󰑭',
            Value         = '󰎠',
            Keyword       = '󰌋',
            Operator      = '󰆕',
            Snippet       = '󰘌',
            Event         = '󰌘',
            Reference     = '󰈇',
            File          = '󰈙',
            Folder        = '󰉋',
            Color         = '󰏘',
        },
    },

    completion = {
        list = {
            max_items = 20,
        },

        accept = {
            auto_brackets = {
                enabled = false,
            },
        },

        menu = {
            enabled = true,
            min_width = 15,
            max_height = 10,
            border = 'rounded',
            scrollbar = true,
            scrolloff = 2,
            winblend = 0,

            draw = {
                padding = 1,
                gap = 1,
                treesitter = { 'lsp' },

                columns = {
                    { 'kind_icon', 'kind',              gap = 1 },
                    { 'label',     'label_description', gap = 1 },
                },
            },
            auto_show = true,
        },

        documentation = {
            auto_show = false,
            auto_show_delay_ms = 200,
            treesitter_highlighting = true,

            window = {
                min_width = 10,
                max_width = 40,
                max_height = 40,
                border = 'rounded',
                winblend = 25,
                scrollbar = true,

                direction_priority = {
                    menu_north = { 'e' },
                    menu_south = { 'e' },
                },
            },
        },

        ghost_text = {
            enabled = false,
        },
    },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    --Warn: use these mappings and do not try to play with fallback
    keymap = {
        preset = 'none',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation'},
        ['<C-e>'] = { 'hide', 'hide_documentation' },
        ['<C-k>'] = { 'show_documentation'},
        ['<CR>'] = { 'accept', 'fallback'},
        -- ['<C-n>'] = { 'select_next'},
        -- ['<C-p>'] = { 'select_prev'},
        ['<Down>'] = { 'select_next', 'fallback'},
        ['<Up>'] = { 'select_prev', 'fallback'},
        ['<Tab>'] = { 'select_next', 'fallback'},
        ['<S-Tab>'] = { 'select_prev', 'fallback'},
        ['<C-u>'] = { 'scroll_documentation_up'},
        ['<C-d>'] = { 'scroll_documentation_down'},
    },

    signature = {
        enabled = false,
    },

    cmdline = {
        enabled = true,
        sources = { 'cmdline' },

        -- Warn : Keep as it is
        keymap = {
            preset = 'super-tab',
            ['<CR>'] = { 'accept', 'fallback' },
            ['<Tab>'] = { 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
            ['<C-n>'] = { 'select_next', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback' },
        },

        completion = {
            trigger = {
                show_on_blocked_trigger_characters = {},
                show_on_x_blocked_trigger_characters = {},
            },

            list = {
                selection = {
                    preselect = true,
                    auto_insert = true,
                },
            },

            menu = {
                auto_show = true,
                draw = {
                    columns = {
                        { 'label' }
                    },
                },
            },

            ghost_text = {
                enabled = false
            },
        },
    },

    term = {
        enabled = true,
        sources = {},
        -- Warm: Intentionally set to none
        keymap = { preset = 'none' },
        completion = {
            trigger = {
                show_on_blocked_trigger_characters = {},
                show_on_x_blocked_trigger_characters = nil,
            },
            list = {
                selection = {
                    preselect = nil,
                    auto_insert = nil,
                },
            },
            menu = { auto_show = nil },
            ghost_text = { enabled = false },
        }
    }
})

-- Get capabilities (needed for LSP)
local blink_capabilities = require('blink.cmp').get_lsp_capabilities()

blink_capabilities.textDocument.completion.completionItem = {
    snippetSupport = true,
    resolveSupport = {
        properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
        }
    },
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    commitCharactersSupport = true,
    documentationFormat = { 'markdown', 'plaintext' },
    deprecatedSupport = true,
    preselectSupport = true,
}

-- Export capabilities for LSP servers to use
_G.blink_capabilities = blink_capabilities
