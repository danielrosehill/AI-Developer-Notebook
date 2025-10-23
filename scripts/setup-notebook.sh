#!/bin/bash

# Script to set up the AI reference notebook in Obsidian directory
# Creates directory structure, initializes git, and optionally creates GitHub repo

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Define paths
NOTEBOOK_DIR="/home/daniel/obsidian-notebooks/notes-from-ai"
CLAUDE_MD_TEMPLATE="$PROJECT_ROOT/claude-md/notebook-claude.md"

echo "=========================================="
echo "AI Reference Notebook Setup Script"
echo "=========================================="
echo ""

# Create notebook directory
if [ -d "$NOTEBOOK_DIR" ]; then
    echo -e "${YELLOW}!${NC} Notebook directory already exists: $NOTEBOOK_DIR"
else
    echo "Creating notebook directory: $NOTEBOOK_DIR"
    mkdir -p "$NOTEBOOK_DIR"
    echo -e "${GREEN}✓${NC} Created notebook directory"
fi

# Create subdirectories for organization
echo ""
echo "Creating subdirectory structure..."
mkdir -p "$NOTEBOOK_DIR"/{code-examples,documentation,guides,snippets,troubleshooting}
echo -e "${GREEN}✓${NC} Created subdirectories:"
echo "   - code-examples/"
echo "   - documentation/"
echo "   - guides/"
echo "   - snippets/"
echo "   - troubleshooting/"

# Copy CLAUDE.md template
echo ""
if [ -f "$CLAUDE_MD_TEMPLATE" ]; then
    echo "Copying CLAUDE.md template..."
    cp "$CLAUDE_MD_TEMPLATE" "$NOTEBOOK_DIR/CLAUDE.md"
    echo -e "${GREEN}✓${NC} CLAUDE.md has been created in notebook"
else
    echo -e "${YELLOW}!${NC} Template not found, creating basic CLAUDE.md..."
    cat > "$NOTEBOOK_DIR/CLAUDE.md" << 'EOF'
# CLAUDE.md For AI Reference Notebook

This is Daniel's AI reference notebook - a centralized location for documentation,
code examples, and reference materials generated during Claude Code sessions.

When working with Claude Code and you want to save reference material, explicitly
ask Claude to add documentation to this reference notebook.
EOF
    echo -e "${GREEN}✓${NC} Created basic CLAUDE.md"
fi

# Create README for the notebook
echo ""
echo "Creating README.md for notebook..."
cat > "$NOTEBOOK_DIR/README.md" << 'EOF'
# AI Reference Notebook

This is a reference notebook for AI-generated documentation, code examples, and learning materials.

## Organization

- `code-examples/` - Reusable code snippets and complete examples
- `documentation/` - Technical documentation and API references
- `guides/` - How-to guides and tutorials
- `snippets/` - Small code snippets and one-liners
- `troubleshooting/` - Problem-solving guides and debugging notes

## Usage

This notebook is designed to work with:
- **Obsidian** - for viewing and organizing notes with links and tags
- **Claude Code** - for generating and updating documentation
- **Git** - for version control and backup

## Workflow

1. During Claude Code sessions, explicitly request documentation to be added here
2. Claude will create or update markdown files with proper formatting
3. Optionally commit and push changes to GitHub for backup
4. Browse and organize notes in Obsidian

## Tips

