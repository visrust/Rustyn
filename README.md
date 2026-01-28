# DustNvim

<div align="center">

**🦀 A no-nonsense Neovim distribution for developers who value speed over complexity.**

**Sub-400ms startup • Rust-first LSP • Termux-native • 300+ themes • Your new daily driver.**

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Neovim](https://img.shields.io/badge/neovim-0.10+-green.svg)](https://neovim.io)
[![Platform](https://img.shields.io/badge/platform-Linux%20|%20macOS%20|%20Termux-lightgrey.svg)]()
[![Size](https://img.shields.io/badge/size-~1MB-orange.svg)]()

[Features](#-features) • [Installation](#-installation) • [Screenshots](#-screenshots) • [Dependencies](#-dependencies) • [Structure](#-project-structure) • [Contributing](#-contributing)

</div>

---

## 🎯 Why DustNvim?

Born from the frustration of complex configurations and bloated distributions that break on resource-constrained environments, DustNvim delivers a **production-ready IDE experience** without the configuration headache.

### **What makes it different**

| Feature | DustNvim | Typical Distros |
|---------|----------|----------------|
| **Startup Time** | <400ms on Snapdragon 4 Gen 1 | 2-5 seconds |
| **Mobile Support** | Built & tested on Termux | Often broken |
| **Themes** | 300+ (Catppuccin, Rose Pine, Tokyo Night, Nightfox, Base16) | 60-100 |
| **Rust Support** | Pre-configured rust-analyzer | Manual setup |
| **Size** | ~1MB (depth=1 clone) | 5-10MB |
| **Philosophy** | Opinionated defaults, easy customization | Configure everything |

**Perfect for:**
- 🚀 Developers who want to code, not configure
- 📱 Mobile developers working in Termux
- 🦀 Rustaceans seeking first-class tooling
- ⚡ Anyone tired of slow, bloated setups
- 🎨 Theme enthusiasts who love visual variety

---

## ✨ Features

### **🔥 Core Strengths**

- **⚡ Blazing Fast** — Sub-400ms startup even on mobile chipsets
- **🦀 Rust Excellence** — Zero-config rust-analyzer with instant diagnostics
- **📱 Universal Compatibility** — Desktop to smartphone, zero compromises
- **🎨 Theme Paradise** — 300+ curated colorschemes via popular collections
- **🛠️ Pre-configured LSP** — 15+ languages ready out-of-the-box
- **🐛 Integrated Debugging** — DAP setup for Rust (extensible to others)
- **💼 Lightweight** — ~1MB footprint with all features included

### **💻 Developer Experience**

| Feature | Description | Keybinding |
|---------|-------------|------------|
| **Smart Completion** | Blink.cmp with snippet support | Auto-trigger |
| **Fuzzy Finding** | Files, buffers, live grep via fzf.lua | `<Space>f`+ sequence |
| **File Navigation** | Oil.nvim (buffer-style) + Yazi (visual) | `<Space>e` / `<Space>y` |
| **Precision Jumps** | Leap.nvim 2-character navigation | `m`/`M` + 2 chars + Enter/Backspace (optional)|
| **Buffer Switching** | Snipe for visual selection | `<Space>sb` |
| **Live Diagnostics** | Cursor-hold popups + Trouble.nvim | Auto / `<Space>ut` |
| **Undo Tree** | Visual persistent undo history | `<Space>u` |
| **Auto-save** | Toggle save-on-focus-loss | `<Space>as` (2x) |
| **Floating Terminal** | Built-in terminal + Lazygit | `<Space>o` / `<Space>gl` |
| **Session Manager** | Save/restore project sessions | `<Space>ss/sf/sl/sd` |
| **WhKey**| Discover on space | `<Space>` |

### **🎨 UI & Polish**

- **Nightfox Default Theme** — Beautiful out-of-the-box aesthetics
- **300+ Themes** — Catppuccin, Rose Pine, Tokyo Night, Nightfox, Base16 (RRethy), Gruvbox, and more
- **Smart Statusline** — File info, LSP status, git branch (lualine)
- **Buffer Tabline** — Visual buffer management (cokeline)
- **Clean Notifications** — Non-intrusive mini.notify popups
- **Indent Guides** — Rainbow-colored indentation (indent-blankline)
- **Icon Support** — Beautiful file icons (mini.icons + web-devicons)

### **🔧 Language Support**

**Pre-configured LSP servers by category:**

<details>
<summary><b>🔩 Low-Level Languages</b></summary>

- Rust (`rust-analyzer`)
- C/C++ (`clangd`)
- Zig (`zls`)
- Assembly (`asm_lsp`)
- CMake (`cmake`)

</details>

<details>
<summary><b>🐍 High-Level Languages</b></summary>

- Python (`pyright`)
- Lua (`lua-ls`)

</details>

<details>
<summary><b>🌐 Web Development</b></summary>

- TypeScript/JavaScript (`ts_ls`)
- Go (`gopls`)
- HTML (`html`)
- CSS (`css_ls`)
- PHP (`phpactor`)

</details>

<details>
<summary><b>🎮 Game Development</b></summary>

- GDScript (`godot_ls`)

</details>

<details>
<summary><b>📝 Productivity</b></summary>

- Markdown (`marksman`)
- Bash (`bash_ls`)
- Vim (`vimls`)

</details>

<details>
<summary><b>🔧 Utilities</b></summary>

- Docker (`dockerls`)
- JSON (`jsonls`)
- YAML (`yamlls`)

</details>

---

## 📸 Screenshots

<div align="center">

### Coding Interface with LSP Diagnostics
![Main Interface](https://github.com/user-attachments/assets/f0cafcf7-5e85-426e-b689-8b0e13a1b101)

### File Navigation & Buffer Management
![Coding View](https://github.com/user-attachments/assets/448f5763-c4c7-4157-9d70-48baae2b0dad)

### Fuzzy Finding with fzf.lua
![File Navigation](https://github.com/user-attachments/assets/2a345bc7-32eb-4692-ae71-45f6cfc0938b)

<details>
<summary>📷 <b>View More Screenshots</b></summary>

<br>

### Live Diagnostics & Error Highlighting
![Diagnostics](https://github.com/user-attachments/assets/13fa7537-bb8a-4add-bcdb-25d652a417ad)

### LSP Features & Code Actions
![LSP Features](https://github.com/user-attachments/assets/e045b264-80f2-4ff7-b4da-77f487e748d4)

### Integrated Terminal & Git
![Terminal](https://github.com/user-attachments/assets/cd27e86e-707d-46ab-95a3-5f11da96dcee)

</details>

</div>

---

## 🚀 Installation

### Quick Start (30 seconds)

```bash
# Clone the configuration
mkdir -p ~/.config/nv && cd ~/.config/nv
git clone --depth=1 https://github.com/visrust/DustNvim.git .

# First launch (plugins auto-install via Lazy.nvim)
NVIM_APPNAME=nv nvim
```

**First Launch Note:** Lazy.nvim will automatically install all plugins. This takes 1-2 minutes on first run. Restart Neovim after installation completes.

### Add Convenient Alias

```bash
# For Bash
echo "alias nv='NVIM_APPNAME=nv nvim'" >> ~/.bashrc && source ~/.bashrc

# For Zsh
echo "alias nv='NVIM_APPNAME=nv nvim'" >> ~/.zshrc && source ~/.zshrc

# For Fish
echo "alias nv='NVIM_APPNAME=nv nvim'" >> ~/.config/fish/config.fish && source ~/.config/fish/config.fish
```

**Launch:** Type `nv` in your terminal

### Uninstall

```bash
# Remove all DustNvim files
rm -rf ~/.config/nv/ ~/.local/share/nv/ ~/.local/state/nv/ ~/.cache/nvim/nv/
```

---

## 📦 Dependencies

DustNvim requires some external tools for full functionality. Don't worry—most are available in standard package managers!

### **Essential (Core Functionality)**

These are required for fuzzy finding, file navigation, and git integration:

```bash
fzf              # Fuzzy finder (required by fzf-lua)
ripgrep          # Fast grep (required by fzf-lua)
fd               # Fast find (fd-find on some distros)
yazi             # Terminal file manager
lazygit          # Git TUI
git              # Version control
```

**Quick Install:**

```bash
# Termux
pkg install fzf ripgrep fd yazi lazygit git

# Debian/Ubuntu
sudo apt install fzf ripgrep fd-find yazi lazygit git

# Arch Linux
sudo pacman -S fzf ripgrep fd yazi lazygit git

# macOS (Homebrew)
brew install fzf ripgrep fd yazi lazygit git
```

### **Highly Recommended (Enhanced Features)**

```bash
bat              # Better file previews in fzf
delta            # Enhanced git diffs in lazygit
node             # Required for TypeScript/JavaScript LSPs
python3          # Required for Python LSP
gcc/clang        # C compiler for treesitter parsers
```

**Install:**

```bash
# Termux
pkg install bat git-delta nodejs python clang

# Debian/Ubuntu
sudo apt install bat git-delta nodejs python3 build-essential

# Arch Linux
sudo pacman -S bat git-delta nodejs python gcc

# macOS
brew install bat git-delta node python
```

### **Language-Specific Tools**

Most LSP servers, formatters, and debuggers can be installed automatically via **Mason** (`:Mason` command inside Neovim). However, you can pre-install them:

```bash
# Rust (Recommended: install via rustup)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rust-analyzer rustfmt clippy

# Go
# Install Go from https://go.dev/dl/
go install golang.org/x/tools/gopls@latest

# Python
pip install black isort  # Formatters

# Lua
# Install via Mason or: cargo install stylua

# Web (Prettier)
npm install -g prettier
```

**Pro Tip:** Run `:Mason` inside Neovim to install LSP servers, formatters, and linters through a friendly UI!

---

## 🎨 Customization

### Switch Themes

DustNvim includes **300+ themes** from popular collections:

```vim
:SGT catppuccin-mocha       " Catppuccin variant
:SGT rose-pine              " Rose Pine
:SGT tokyonight-night       " Tokyo Night
:SGT nightfox               " Nightfox
:SGT base16-gruvbox-dark-hard  " Base16 Gruvbox
```

**Browse all themes:** Type `:SGT ` and press `<Tab>` to cycle through available colorschemes.

**Set default theme:** Edit `lua/user/ui/core/sgt.lua` or use auto-commands in your config.

### Key Mappings Cheatsheet

Press `<Space>` (leader key) to activate **which-key** and see all available mappings!

**Most Common Bindings:**

| Action | Keybinding | Description |
|--------|------------|-------------|
| **File Finding** | `<Space>ff` | Find files |
| **Live Grep** | `<Space>fg` | Search in files |
| **Buffers** | `<Space>sb` | Snipe buffers (visual) |
| **File Explorer** | `<Space>e` | Oil.nvim (buffer-style) |
| **Yazi** | `<Space>y` | Yazi file manager |
| **LSP Definition** | `gd` | Go to definition |
| **LSP References** | `gr` | Find references |
| **LSP Hover** | `K` | Show documentation |
| **LSP Preview** | `gp` | Preview definition |
| **Git UI** | `<Space>gg` | Open Lazygit |
| **Terminal** | `<Ctrl+Space>` | Toggle terminal |
| **Save Session** | `<Space>ss` | Save session |
| **Load Session** | `<Space>sl` | Load session |
| **Undo Tree** | `<Space>u` | Visual undo history |
| **Auto-save Toggle** | `<Space>as` (2x) | Toggle auto-save |

**Full list:** Check `lua/user/sys/mappings.lua` or press `<Space>` in Neovim.

### Add Custom LSP Server

To add a new language server, create a file in the appropriate category:

**Example:** Adding a new server to the Web category:

```lua
-- File: lua/user/config/server/Web/svelte_ls.lua
return {
  cmd = { "svelteserver", "--stdio" },
  filetypes = { "svelte" },
  root_dir = require("lspconfig.util").root_pattern("package.json", "svelte.config.js"),
  settings = {
    svelte = {
      plugin = {
        html = { completions = { enable = true } },
        svelte = { completions = { enable = true } },
      }
    }
  }
}
```

The server will be automatically loaded on next restart!

### Custom Snippets

Add your own snippets in JSON format:

```bash
# Create a new snippet file
nvim ~/.config/nv/lua/user/snippets/rust.json
```

**Example snippet:**

```json
{
  "Print Debug": {
    "prefix": "pd",
    "body": [
      "println!(\"${1:variable}: {:?}\", ${1:variable});"
    ],
    "description": "Debug print statement"
  }
}
```

---

## 📁 Project Structure

DustNvim uses a **staged loading architecture** for optimal startup performance:

```
nvim/
├── init.lua                    # Entry point
├── lazy-lock.json              # Plugin version lock
└── lua/
    └── user/                   # Root namespace (require("user.*"))
        │
        ├── stages/             # 🚀 Sequential loading stages
        │   ├── 01_sys.lua      #    Core system (options, mappings)
        │   ├── 02_uiCore.lua   #    UI foundation (statusline, tabline)
        │   ├── 03_mini.lua     #    Mini.nvim ecosystem
        │   ├── 04_server.lua   #    LSP server configurations
        │   ├── 05_tools.lua    #    Completion, formatting, linting
        │   ├── 06_dap.lua      #    Debug adapters
        │   └── 07_ide.lua      #    IDE features (navigation, sessions)
        │
        ├── sys/                # 🔧 Core system configuration
        │   ├── options.lua     #    Neovim options (number, indent, etc.)
        │   ├── mappings.lua    #    Global keybindings
        │   ├── plugins.lua     #    Lazy.nvim plugin manager setup
        │   ├── mason.lua       #    Mason LSP installer config
        │   └── inbuilt/        #    Built-in enhancements
        │       ├── last_pos.lua      #    Restore cursor position
        │       ├── RestartNvim.lua   #    Restart command
        │       └── ReloadFiles.lua   #    Live reload configs
        │
        ├── config/
        │   ├── server/         # 📡 LSP configurations by category
        │   │   ├── LowLevel/   #    Rust, C/C++, Zig, ASM
        │   │   ├── HighLevel/  #    Python, Lua
        │   │   ├── Web/        #    Go, TS, HTML, CSS, PHP
        │   │   ├── GameDev/    #    Godot GDScript
        │   │   ├── Productive/ #    Bash, Markdown, Vim
        │   │   └── Utilities/  #    Docker, JSON, YAML
        │   │
        │   ├── tools/          # 🛠️ LSP tooling
        │   │   ├── blink.lua        #    Completion engine
        │   │   ├── lsp.lua          #    LSP config
        │   │   ├── formatter.lua    #    Code formatting
        │   │   ├── luasnip.lua      #    Snippet engine
        │   │   └── trouble.lua      #    Diagnostics panel
        │   │
        │   ├── dap/            # 🐛 Debugger configurations
        │   │   ├── setup.lua        #    DAP core setup
        │   │   ├── keymaps.lua      #    Debug keybindings
        │   │   └── langs/
        │   │       └── rust.lua     #    Rust debugger (codelldb)
        │   │
        │   └── ide/            # 💡 IDE features
        │       ├── file/       #    File navigation
        │       │   ├── fzf.lua      #    Fuzzy finder
        │       │   ├── oil.lua      #    Buffer-style file manager
        │       │   ├── leap.lua     #    2-char jump navigation
        │       │   └── snipe.lua    #    Visual buffer picker
        │       └── ide/        #    Editor enhancements
        │           ├── sessions.lua      #    Session management
        │           ├── undotree.lua      #    Visual undo history
        │           ├── treesitter.lua    #    Syntax highlighting
        │           ├── whkey.lua         #    Which-key popup
        │           └── local_module/     #    Custom modules
        │               ├── autosave_module.lua
        │               └── dustTerm_module.lua
        │
        ├── ui/                 # 🎨 UI components
        │   └── core/
        │       ├── statusline.lua    #    Lualine config
        │       ├── cokeline.lua      #    Buffer tabline
        │       ├── dashboard.lua     #    Alpha.nvim dashboard
        │       ├── dressing.lua      #    Better UI inputs
        │       ├── ibl.lua           #    Indent guides
        │       └── sgt.lua           #    Theme switcher
        │
        ├── mini/               # 🔷 Mini.nvim plugins
        │   ├── mini_icons.lua       #    Icon support
        │   ├── mini_notify.lua      #    Notifications
        │   └── mini_pairs.lua       #    Auto-pairs
        │
        └── snippets/           # ✂️ Code snippets (JSON format)
            ├── rust.json
            ├── lua.json
            ├── go.json
            ├── html.json
            └── ...
```

### Directory Tree Command

View the structure yourself:

```bash
# Using eza (modern tree alternative)
eza --tree --level=3 --icons --git-ignore

# With more details
eza --tree --level=3 --icons --long --no-permissions --no-user

# Traditional tree
tree -L 3 -I 'node_modules|.git'

# Install eza: https://github.com/eza-community/eza
```

**Understanding the Architecture:**

1. **Staged Loading** — Plugins load in sequence (01→07) to optimize startup
2. **Modular LSP** — Each language server is a separate file for easy management
3. **Category-Based** — Servers grouped by use case (LowLevel, Web, etc.)
4. **Local Modules** — Custom functionality in `local_module/` for extensibility
5. **Clean Separation** — UI, tools, and IDE features are isolated for maintainability

---

## 🤝 Contributing

Contributions are welcome! Whether you're fixing bugs, adding language support, or improving documentation—every bit helps.

### How to Contribute

1. **Fork & Clone**
   ```bash
   git clone https://github.com/YOUR_USERNAME/DustNvim.git
   cd DustNvim
   ```

2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/add-python-snippets
   ```

3. **Make Your Changes**
   - Follow the existing directory structure
   - Test on both desktop and Termux if possible
   - Keep plugins minimal and purposeful

4. **Submit a Pull Request**
   - Clearly describe your changes
   - Reference any related issues
   - Update documentation if needed

### Contribution Ideas

- 🌍 **Add Language Servers** — Contribute LSP configs in `config/server/<Category>/`
- 🎨 **UI Improvements** — Enhance statusline, tabline, or dashboard
- 📚 **Documentation** — Improve guides, add tutorials, fix typos
- 🐛 **Bug Fixes** — Report and fix issues
- ⚡ **Performance** — Optimize startup time or plugin loading
- 📱 **Termux Support** — Test and improve mobile compatibility
- ✂️ **Snippets** — Add language snippets in `snippets/`

### Guidelines

- **Keep it minimal** — DustNvim prioritizes speed over features
- **Test thoroughly** — Especially on Termux/mobile environments
- **Document changes** — Update README or add comments
- **Respect architecture** — Follow the staged loading pattern
- **One feature per PR** — Easier to review and merge

### Testing

```bash
# Test in isolated environment
NVIM_APPNAME=nv-test nvim

# Profile startup time
nvim --startuptime startup.log

# Check for errors
:checkhealth
```

---

## 📚 Learning Resources

New to DustNvim or Neovim? Check out these guides:

### Built-in Documentation

- **`Books/basics.md`** — Neovim fundamentals and concepts
- **`Books/lesson_1.md`** — DustNvim-specific workflows and tips
- **`Books/_dustTerm.md`** — Terminal integration guide

### Useful Commands

```vim
:checkhealth           " Diagnose configuration issues
:Mason                 " Install LSP servers/formatters
:Lazy                  " Manage plugins
:SGT <theme>           " Change colorscheme
:help <topic>          " Built-in Neovim help
```

### External Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [LSP Configuration Guide](https://github.com/neovim/nvim-lspconfig)
- [Lua Guide for Neovim](https://github.com/nanotee/nvim-lua-guide)
- [Treesitter Docs](https://github.com/nvim-treesitter/nvim-treesitter)

---

## 🙏 Credits

DustNvim stands on the shoulders of giants. Special thanks to:

- **Plugin Authors** — All the amazing Neovim plugin developers
- **Theme Creators** — Catppuccin, Rose Pine, Tokyo Night, Nightfox, Base16 teams
- **Community** — Neovim and Termux communities for inspiration and support

### Key Dependencies

- [lazy.nvim](https://github.com/folke/lazy.nvim) — Plugin manager
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) — LSP configurations
- [blink.cmp](https://github.com/Saghen/blink.cmp) — Completion engine
- [fzf-lua](https://github.com/ibhagwan/fzf-lua) — Fuzzy finder
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) — Syntax highlighting
- And [60+ other plugins](lazy-lock.json) that make this possible!

---

## 📜 License

MIT License - see [LICENSE](LICENSE) file for details.

**TL;DR:** Free to use, modify, and distribute. No warranty provided.

---

## 💬 Support & Community

- 🐛 **Report Bugs:** [GitHub Issues](https://github.com/visrust/DustNvim/issues)
- 💡 **Feature Requests:** [GitHub Discussions](https://github.com/visrust/DustNvim/discussions)
- ⭐ **Star the Repo:** Show your support!

---

<div align="center">

**Built with ❤️ by developers, for developers**

*Stop configuring. Start coding.*

[⬆ Back to Top](#dustnvim)

</div>
