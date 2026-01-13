require('telescope').setup({
    defaults = {
        -- Layout
        layout_strategy = 'flex',
        layout_config = {
            horizontal = {
                preview_width = 0.55,
                -- results_width is NOT a valid option - removed
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
                prompt_position = "bottom",
            },
            vertical = {
                mirror = false,
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
                prompt_position = "bottom",
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
            flex = {
                flip_columns = 120,
            },
        },

        -- Sorting & matching - BETTER SCORING FOR SNAPPIER RESULTS
        sorting_strategy = "ascending",
        selection_strategy = "reset",
        
        -- IMPROVED: Better matching algorithm
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
        
        file_ignore_patterns = {
            "node_modules/",
            ".git/",
            "dist/",
            "build/",
            "%.lock",
            "target/",
        },

        -- UI - minimal and clean
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        multi_icon = "󰄵 ",
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },

        -- Performance - IMPROVED
        path_display = { "truncate" }, -- Better than absolute for performance
        dynamic_preview_title = true,
        results_title = false,
        
        -- CRITICAL: Cache for better performance
        cache_picker = {
            num_pickers = 10,
        },

        -- Behavior
        wrap_results = false,
        scroll_strategy = "cycle",

        -- Better previewer
        preview = {
            treesitter = true,
        },

        -- IMPROVED: Better ripgrep arguments for matching
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden", -- Search hidden files by default
            "--glob=!.git/", -- But exclude .git
        },

        -- Fast mappings
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
                ["<C-n>"] = "move_selection_next",
                ["<C-p>"] = "move_selection_previous",

                ["<C-q>"] = "close",
                ["<esc>"] = "close",

                ["<CR>"] = "select_default",
                ["<C-x>"] = "select_horizontal",
                ["<C-v>"] = "select_vertical",
                ["<C-t>"] = "select_tab",

                ["<C-u>"] = "preview_scrolling_up",
                ["<C-d>"] = "preview_scrolling_down",

                ["<C-s>"] = "toggle_selection",
                ["<C-a>"] = "toggle_all",

                ["<C-c>"] = "close",
            },
            n = {
                ["<C-q>"] = "close",
                ["q"] = "close",

                ["<CR>"] = "select_default",
                ["x"] = "select_horizontal",
                ["v"] = "select_vertical",
                ["t"] = "select_tab",

                ["j"] = "move_selection_next",
                ["k"] = "move_selection_previous",

                ["<C-u>"] = "preview_scrolling_up",
                ["<C-d>"] = "preview_scrolling_down",

                ["s"] = "toggle_selection",
                ["a"] = "toggle_all",
            },
        },
    },

    pickers = {
        -- File pickers - IMPROVED MATCHING
        find_files = {
            hidden = true,
            find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
            path_display = { "smart" }, -- Smart truncation
            -- BETTER: More relevant results first
            file_ignore_patterns = { "%.git/", "node_modules/" },
        },

        oldfiles = {
            prompt_title = "Recent Files",
            cwd_only = true,
            path_display = { "smart" },
            only_cwd = true, -- Only files from current working directory
        },

        -- Search pickers - OPTIMIZED
        live_grep = {
            additional_args = function()
                return { "--hidden", "--glob", "!.git/*" }
            end,
            path_display = { "smart" },
            -- IMPROVED: Show results as you type
            disable_coordinates = false,
        },

        grep_string = {
            additional_args = function()
                return { "--hidden", "--glob", "!.git/*" }
            end,
            path_display = { "smart" },
        },

        -- Buffer picker - IMPROVED SORTING
        buffers = {
            sort_lastused = true,
            sort_mru = true,
            show_all_buffers = true,
            ignore_current_buffer = false,
            path_display = { "smart" },
            mappings = {
                i = {
                    ["<c-d>"] = "delete_buffer",
                },
                n = {
                    ["d"] = "delete_buffer",
                },
            },
        },

        -- LSP pickers
        lsp_references = {
            show_line = false,
            path_display = { "smart" },
            fname_width = 50, -- Better visibility
        },

        lsp_definitions = {
            path_display = { "smart" },
        },

        lsp_document_symbols = {
            symbol_width = 50,
        },

        -- Git pickers
        git_files = {
            show_untracked = true,
            path_display = { "smart" },
        },

        git_status = {
            path_display = { "smart" },
            git_icons = {
                added = " ",
                changed = " ",
                copied = " ",
                deleted = " ",
                renamed = "➡",
                unmerged = " ",
                untracked = " ",
            },
        },

        colorscheme = {
            enable_preview = true,
        },

        help_tags = {
            mappings = {
                i = {
                    ["<CR>"] = "select_default",
                },
            },
        },
    },

    extensions = {
        -- FZF EXTENSION: This is KEY for better matching!
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },

        file_browser = {
            theme = "ivy",
            hijack_netrw = true,
            hidden = true,
            grouped = true,
            previewer = true,
            initial_mode = "normal",
            path_display = { "smart" },
            mappings = {
                ["i"] = {
                    ["<C-n>"] = require("telescope._extensions.file_browser.actions").create,
                    ["<C-r>"] = require("telescope._extensions.file_browser.actions").rename,
                    ["<C-d>"] = require("telescope._extensions.file_browser.actions").remove,
                    ["<C-h>"] = require("telescope._extensions.file_browser.actions").toggle_hidden,
                },
                ["n"] = {
                    ["c"] = require("telescope._extensions.file_browser.actions").create,
                    ["d"] = require("telescope._extensions.file_browser.actions").remove,
                    ["h"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
                    ["l"] = "select_default",
                    ["."] = require("telescope._extensions.file_browser.actions").toggle_hidden,
                    ["/"] = function()
                        vim.cmd('startinsert')
                    end,
                },
            },
        },
    },
})

-- Load extensions
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