- Use tags to categorize notes (e.g., #python, #linux, #networking)
- Link related notes together using `[[note-name]]` syntax
- Include code blocks with proper syntax highlighting
- Add front matter with metadata (date, tags, related topics)
EOF
echo -e "${GREEN}✓${NC} Created README.md"

# Create a sample index file
echo ""
echo "Creating index.md..."
cat > "$NOTEBOOK_DIR/index.md" << 'EOF'
# AI Reference Notebook - Index

Welcome to your AI reference notebook! This is your personal knowledge base for development insights and reference materials.

## Recent Notes

<!-- Add links to recent notes here -->

## Topics

### Programming Languages
- [[Python]]
- [[Bash]]
- [[JavaScript]]

### System Administration
- [[Linux Administration]]
- [[Systemd]]
- [[Networking]]

### AI & Machine Learning
- [[LLM Development]]
- [[Model Fine-tuning]]
- [[Prompt Engineering]]

### Tools & Technologies
- [[Git]]
- [[Docker]]
- [[VS Code]]

## Tags

Common tags used in this notebook:
- #code-example
- #troubleshooting
- #reference
- #guide
- #snippet
EOF
echo -e "${GREEN}✓${NC} Created index.md"

# Initialize git repository
echo ""
cd "$NOTEBOOK_DIR"
if [ -d ".git" ]; then
    echo -e "${YELLOW}!${NC} Git repository already initialized"
else
    echo "Initializing git repository..."
    git init
    echo -e "${GREEN}✓${NC} Git repository initialized"

    # Create .gitignore
    cat > .gitignore << 'EOF'
# Obsidian
.obsidian/workspace
.obsidian/workspace.json
.trash/

# OS files
.DS_Store
Thumbs.db

# Temporary files
*.tmp
*~
EOF
    echo -e "${GREEN}✓${NC} Created .gitignore"
fi

# Create Obsidian configuration
echo ""
echo "Creating Obsidian vault configuration..."
mkdir -p "$NOTEBOOK_DIR/.obsidian"

cat > "$NOTEBOOK_DIR/.obsidian/app.json" << 'EOF'
{
  "defaultViewMode": "source",
  "vimMode": false,
  "showLineNumber": true,
  "autoPairBrackets": true,
  "autoPairMarkdown": true,
  "strictLineBreaks": false,
  "showFrontmatter": true
}
EOF

cat > "$NOTEBOOK_DIR/.obsidian/appearance.json" << 'EOF'
{
  "baseFontSize": 16,
  "theme": "moonstone"
}
EOF

cat > "$NOTEBOOK_DIR/.obsidian/core-plugins.json" << 'EOF'
[
  "file-explorer",
  "global-search",
  "switcher",
  "graph",
  "backlink",
  "outgoing-link",
  "tag-pane",
  "page-preview",
  "note-composer",
  "command-palette",
  "markdown-importer",
  "word-count",
  "file-recovery"
]
EOF

echo -e "${GREEN}✓${NC} Created Obsidian configuration"

# Initial git commit
echo ""
if git rev-parse HEAD >/dev/null 2>&1; then
    echo -e "${YELLOW}!${NC} Repository already has commits"
else
    echo "Creating initial commit..."
    git add .
    git commit -m "Initial setup of AI reference notebook

- Created directory structure
- Added CLAUDE.md with instructions
- Added README and index
- Configured Obsidian vault settings"
    echo -e "${GREEN}✓${NC} Created initial commit"
fi

# Ask about GitHub remote
echo ""
echo -e "${BLUE}?${NC} Would you like to create a GitHub remote repository? (y/n)"
read -r CREATE_REMOTE

if [[ "$CREATE_REMOTE" =~ ^[Yy]$ ]]; then
    echo ""
    echo "Creating private GitHub repository..."

    if command -v gh &> /dev/null; then
        if ! git remote get-url origin >/dev/null 2>&1; then
            gh repo create notes-from-ai \
                --private \
                --source=. \
                --remote=origin \
                --description="AI reference notebook - documentation and code examples from Claude Code sessions"

            echo -e "${GREEN}✓${NC} GitHub repository created"

            echo "Pushing to GitHub..."
            git push -u origin main || git push -u origin master
            echo -e "${GREEN}✓${NC} Pushed to GitHub"
        else
            echo -e "${YELLOW}!${NC} Remote 'origin' already exists"
            git remote -v
        fi
    else
        echo -e "${RED}Error: GitHub CLI (gh) not found${NC}"
        echo "Install it with: sudo apt install gh"
        echo "Or skip GitHub setup and configure it manually later"
    fi
else
    echo "Skipping GitHub setup"
fi

echo ""
echo "=========================================="
echo -e "${GREEN}Setup Complete!${NC}"
echo "=========================================="
echo ""
echo "Your AI reference notebook is ready at:"
echo "  $NOTEBOOK_DIR"
echo ""
echo "Next steps:"
echo "  1. Open the directory in Obsidian"
echo "  2. Start using Claude Code and ask it to add docs to the reference notebook"
echo "  3. Organize your notes with links and tags"
echo ""
