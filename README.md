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
├── skills/                     # Reusable Claude Code skills
│   ├── README.md               # Skills conventions & structure docs
│   └── create-skill/           # Meta-skill: scaffold new skills
│       ├── skill.md            # Executable prompt Claude follows
│       ├── README.md           # Human-facing docs
│       └── scripts/            # Shell automation
│           └── scaffold.sh     # Standalone scaffolding script
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

## Skills

Skills are reusable Claude Code capabilities. Each skill lives in `skills/<name>/` and contains a `skill.md` (the prompt Claude follows), a `README.md` (human docs), and optionally a `scripts/` directory.

| Skill | Description |
|-------|-------------|
| `create-skill` | Scaffold a new skill (the meta-skill) |

To create a new skill, ask Claude:

```
Use the create-skill skill to make a new skill called "my-skill" - it does XYZ.
```

Or run the scaffold script directly:

```bash
cd skills/create-skill
bash scripts/scaffold.sh my-skill "Description of what it does" --scripts
```

See `skills/README.md` for conventions.

## Adding a New Environment

1. Create `environments/<name>/`
2. Add `install.sh`, `uninstall.sh`, `sync.sh`
3. Optionally add a `README.md` with env-specific docs
4. Update detection logic in the top-level scripts if auto-detect is possible

## Files Not Tracked

See `.gitignore`. Runtime data, local settings, secrets, and session data are excluded.
