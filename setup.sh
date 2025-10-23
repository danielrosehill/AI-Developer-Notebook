#!/bin/bash

# Master setup script for AI Developer Notebook
# Runs all setup operations in the correct order

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "============================================================"
echo -e "${BOLD}${CYAN}AI Developer Notebook - Setup${NC}"
echo "============================================================"
echo ""
echo "This script will:"
echo "  1. Inject Claude snippet into ~/CLAUDE.md"
echo "  2. Set up the AI reference notebook"
echo ""
echo "Press Enter to continue or Ctrl+C to cancel..."
read -r

# Step 1: Inject Claude snippet
echo ""
echo "============================================================"
echo -e "${BOLD}Step 1: Injecting Claude Snippet${NC}"
echo "============================================================"
echo ""

if [ -f "$SCRIPT_DIR/scripts/inject-claude-snippet.sh" ]; then
    bash "$SCRIPT_DIR/scripts/inject-claude-snippet.sh"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓${NC} Claude snippet injection completed successfully"
    else
        echo -e "${RED}✗${NC} Claude snippet injection failed"
        exit 1
    fi
else
    echo -e "${RED}Error: scripts/inject-claude-snippet.sh not found${NC}"
    exit 1
fi

# Step 2: Set up notebook
echo ""
echo "============================================================"
echo -e "${BOLD}Step 2: Setting Up Reference Notebook${NC}"
echo "============================================================"
echo ""

if [ -f "$SCRIPT_DIR/scripts/setup-notebook.sh" ]; then
    bash "$SCRIPT_DIR/scripts/setup-notebook.sh"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓${NC} Notebook setup completed successfully"
    else
        echo -e "${RED}✗${NC} Notebook setup failed"
        exit 1
    fi
else
    echo -e "${RED}Error: scripts/setup-notebook.sh not found${NC}"
    exit 1
fi

# Final summary
echo ""
echo "============================================================"
echo -e "${BOLD}${GREEN}All Setup Tasks Completed!${NC}"
echo "============================================================"
echo ""
echo -e "${BOLD}Summary:${NC}"
echo ""
echo -e "${GREEN}✓${NC} Claude snippet injected into ~/CLAUDE.md"
echo -e "${GREEN}✓${NC} Reference notebook created at /home/daniel/obsidian-notebooks/notes-from-ai"
echo ""
echo -e "${BOLD}What's Next:${NC}"
echo ""
echo "1. ${CYAN}Test Claude Code from home directory:${NC}"
echo "   cd ~"
echo "   claude"
echo "   Then ask Claude to add something to the reference notebook"
echo ""
echo "2. ${CYAN}Open the notebook in Obsidian:${NC}"
echo "   - Launch Obsidian"
echo "   - Open vault at: /home/daniel/obsidian-notebooks/notes-from-ai"
echo ""
echo "3. ${CYAN}Individual scripts:${NC}"
echo "   - scripts/inject-claude-snippet.sh - Update Claude instructions"
echo "   - scripts/setup-notebook.sh - Reinitialize or update notebook"
echo ""
echo -e "${BOLD}Documentation:${NC}"
echo "   See README.md for detailed usage instructions"
echo ""
echo "============================================================"
echo ""
