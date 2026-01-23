# .claude

Personal Claude Code configuration and dotfiles.

## Overview

This repository contains my Claude Code configurations, custom prompts, hooks, and templates. It's designed to be portable across machines and provides a consistent Claude Code experience.

## Structure

```
~/.claude/
├── settings/           # Claude Code settings
│   └── settings.json   # Global settings (tracked)
├── prompts/            # Custom system prompts
│   ├── system.md       # Global system prompt
│   ├── coding.md       # Coding standards
│   └── review.md       # Code review guidelines
├── hooks/              # Automation hooks
│   ├── pre-commit.sh   # Runs before commits
│   ├── post-session.sh # Runs after sessions
│   └── pre-tool-use.sh # Runs before tool execution
├── commands/           # Custom slash commands
│   ├── commit.md       # Smart commit command
│   ├── review.md       # Code review command
│   └── explain.md      # Code explanation command
├── templates/          # Reusable templates
│   ├── CLAUDE.md       # Project CLAUDE.md template
│   └── hooks/          # Git hook templates
├── projects-config/    # Project-specific configs
│   └── *.md            # Per-project instructions
├── install.sh          # Bootstrap script
└── README.md           # This file
```

## Installation

### Fresh Install

```bash
git clone git@github.com:jared-henry/.claude.git ~/.claude
cd ~/.claude
./install.sh
```

### Existing Claude Code Installation

If you already have Claude Code installed with runtime data in `~/.claude`:

```bash
cd ~/.claude
git init
git remote add origin git@github.com:jared-henry/.claude.git
git fetch
git checkout -b main --track origin/main
```

## Usage

### Custom Prompts

Prompts in `prompts/` can be referenced in your projects or loaded globally:

- `system.md` - Applied to all sessions
- `coding.md` - Use for development tasks
- `review.md` - Use for code reviews

### Hooks

Hooks in `hooks/` automate common tasks:

| Hook | Trigger | Purpose |
|------|---------|---------|
| `pre-commit.sh` | Before commit | Validation, linting |
| `post-session.sh` | Session end | Cleanup, logging |
| `pre-tool-use.sh` | Before tools | Security, auditing |

### Templates

Copy templates to new projects:

```bash
cp ~/.claude/templates/CLAUDE.md ~/my-project/CLAUDE.md
```

### Project Configs

Add project-specific instructions in `projects-config/`:

```bash
# Create config for a project
touch ~/.claude/projects-config/my-project.md
```

## Customization

### Adding a New Prompt

1. Create a new `.md` file in `prompts/`
2. Add your instructions in markdown format
3. Reference it in your project's CLAUDE.md

### Adding a New Hook

1. Create a new `.sh` file in `hooks/`
2. Make it executable: `chmod +x hooks/your-hook.sh`
3. Exit 0 to allow, non-zero to block

### Adding a New Command

1. Create a new `.md` file in `commands/`
2. Document usage and behavior
3. Use with `/command-name` in Claude Code

## Syncing

Keep your configs in sync across machines:

```bash
# Pull latest changes
cd ~/.claude && git pull

# Push your changes
cd ~/.claude && git add -A && git commit -m "Update configs" && git push
```

## Files Not Tracked

The following are automatically excluded (see `.gitignore`):

- `settings.local.json` - Machine-specific settings
- `debug/` - Debug logs
- `plans/` - Session plans
- `projects/` - Project session data
- `session-env/` - Session environment
- `shell-snapshots/` - Shell state
- `statsig/` - Analytics
- `todos/` - Todo state

## License

Personal configuration - use as inspiration for your own setup.
