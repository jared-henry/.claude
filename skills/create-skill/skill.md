# Skill: create-skill

Create a new skill in this repository.

## Purpose

Scaffold a new skill directory with all required files, following the conventions established by this repo. This is the bootstrapping skill - it eats its own dogfood.

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Skill name in kebab-case (e.g., `add-environment`, `deploy-config`) |
| `description` | Yes | One-line description of what the skill does |
| `has_scripts` | No | Whether the skill needs a `scripts/` directory. Default: no |

## Steps

1. **Validate the name.**
   - Must be kebab-case (lowercase, hyphens, no spaces).
   - Must not already exist in `skills/`.

2. **Create the skill directory.**
   - Path: `skills/<name>/`

3. **Create `skill.md`.**
   - Use the template below. Fill in the name and description.
   - The `Steps` section should have placeholder steps that the user will fill in.

4. **Create `README.md`.**
   - Use the template below. Fill in the name and description.

5. **If `has_scripts` is true, create `scripts/` with a placeholder script.**

6. **Report what was created.**

## Templates

### skill.md template

```markdown
# Skill: <name>

<description>

## Purpose

<Expand on the description. What problem does this solve? When would you use it?>

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `example` | Yes | Description of this input |

## Steps

1. **Step one.** Description of what to do.
2. **Step two.** Description of what to do.

## Outputs

- What gets created or changed.

## Constraints

- Any rules or conventions to follow.
```

### README.md template

```markdown
# <name>

<description>

## Usage

Describe how to invoke or use this skill.

## Examples

Show concrete examples of the skill in action.

## Notes

Any caveats, limitations, or tips.
```

### scripts/ placeholder (if needed)

```bash
#!/usr/bin/env bash
# <name> - supporting script
# Usage: bash scripts/<script-name>.sh [args]
set -e

echo "<name>: not yet implemented"
exit 0
```

## Outputs

- `skills/<name>/skill.md` - Core skill prompt
- `skills/<name>/README.md` - Human-readable docs
- `skills/<name>/scripts/*.sh` - Optional supporting scripts (executable)

## Constraints

- Follow kebab-case naming.
- Every skill must have `skill.md` at minimum.
- Templates are starting points - the user should customize them after scaffolding.
- Do not overwrite existing skills. Error if `skills/<name>/` already exists.
- Scripts must be created with executable permissions.
