# create-skill

Scaffold a new skill in this repository with all required files and conventions.

## Usage

Ask Claude to create a new skill:

```
Create a skill called "add-environment" that scaffolds a new environment directory with install, uninstall, and sync scripts.
```

Or more concisely:

```
Use the create-skill skill to make a new skill called "lint-config" - it validates Claude Code settings files.
```

Claude will read `skills/create-skill/skill.md` and follow the procedure to scaffold the new skill directory.

## What Gets Created

```
skills/<name>/
├── skill.md          # Core prompt (filled with templates, ready to customize)
├── README.md         # Human-facing docs
└── scripts/          # Only if requested
    └── placeholder.sh
```

## Examples

**Minimal skill (no scripts):**
```
Create a skill called "review-pr" that reviews pull requests against coding standards.
```

Creates:
```
skills/review-pr/
├── skill.md
└── README.md
```

**Skill with scripts:**
```
Create a skill called "setup-hooks" that installs git hooks into a project. It needs scripts.
```

Creates:
```
skills/setup-hooks/
├── skill.md
├── README.md
└── scripts/
    └── placeholder.sh
```

## Notes

- This is the meta-skill: it created its own structure and follows its own conventions.
- After scaffolding, you should customize the generated `skill.md` with real steps and inputs.
- Skill names must be kebab-case.
