# .claude

Multi-environment Claude Code configuration. Clone once, install anywhere.

## Structure

```
.claude/
├── install.sh                  # Entry point (auto-detects or prompts)
├── uninstall.sh                # Entry point
├── sync.sh                     # Entry point (git pull + env-specific sync)
├── shared/                     # Config shared across all environments
│   ├── commands/               # Custom slash commands
│   ├── hooks/                  # Automation hooks
│   ├── prompts/                # System prompts & standards
│   ├── settings/               # Base settings.json
│   └── templates/              # Reusable templates (CLAUDE.md, git hooks)
└── environments/               # Per-environment scripts
    └── iphone/                 # iPhone 16 Pro Max (iSH / a-Shell)
        ├── install.sh
        ├── uninstall.sh
        ├── sync.sh
        └── README.md
```

## Quick Start

```bash
git clone git@github.com:jared-henry/.claude.git ~/.claude
cd ~/.claude
./install.sh                    # auto-detect environment
./install.sh iphone             # or specify explicitly
```

## Supported Environments

| Environment | Status | Notes |
|-------------|--------|-------|
| iPhone 16 Pro Max | Supported | via iSH or a-Shell |

More environments will be added over time.

## Commands

| Command | Description |
|---------|-------------|
| `./install.sh [env]` | Install config for an environment |
| `./uninstall.sh [env]` | Remove config for an environment |
| `./sync.sh [env]` | Pull latest + apply env-specific sync |
| `./install.sh --list` | List available environments |

## Adding a New Environment

1. Create `environments/<name>/`
2. Add `install.sh`, `uninstall.sh`, `sync.sh`
3. Optionally add a `README.md` with env-specific docs
4. Update detection logic in the top-level scripts if auto-detect is possible

## Files Not Tracked

See `.gitignore`. Runtime data, local settings, secrets, and session data are excluded.
