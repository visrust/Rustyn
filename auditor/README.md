# DustNvim Configuration Auditor

**Comprehensive documentation and duplicate detection for your DustNvim configuration**

## 🎯 What This Does

This tool suite automatically:
- ✅ **Documents** all plugins with their GitHub links
- ✅ **Extracts** every keybinding across your config
- ✅ **Detects duplicates** in plugins, functions, and keybindings
- ✅ **Maps** your LSP server configurations
- ✅ **Analyzes** configuration structure and statistics
- ✅ **Generates** professional markdown reports

## 🚀 Quick Start

### Option 1: Bash Script (Works Everywhere)

```bash
# Make executable
chmod +x audit_dustnvim.sh

# Run the audit
./audit_dustnvim.sh ~/.config/nv

# Or use current directory
./audit_dustnvim.sh
```

### Option 2: Python Script (More Powerful)

```bash
# Make executable
chmod +x audit_dustnvim.py

# Run the audit
./audit_dustnvim.py ~/.config/nv

# Or let it auto-detect
./audit_dustnvim.py
```

### Option 3: Direct Python

```bash
python3 audit_dustnvim.py ~/.config/nv
```

## 📋 What Gets Generated

After running, check `~/.config/nv/audit_reports/`:
make sure to have this folder.

```
audit_reports/
├── 00_MASTER_SUMMARY.md      ⭐ Start here!
├── 01_PLUGINS.md              Complete plugin inventory
├── 02_KEYBINDINGS.md          All keybindings documented
├── 03_DUPLICATES.md           Duplicate detection
├── 04_LSP_SERVERS.md          LSP configuration
└── 06_STRUCTURE_MAP.md        Directory structure
```

## 📊 Example Output

### Master Summary
```markdown
# DustNvim Configuration Audit

## 📊 Quick Stats
| Metric | Count |
|--------|------:|
| Unique Plugins | 65 |
| Keybindings | 142 |
| LSP Servers | 18 |

## ⚠️ Issues Found
- Duplicate Plugins: 3
- Duplicate Keybindings: 5
```

### Plugin Inventory
```markdown
## `nvim-treesitter/nvim-treesitter`
**Repository:** https://github.com/nvim-treesitter/nvim-treesitter
**Referenced in:** 
- lua/user/config/ide/treesitter.lua
```

### Duplicate Detection
```markdown
## ⚠️ Duplicate Plugin Declarations
### `folke/lazy.nvim` (2 occurrences)
- lua/user/sys/plugins.lua
- lua/user/stages/01_sys.lua
```

## 🔍 What It Detects

### Plugins
- All GitHub plugin references (`username/repo`)
- Where each plugin is declared
- Duplicate plugin declarations
- Installed vs. declared plugins

### Keybindings
- `vim.keymap.set()` patterns
- `vim.api.nvim_set_keymap()` patterns
- Leader key mappings
- Duplicate keybindings (same key, different files)

### Functions
- All `function name()` declarations
- Location (file + line number)
- Duplicate function names

### LSP Servers
- All servers by category (LowLevel, Web, etc.)
- Commands and filetypes
- Configuration file locations

## 💡 Usage Tips

1. **Start with Master Summary** - Get the overview
2. **Check Duplicates First** - Fix any conflicts
3. **Review Plugins** - Remove unused ones
4. **Audit Keybindings** - Look for conflicts
5. **Verify LSP Servers** - Ensure all are installed

## 🛠️ Requirements

### Bash Script
- bash 4.0+
- Standard Unix tools (find, grep, sed, awk)
- Optional: `tree` or `eza` for better structure maps

### Python Script
- Python 3.6+
- No external dependencies (uses stdlib only)

## 📝 Integration with DustNvim

### Add to Your Config

Create `lua/user/sys/audit.lua`:

```lua
-- Quick audit commands
vim.api.nvim_create_user_command('DustAudit', function()
  local handle = io.popen('cd ~/.config/nv && ./scripts/audit_dustnvim.sh')
  if handle then
    local result = handle:read("*a")
    handle:close()
    print(result)
    vim.notify("Audit complete! Check audit_reports/", vim.log.levels.INFO)
  end
end, { desc = "Run DustNvim configuration audit" })

vim.api.nvim_create_user_command('DustReports', function()
  vim.cmd('edit ~/.config/nv/audit_reports/00_MASTER_SUMMARY.md')
end, { desc = "Open audit reports" })
```

Then use:
- `:DustAudit` - Run full audit
- `:DustReports` - View reports

## 🔧 Troubleshooting

### "Config directory not found"
```bash
# Specify full path
./audit_dustnvim.sh /full/path/to/config
```

### "Permission denied"
```bash
# Make executable
chmod +x audit_dustnvim.sh
chmod +x audit_dustnvim.py
```

### Python version issues
```bash
# Check version (need 3.6+)
python3 --version

# Try explicit python3
python3 audit_dustnvim.py
```

### No duplicates detected
- This is good! Means your config is clean
- Run anyway to generate documentation

## 📚 Understanding the Reports

### Plugin Count Discrepancy?
- **References** count every mention in code
- **Unique** counts each plugin once
- Difference shows where plugins are duplicated

### Keybinding Conflicts
- Same key in different modes is OK
- Same key + mode = potential conflict
- Review descriptions to see if intentional

### LSP Server Status
- Listed servers should be installed via Mason
- Check `:Mason` to verify installation
- Missing servers will show errors on relevant filetypes

## 🤝 Contributing

Improvements welcome! This is a standalone tool that can work with any Neovim config.

## 📄 License

MIT - Same as DustNvim

---

**Made with ❤️ for DustNvim users**

Stop guessing what's in your config. Know exactly what you have.
