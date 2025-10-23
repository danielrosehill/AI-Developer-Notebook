#!/bin/bash

# Script to inject for-main-claude.md snippet into ~/CLAUDE.md
# This ensures Claude Code knows about the reference notebook location

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Define paths
SNIPPET_FILE="$PROJECT_ROOT/snippets/for-main-claude.md"
TARGET_FILE="$HOME/CLAUDE.md"

# Marker to identify our section
SECTION_START="## Creating Reference Documentation"
SECTION_END="This may or may not be related to the current task."

echo "======================================"
echo "Claude Snippet Injection Script"
echo "======================================"
echo ""

# Check if snippet file exists
if [ ! -f "$SNIPPET_FILE" ]; then
    echo -e "${RED}Error: Snippet file not found at $SNIPPET_FILE${NC}"
    exit 1
fi

echo -e "${GREEN}✓${NC} Found snippet file: $SNIPPET_FILE"

# Read the snippet content
SNIPPET_CONTENT=$(cat "$SNIPPET_FILE")

# Create target file if it doesn't exist
if [ ! -f "$TARGET_FILE" ]; then
    echo -e "${YELLOW}!${NC} Target file $TARGET_FILE does not exist. Creating it..."
    cat > "$TARGET_FILE" << 'EOF'
# CLAUDE.md For Home Folder

## General guidance

You are Claude, a helpful AI assistant working with Daniel on his desktop/workstation.

This computer is Daniel's desktop/workstation running Ubuntu 25.04 with KDE Plasma on Wayland.

EOF
    echo -e "${GREEN}✓${NC} Created new CLAUDE.md file"
fi

# Check if our section already exists
if grep -q "$SECTION_START" "$TARGET_FILE"; then
    echo -e "${YELLOW}!${NC} Section already exists in $TARGET_FILE"
    echo "   Updating existing section..."

    # Create a temporary file
    TEMP_FILE=$(mktemp)

    # Use awk to replace the section
    awk -v start="$SECTION_START" -v end="$SECTION_END" -v snippet="$SNIPPET_CONTENT" '
    BEGIN { in_section=0 }
    $0 ~ start {
        print snippet
        in_section=1
        next
    }
    $0 ~ end && in_section {
        in_section=0
        next
    }
    !in_section { print }
    ' "$TARGET_FILE" > "$TEMP_FILE"

    # Replace the original file
    mv "$TEMP_FILE" "$TARGET_FILE"
    echo -e "${GREEN}✓${NC} Updated existing section in $TARGET_FILE"
else
    echo "   Appending snippet to $TARGET_FILE..."

    # Append the snippet with a newline separator
    echo "" >> "$TARGET_FILE"
    echo "$SNIPPET_CONTENT" >> "$TARGET_FILE"

    echo -e "${GREEN}✓${NC} Appended snippet to $TARGET_FILE"
fi

echo ""
echo "======================================"
echo -e "${GREEN}Success!${NC} Claude snippet has been injected."
echo "======================================"
echo ""
echo "You can now use Claude Code from ~ and it will know"
echo "about the reference notebook location."
