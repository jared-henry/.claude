#!/usr/bin/env bash
# =============================================================================
# .claude Uninstall - iPhone 16 Pro Max
# =============================================================================
# Removes Claude Code configuration from iOS.
#
# Usage:
#   bash uninstall.sh           # Interactive uninstall
#   bash uninstall.sh --force   # Skip confirmation
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; }

FORCE=false
[[ "${1:-}" == "--force" || "${1:-}" == "-f" ]] && FORCE=true

echo ""
echo -e "${RED}╔════════════════════════════════════════╗${NC}"
echo -e "${RED}║${NC}    .claude Uninstall - iPhone          ${RED}║${NC}"
echo -e "${RED}╚════════════════════════════════════════╝${NC}"
echo ""

# --- Determine where config lives ---
if [ -f "$HOME/Documents/.claude/.environment" ]; then
    TARGET_DIR="$HOME/Documents/.claude"
elif [ -f "$HOME/.claude/.environment" ]; then
    TARGET_DIR="$HOME/.claude"
else
    error "No .claude installation found."
    exit 1
fi

info "Found installation at: $TARGET_DIR"

# --- Confirm ---
if [ "$FORCE" != true ]; then
    echo ""
    warn "This will remove: $TARGET_DIR"
    warn "The git repo and all local config will be deleted."
    echo ""
    read -rp "Are you sure? (y/N): " confirm
    if [[ "$confirm" != [yY] ]]; then
        info "Cancelled."
        exit 0
    fi
fi

# --- Remove generated files (keep repo if we're inside it) ---
info "Removing generated files..."

# Remove local settings
rm -f "$TARGET_DIR/settings.local.json"
rm -f "$TARGET_DIR/.environment"

# Remove runtime directories
for dir in debug plans session-env shell-snapshots statsig todos ide projects; do
    rm -rf "${TARGET_DIR:?}/$dir"
done

success "Generated files removed"

# --- Full removal ---
if [ "$FORCE" = true ]; then
    info "Removing entire .claude directory..."
    rm -rf "$TARGET_DIR"
    success "Fully removed: $TARGET_DIR"
else
    info "Repo files preserved at: $TARGET_DIR"
    info "To fully remove: rm -rf $TARGET_DIR"
fi

echo ""
echo -e "${GREEN}Uninstall complete.${NC}"
echo ""
