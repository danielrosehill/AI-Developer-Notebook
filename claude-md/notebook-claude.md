# CLAUDE.md For AI Reference Notebook

## Purpose

This is Daniel's AI reference notebook - a centralized location for documentation, code examples, and reference materials generated during Claude Code sessions.

## Location

This notebook is located at: `/home/daniel/obsidian-notebooks/notes-from-ai`

## What Goes Here

This notebook should contain:
- Code snippets and examples generated during development
- Technical documentation and explanations
- Reference materials for future use
- Learning notes and insights from AI-assisted development
- Architecture diagrams and design decisions
- Troubleshooting guides and solutions

## Organization

Use Obsidian's linking and tagging features to organize content:
- Tag notes by technology (e.g., #python, #bash, #linux)
- Tag by topic (e.g., #systemd, #networking, #ai)
- Link related notes together
- Create index pages for major topics

## Workflow

When working with Claude Code and you want to save reference material:

1. Explicitly ask Claude to add documentation to the reference notebook
2. Claude will create or update markdown files in this directory
3. Claude can optionally commit and push changes to GitHub
4. View and organize the notes in Obsidian

## Git Integration

This notebook is version-controlled with Git. Changes can be:
- Committed locally for personal history
- Pushed to a private GitHub repository for backup
- Synced across multiple machines

## Best Practices

1. **Descriptive filenames**: Use clear, searchable names
2. **Front matter**: Include metadata (date, tags, related topics)
3. **Links**: Connect related concepts
4. **Code blocks**: Use proper syntax highlighting
5. **Context**: Include enough context to understand notes later

## Example Note Structure

```markdown
---
date: 2025-10-23
tags: [python, asyncio, networking]
related: [[Network Programming]], [[Python Async]]
---

# Async HTTP Client Example

Brief description of what this example demonstrates...

## Code

[code block here]

## Explanation

[detailed explanation]

## Usage

[how to use this code]

## References

- Link to official docs
- Related Stack Overflow discussions
```

## Integration with Claude Code

When Claude Code is invoked from this directory, it understands:
- This is a documentation/reference repository
- Content should be clear and well-structured
- Code examples should be complete and runnable
- Explanations should be thorough but concise
