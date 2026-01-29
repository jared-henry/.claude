# Skills

Skills are self-contained, reusable Claude Code capabilities.

## Skill Structure

Every skill follows this layout:

```
skills/<name>/
├── skill.md          # Core prompt - instructions Claude follows to execute
├── README.md         # Human-readable docs (what, why, usage, examples)
└── scripts/          # Optional shell scripts the skill can invoke
    └── *.sh
```

### skill.md

The executable specification. Claude reads this to know what to do. It defines:

- **Purpose**: What the skill does
- **Inputs**: What information is needed
- **Steps**: The procedure to follow
- **Outputs**: What gets created or changed
- **Constraints**: Rules and conventions to follow

### README.md

Human-facing documentation. Quick overview, usage examples, known limitations.

### scripts/

Optional. For skills that need to run shell commands, file scaffolding, or other automation.

## Conventions

- Skill names use kebab-case: `create-skill`, `add-environment`
- `skill.md` is always present - it's the minimum viable skill
- Skills should be self-documenting and dogfood their own conventions
- When a skill creates files, it follows the patterns established in this repo
