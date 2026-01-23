# DustNvim

Bored of everyday configuration headache ? Then you are at the right place as Dust Neovim is designed to solve your everyday problem by its minimal yet modern ide like features.

---

## Problem it solves ?

Around mid of 2025 when I arrived in Neovim from Emacs I found nvim is needed to be configured from scratch. I had joined nvim to get smarter and better features and I started to configure neovim; it felt very hard and I shifted to Distro's like LunarVim but they were incompatible for my termux and this made me make my own distribution which welcomes everyone 

The type of problem it solves is complex as it depends on your kind of problem as DustNvim is full of :

1. Themes that any programmer deserves.

2. Ui layer that shows opened buffers , tell lsp diagnostics.

3. Minimal but better keybindings that include Fzf Yazi 

4. Majors languages like C , Rust , Go being Already setup

5. Every feature you can think of including undo_history , buffer picker , file navigation and motions , faster inbuilt terminal 

6. Resonable amount of plugins with Lazy plugin manager.

7. Faster startup around ~1/2.5 seconds (~400ms) even on Snapdragon-4gen-1. 

8. Easy to vibe-code with ai and debug with dap.

9. Less mistake chances due to on screen pop-up diagnostics on CursorHold.

## Take a look ....
![IMG_20251213_145632](https://github.com/user-attachments/assets/f0cafcf7-5e85-426e-b689-8b0e13a1b101)
![IMG_20251213_142322](https://github.com/user-attachments/assets/448f5763-c4c7-4157-9d70-48baae2b0dad)
![IMG_20251213_144538](https://github.com/user-attachments/assets/2a345bc7-32eb-4692-ae71-45f6cfc0938b)


<details>
<summary>Show more images</summary>

![IMG_20251213_150246](https://github.com/user-attachments/assets/13fa7537-bb8a-4add-bcdb-25d652a417ad)
![IMG_20251213_141051](https://github.com/user-attachments/assets/e045b264-80f2-4ff7-b4da-77f487e748d4)
![IMG_20251213_144636](https://github.com/user-attachments/assets/cd27e86e-707d-46ab-95a3-5f11da96dcee)



</details>

## What is included ?

This is broad as I have focused on multiple niche to keep editor balanced.

## tools 

- Built in floating terminal.
- Fzf.lua and Yazi (make sure to install fzf & yazi in terminal).
- formatter
-


## servers 
- dap currently for rust only.
- nvim-lsp-config based everyday programming language lsp configured.
- which keys , show key , yank history & undo tree 
- `:SGT colorscheme_name` to set available theme to 
- go-to-preview for float based lsp preview on motions `gp`

### ui 
- NightFox on startup.
- cokeline for tabline and lualine for statusline 
- mini.notify for notification.

### motion 
- leap nvim for smarter + precise jumps 2 character jumps in buffer.
- snipe nvim with `<leader>sb` + `<leader>fb` for precision
- 
**Zero friction development**
- Only 105 KBS !
- 2-3 second startup even on Snapdragon 4 Gen 1
- Battle-tested in production environments
- Runs flawlessly on Termux (built there, actually)

**Thoughtfully designed**
- 105 curated themes, zero configuration chaos
- Rust-first with stellar language support across the board
- Maximum power, minimal complexity

---

## 🚀 What you get

### **Core strengths**
- **Rust excellence** – First-class Rust analyzer integration with instant error detection
- **Universal compatibility** – Desktop to smartphone, no performance compromises
- **Smart defaults** – Useful leader mappings that feel natural from day one
- **Stable foundation** – Latest stable builds, rare breaking changes

### **Developer experience**
- Live diagnostics with intelligent error handling
- Auto-save on `<Space>as` double-tap
- Integrated terminal (`Ctrl+Space`) + Lazygit (`<Space>gg`)
- Flash.nvim quick-jump and mini2D navigation
- Oil + Telescope for blazing file navigation

### **Project management**
- Effortless session management (`<Space>ss/sf/sl/sd`)
- Root-based project detection
- Dual completion engines (nvim-cmp default)
- AI-assisted configuration tweaking

---

## ⚙️ Get started in 30 seconds

```bash
mkdir -p ~/.config/nv && cd ~/.config/nv
git clone --depth=1 https://github.com/visrust/DustNvim.git .
NVIM_APPNAME=nv nvim
```

**Add the alias:**
```bash
# Bash
echo "alias nv='NVIM_APPNAME=nv nvim'" >> ~/.bashrc && source ~/.bashrc

# Zsh
echo "alias nv='NVIM_APPNAME=nv nvim'" >> ~/.zshrc && source ~/.zshrc
```

**Launch:** `nv`

**Uninstall:** `rm -rf ~/.config/nv/ ~/.local/share/nv/`

```txt
nvim
└── lua --runtime folder 
    └── user -- root use it as first arg in require(user.path.to.some)
        ├── config -- entry to config 
        │   ├── dap -- per language debugger goes here (for pros)
        │   │   └── langs
        │   ├── ide 
        │   │   ├── file
        │   │   └── ide
        │   │       ├── local_module -- you add you module here (for plugin developer)
        │   │       └── module_require -- require them here (for plugin developer)
        │   ├── server -- add lsp server here in .lua file 
        │   │   ├── GameDev -- godot 
        │   │   ├── HighLevel -- py lua 
        │   │   ├── LowLevel -- rs , C , Cpp , Zls etc 
        │   │   ├── Productive -- marksman 
        │   │   ├── Utilities -- docker 
        │   │   └── Web -- Go Html Css Js 
        │   └── tools -- add your lsp tools like other completeion engines here 
        │       └── deprecated -- soem deperecated but useful tools 
        ├── mini -- mini ecosys 
        ├── snippets -- add snips in .json format
        ├── stages -- stages call specific stages such as sys etc 
        ├── sys -- important files 
        │   └── inbuilt -- inbuilt important 
        └── ui -- ui plugins stay here 
            └── core -- currently we keep dustnvim minimal in ui
```
---

--- 

## Those who wants to contribute :

1. Follow general contribution guide 
2. Clone with full history or first use --depth=1 and put the config into fully history cloned config.
