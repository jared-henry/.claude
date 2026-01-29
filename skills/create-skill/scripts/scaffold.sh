#!/usr/bin/env bash
# =============================================================================
# create-skill scaffold script
# =============================================================================
# Scaffolds a new skill directory from templates.
#
# Usage:
#   bash scripts/scaffold.sh <name> <description> [--scripts]
#
# Examples:
#   bash scripts/scaffold.sh add-environment "Scaffold a new environment"
#   bash scripts/scaffold.sh deploy-config "Deploy config to remote" --scripts
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; }

# --- Parse arguments ---
NAME="${1:-}"
DESCRIPTION="${2:-}"
HAS_SCRIPTS=false

for arg in "$@"; do
    [[ "$arg" == "--scripts" ]] && HAS_SCRIPTS=true
done

if [ -z "$NAME" ] || [ -z "$DESCRIPTION" ]; then
    echo "Usage: bash scripts/scaffold.sh <name> <description> [--scripts]"
    echo ""
    echo "  name          Skill name in kebab-case"
    echo "  description   One-line description (quote it)"
    echo "  --scripts     Include a scripts/ directory"
    exit 1
fi

# --- Validate name ---
if [[ ! "$NAME" =~ ^[a-z][a-z0-9-]*$ ]]; then
    error "Name must be kebab-case (lowercase letters, numbers, hyphens): $NAME"
    exit 1
fi

SKILL_DIR="$SKILLS_DIR/$NAME"

if [ -d "$SKILL_DIR" ]; then
    error "Skill already exists: $SKILL_DIR"
    exit 1
fi

# --- Scaffold ---
info "Creating skill: $NAME"
mkdir -p "$SKILL_DIR"

# skill.md
cat > "$SKILL_DIR/skill.md" << EOF
# Skill: $NAME

$DESCRIPTION

## Purpose

<!-- Expand on the description. What problem does this solve? When would you use it? -->

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| \`example\` | Yes | Description of this input |

## Steps

1. **Step one.** Description of what to do.
2. **Step two.** Description of what to do.

## Outputs

- What gets created or changed.

## Constraints

- Any rules or conventions to follow.
EOF
success "Created $NAME/skill.md"

# README.md
cat > "$SKILL_DIR/README.md" << EOF
# $NAME

$DESCRIPTION

## Usage

Describe how to invoke or use this skill.

## Examples

Show concrete examples of the skill in action.

## Notes

Any caveats, limitations, or tips.
EOF
success "Created $NAME/README.md"

# scripts/ (optional)
if [ "$HAS_SCRIPTS" = true ]; then
    mkdir -p "$SKILL_DIR/scripts"
    cat > "$SKILL_DIR/scripts/placeholder.sh" << EOF
#!/usr/bin/env bash
# $NAME - supporting script
# Usage: bash scripts/placeholder.sh [args]
set -e

echo "$NAME: not yet implemented"
exit 0
EOF
    chmod +x "$SKILL_DIR/scripts/placeholder.sh"
    success "Created $NAME/scripts/placeholder.sh"
fi

# --- Done ---
echo ""
success "Skill scaffolded: $SKILL_DIR"
echo ""
echo "Files created:"
find "$SKILL_DIR" -type f | sort | while read -r f; do
    echo "  ${f#$SKILLS_DIR/}"
done
echo ""
echo "Next: edit $NAME/skill.md with your actual steps and inputs."
