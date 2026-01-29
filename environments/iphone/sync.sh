#!/usr/bin/env bash
# =============================================================================
# .claude Sync - iPhone 16 Pro Max
# =============================================================================
# Syncs shared configs into the local Claude Code configuration.
# The top-level sync.sh handles git pull; this script handles
# iPhone-specific post-sync tasks.
#
# Usage:
#   bash sync.sh
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SHARED_DIR="$REPO_ROOT/shared"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }

echo -e "${BLUE}[SYNC]${NC} iPhone environment"
echo ""

# --- Ensure hooks are executable ---
info "Updating hook permissions..."
chmod +x "$SHARED_DIR/hooks/"*.sh 2>/dev/null || true
chmod +x "$SHARED_DIR/templates/hooks/"*.sh 2>/dev/null || true
success "Hooks executable"

# --- Verify shared config integrity ---
info "Verifying shared configs..."
missing=0
for expected in settings/settings.json prompts/system.md hooks/pre-commit.sh; do
    if [ ! -f "$SHARED_DIR/$expected" ]; then
        warn "Missing: shared/$expected"
        missing=$((missing + 1))
    fi
done

if [ "$missing" -eq 0 ]; then
    success "All shared configs present"
else
    warn "$missing shared config(s) missing"
fi

# --- Update environment marker ---
echo "iphone" > "$REPO_ROOT/.environment"

# --- iOS-specific: check storage ---
info "Checking available storage..."
if command -v df &>/dev/null; then
    avail=$(df -h "$REPO_ROOT" 2>/dev/null | tail -1 | awk '{print $4}')
    if [ -n "$avail" ]; then
        info "Available disk space: $avail"
    fi
fi

echo ""
echo -e "${GREEN}[SYNC]${NC} iPhone sync complete."
echo ""
