#!/bin/bash

# DustNvim Auditor Installer
# Quick setup for your config

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${BLUE}  DustNvim Auditor Installation${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo ""

# Detect config location
if [ -d "$HOME/.config/nv" ]; then
    CONFIG_PATH="$HOME/.config/nv"
elif [ -d "$HOME/.config/nvim" ]; then
    CONFIG_PATH="$HOME/.config/nvim"
else
    echo -e "${YELLOW}Cannot auto-detect config. Please enter path:${NC}"
    read -p "Config path: " CONFIG_PATH
fi

echo -e "${GREEN}✓ Using config: $CONFIG_PATH${NC}"

# Create scripts directory
SCRIPTS_DIR="$CONFIG_PATH/scripts"
mkdir -p "$SCRIPTS_DIR"

echo -e "${YELLOW}📂 Installing scripts to: $SCRIPTS_DIR${NC}"

# Copy scripts
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp "$SCRIPT_DIR/audit_dustnvim.sh" "$SCRIPTS_DIR/"
cp "$SCRIPT_DIR/audit_dustnvim.py" "$SCRIPTS_DIR/"
cp "$SCRIPT_DIR/README.md" "$SCRIPTS_DIR/"

# Make executable
chmod +x "$SCRIPTS_DIR/audit_dustnvim.sh"
chmod +x "$SCRIPTS_DIR/audit_dustnvim.py"

echo -e "${GREEN}✓ Scripts installed!${NC}"
echo ""

# Test Python availability
if command -v python3 &> /dev/null; then
    PYTHON_VER=$(python3 --version | grep -oE '[0-9]+\.[0-9]+')
    echo -e "${GREEN}✓ Python 3 detected: $PYTHON_VER${NC}"
    RECOMMENDED="Python script (more powerful)"
    RECOMMENDED_CMD="python3 $SCRIPTS_DIR/audit_dustnvim.py"
else
    echo -e "${YELLOW}⚠ Python 3 not found${NC}"
    RECOMMENDED="Bash script"
    RECOMMENDED_CMD="$SCRIPTS_DIR/audit_dustnvim.sh"
fi

echo ""
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ Installation Complete!${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}Recommended:${NC} $RECOMMENDED"
echo ""
echo -e "${GREEN}Run your first audit:${NC}"
echo "  $RECOMMENDED_CMD"
echo ""
echo -e "${GREEN}Or from anywhere:${NC}"
echo "  cd $CONFIG_PATH"
echo "  ./scripts/audit_dustnvim.sh"
echo ""
echo -e "${YELLOW}Optional: Add alias to your shell RC:${NC}"
echo "  alias nv-audit='$RECOMMENDED_CMD'"
echo ""
echo -e "📚 ${GREEN}Documentation:${NC} $SCRIPTS_DIR/README.md"
echo ""

# Offer to run now
read -p "Run audit now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    eval "$RECOMMENDED_CMD"
fi
