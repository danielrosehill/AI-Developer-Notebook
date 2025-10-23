# AI Developer Notebook

A toolkit for managing Claude Code configuration snippets and reference documentation across your development environment.

## Overview

This repository contains scripts and snippets to help maintain consistent Claude Code behavior across different directories and manage a centralized reference notebook for AI-generated documentation.

## Directory Structure

```
AI-Developer-Notebook/
├── README.md                       # This file
├── setup.sh                        # Master setup script (runs all)
├── snippets/                       # Configuration snippets
│   └── for-main-claude.md         # Snippet to inject into ~/CLAUDE.md
├── scripts/                        # Individual automation scripts
│   ├── inject-claude-snippet.sh   # Injects snippet into ~/CLAUDE.md
│   └── setup-notebook.sh          # Sets up reference notebook
└── claude-md/                      # Template CLAUDE.md files
    └── notebook-claude.md         # CLAUDE.md for reference notebook
```

## Scripts

### `inject-claude-snippet.sh`

Injects the content from `snippets/for-main-claude.md` into `~/CLAUDE.md`.

**Usage:**
```bash
./scripts/inject-claude-snippet.sh
```

**What it does:**
- Checks if the snippet section already exists in ~/CLAUDE.md
- If not present, appends the snippet to ~/CLAUDE.md
- If already present, updates the existing section
- Creates ~/CLAUDE.md if it doesn't exist

### `setup-notebook.sh`

Sets up the reference notebook directory structure for Obsidian.

**Usage:**
```bash
./scripts/setup-notebook.sh
```

**What it does:**
- Creates `/home/daniel/obsidian-notebooks/notes-from-ai` directory
- Initializes it as a git repository (if not already)
- Creates a GitHub remote repository (if requested)
- Populates CLAUDE.md in the notebook directory
- Creates basic Obsidian vault structure

### `setup.sh` (Master Script)

Master setup script located at the repository root that runs all setup operations.

**Usage:**
```bash
./setup.sh
```

**What it does:**
- Runs `inject-claude-snippet.sh`
- Runs `setup-notebook.sh`
- Provides status updates for each operation

## Setup

1. Clone this repository:
   ```bash
   cd ~/repos/github
   git clone <repository-url> AI-Developer-Notebook
   cd AI-Developer-Notebook
   ```

2. Run the setup script:
   ```bash
   ./setup.sh
   ```

## Usage Scenarios

### First-time Setup
Run `./setup.sh` from the repository root to configure everything at once.

### Update Claude Instructions
After modifying `snippets/for-main-claude.md`, run:
```bash
./scripts/inject-claude-snippet.sh
```

### Reinitialize Notebook
If you need to recreate or update the notebook structure:
```bash
./scripts/setup-notebook.sh
```

## Snippets

### `for-main-claude.md`

This snippet provides instructions to Claude Code about managing the reference notebook located in `/home/daniel/obsidian-notebooks/notes-from-ai`. It's injected into `~/CLAUDE.md` so Claude knows where to store reference documentation when working from the home directory.

## Reference Notebook

The reference notebook is an Obsidian vault located at:
```
/home/daniel/obsidian-notebooks/notes-from-ai
```

This is where Claude Code will store documentation, code examples, and other reference materials when you explicitly request it during development sessions.

## Maintenance

### Updating Snippets
1. Edit files in `snippets/` directory
2. Run the corresponding injection script
3. Commit changes to this repository

### Version Control
All scripts support git operations and can automatically commit changes. The notebook directory can optionally be version-controlled with its own GitHub repository.

## Requirements

- Bash shell
- Git
- GitHub CLI (`gh`) - for creating remote repositories
- Obsidian (optional, for viewing the reference notebook)

## License

This is a personal toolkit. Use and modify as needed.