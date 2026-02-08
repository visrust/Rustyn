# 🦀 DustNvim

<div align="center">

### **Your IDE. 300ms startup. Zero bloat.**

*Stop configuring. Start coding.*

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Neovim](https://img.shields.io/badge/neovim-0.10+-green.svg)](https://neovim.io)
[![Platform](https://img.shields.io/badge/platform-Linux%20|%20macOS%20|%20Termux-lightgrey.svg)]()

**[🚀 Quick Start](#-quick-start)** • **[📸 Screenshots](#-see-it-in-action)** • **[✨ What's Inside](#-whats-inside)**

</div>

---

## 📸 See It in Action

<div align="center">

![Screenshot_20260208_085859](https://github.com/user-attachments/assets/e8877dab-af8d-4949-88aa-44d6683205d7)

![Screenshot_20260208_090241](https://github.com/user-attachments/assets/d21c224f-bc23-4159-bad5-13637cfca9dd)

![Screenshot_20260208_090137](https://github.com/user-attachments/assets/1a4a98f0-a725-447e-9415-724f756ec144)

<details>
<summary><b>👉 View More Screenshots</b></summary>

![Screenshot_20260208_090033](https://github.com/user-attachments/assets/a1cd2cd8-d9eb-4d04-9fd4-2c03ec12ab49)
![Screenshot_20260208_085632](https://github.com/user-attachments/assets/eee31bca-5a46-4fdd-87e0-0b7a89a8a2ea)
![Screenshot_20260208_084928](https://github.com/user-attachments/assets/4c91c9ee-75a7-49f9-957b-02eb95d90314)

</details>

</div>

---

## 🚀 Quick Start

```bash
# Clone it
mkdir -p ~/.config/dusn && cd ~/.config/dusn
git clone --branch v1.5 --depth=1 https://github.com/visrust/dustnvim.git .

# Launch it
NVIM_APPNAME=dusn nvim

# Optional: Add alias
echo "alias dusn='NVIM_APPNAME=dusn nvim'" >> ~/.bashrc && source ~/.bashrc
```

**That's it.** Plugins auto-install on first launch. Restart once and you're ready.

---

## ✨ What's Inside

<table>
<tr>
<td width="50%">

### ⚡ **Speed**
- **<400ms** startup on desktop
- **~300ms** on Termux (mobile)
- **63 plugins**, zero bloat
- Lazy loading done right

</td>
<td width="50%">

### 🦀 **Rust-First**
- rust-analyzer pre-configured
- Termux-optimized settings
- Instant diagnostics
- Clippy integration

</td>
</tr>
<tr>
<td width="50%">

### 🎨 **5 Theme Collections**
- Catppuccin (4 variants)
- Tokyo Night (4 variants)
- Rose Pine (3 variants)
- Nightfox (7 variants)
- Gruvbox (2 variants)

Switch with `:SGT <theme>`

</td>
<td width="50%">

### 📱 **Termux Native**
- Built & tested on mobile
- Performance tweaks included
- Full feature parity
- No desktop-only compromises

</td>
</tr>
<tr>
<td width="50%">

### 🛠️ **20 LSP Servers**
Rust • C/C++ • Python • Go • TS/JS • Lua • Zig • Bash • Markdown • Docker • JSON • YAML • HTML • CSS • PHP • GDScript • Vim • ASM • CMake • Vale

</td>
<td width="50%">

### 💡 **Smart Tools**
- FzfLua fuzzy finding
- Oil.nvim + Yazi file nav
- Blink.cmp completion
- Leap.nvim precision jumps
- Lazygit integration
- Trouble diagnostics

</td>
</tr>
</table>

---

## 🎯 Why DustNvim?

| DustNvim | Typical Configs |
|----------|-----------------|
| ⚡ <400ms startup | 🐌 2-5 seconds |
| 📱 Termux tested | ❌ Often broken |
| 🎨 5 curated theme sets | 🎲 Scattered themes |
| 🦀 Rust pre-configured | 🔧 Manual setup |
| 🎯 63 handpicked plugins | 📦 100+ bloat |
| 🚀 Ready to use | ⏳ Endless tweaking |

**Perfect for developers who want to code, not configure.**

---

## 🎨 Try Different Looks

```vim
:SGT catppuccin-mocha    " Cozy dark theme
:SGT rose-pine           " Elegant minimalism  
:SGT tokyonight-night    " Vibrant colors
:SGT nightfox            " Natural palette
:SGT gruvbox             " Retro warmth
```

Press `<Space>` to see all keybindings via Which-Key!

---

## 🛠️ Dependencies

**Essential (5 tools):**
```bash
fzf ripgrep fd yazi lazygit
```

**Recommended:**
```bash
bat git-delta nodejs python3 gcc
```

**LSP servers:** Install manually as needed (no Mason). You control your toolchain.

<details>
<summary><b>📦 Installation Commands</b></summary>

```bash
# Termux
pkg install fzf ripgrep fd yazi lazygit git bat git-delta nodejs python clang

# Debian/Ubuntu
sudo apt install fzf ripgrep fd-find yazi lazygit git bat git-delta nodejs python3 build-essential

# Arch Linux
sudo pacman -S fzf ripgrep fd yazi lazygit git bat git-delta nodejs python gcc

# macOS
brew install fzf ripgrep fd yazi lazygit git bat git-delta node python
```

</details>

---

## 🤝 Contributing

Found a bug? Want to add a feature? PRs welcome!

**Ideas:** Add LSP servers • Enhance themes • Improve docs • Fix bugs • Add snippets

[Read Contributing Guide](CONTRIBUTING.md)

---

## 📚 Learn More

<details>
<summary><b>📁 Architecture Overview</b></summary>

```
dusn/
├── init.lua                    # Entry point
└── lua/user/
    ├── stages/                 # Sequential loading (01→07)
    ├── config/server/          # LSP servers by category
    ├── ui/core/                # UI components
    └── snippets/               # Code snippets
```

</details>

<details>
<summary><b>⌨️ Key Keybindings</b></summary>

| Key | Action |
|-----|--------|
| `<Space>` | Show all commands (Which-Key) |
| `m` + 2 chars | Leap to location |
| `-` | File explorer |
| `K` | LSP hover |
| `<Space>f` | Fuzzy find files |
| `<Space>gl` | Lazygit |
| `<C-\>` | Toggle terminal |

**39 total keybindings** - discover them with `<Space>`!

</details>

<details>
<summary><b>🗑️ Uninstall</b></summary>

```bash
rm -rf ~/.config/dusn/ ~/.local/share/dusn/ ~/.local/state/dusn/ ~/.cache/dusn/
```

</details>

---

<div align="center">

### Built with ❤️ by developers, for developers

**Stop configuring. Start coding.**

[⭐ Star on GitHub](https://github.com/visrust/DustNvim) • [🐛 Report Issues](https://github.com/visrust/DustNvim/issues) • [💬 Discussions](https://github.com/visrust/DustNvim/discussions)

</div>
