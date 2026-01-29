#!/usr/bin/env bash
# =============================================================================
# .claude Install - iPhone 16 Pro Max
# =============================================================================
# Installs Claude Code configuration on iOS via iSH or a-Shell.
#
# Usage:
#   bash install.sh           # Interactive install
#   bash install.sh --force   # Overwrite existing config
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
error()   { echo -e "${RED}[ERROR]${NC} $1"; }

FORCE=false
[[ "${1:-}" == "--force" || "${1:-}" == "-f" ]] && FORCE=true

# --- Detect iOS terminal app ---
detect_terminal_app() {
    if [ -f "/proc/ish/version" ] || [[ "$(uname -a)" == *"iSH"* ]]; then
        echo "ish"
    elif [ -n "$ASHELL" ]; then
        echo "ashell"
    else
        echo "unknown"
    fi
}

echo ""
echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${NC}    .claude Install - iPhone            ${BLUE}║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

TERMINAL_APP=$(detect_terminal_app)
info "Terminal app: $TERMINAL_APP"

# --- Determine target directory ---
case "$TERMINAL_APP" in
    ish)
        TARGET_DIR="$HOME/.claude"
        ;;
    ashell)
        # a-Shell persists files in ~/Documents
        TARGET_DIR="$HOME/Documents/.claude"
        ;;
    *)
        warn "Unknown iOS terminal. Defaulting to ~/.claude"
        TARGET_DIR="$HOME/.claude"
        ;;
esac

info "Target directory: $TARGET_DIR"

# --- Install dependencies (iSH only) ---
if [ "$TERMINAL_APP" = "ish" ]; then
    info "Checking iSH dependencies..."
    for pkg in git bash curl; do
        if ! command -v "$pkg" &>/dev/null; then
            info "Installing $pkg..."
            apk add "$pkg" 2>/dev/null || warn "Could not install $pkg"
        fi
    done
    success "Dependencies satisfied"
fi

# --- Create target directory ---
if [ "$REPO_ROOT" = "$TARGET_DIR" ]; then
    info "Repo is already at target location"
else
    if [ -d "$TARGET_DIR" ] && [ "$FORCE" != true ]; then
        error "$TARGET_DIR already exists. Use --force to overwrite."
        exit 1
    fi

    if [ -d "$TARGET_DIR" ] && [ "$FORCE" = true ]; then
        warn "Backing up existing config to ${TARGET_DIR}.backup"
        rm -rf "${TARGET_DIR}.backup"
        mv "$TARGET_DIR" "${TARGET_DIR}.backup"
    fi

    info "Copying config to $TARGET_DIR..."
    cp -r "$REPO_ROOT" "$TARGET_DIR"
    success "Copied"
fi

# --- Symlink shared configs into expected Claude Code locations ---
CLAUDE_CONFIG="$TARGET_DIR"

link_shared() {
    local src="$1"
    local dst="$2"

    if [ -e "$dst" ] && [ "$FORCE" != true ]; then
        warn "Skipping $dst (already exists)"
        return
    fi

    mkdir -p "$(dirname "$dst")"
    rm -f "$dst"
    ln -sf "$src" "$dst" 2>/dev/null || cp -f "$src" "$dst"
}

info "Linking shared configs..."
for dir in commands hooks prompts templates; do
    if [ -d "$CLAUDE_CONFIG/shared/$dir" ]; then
        success "  $dir/"
    fi
done

# --- Make hooks executable ---
if [ -d "$CLAUDE_CONFIG/shared/hooks" ]; then
    chmod +x "$CLAUDE_CONFIG/shared/hooks/"*.sh 2>/dev/null || true
    success "Hooks are executable"
fi

# --- Create local settings if missing ---
if [ ! -f "$CLAUDE_CONFIG/settings.local.json" ]; then
    cat > "$CLAUDE_CONFIG/settings.local.json" << 'EOF'
{
  "env": {},
  "_environment": "iphone",
  "_terminal": "auto-detected"
}
EOF
    success "Created settings.local.json"
fi

# --- Write environment marker ---
echo "iphone" > "$CLAUDE_CONFIG/.environment"
success "Environment marker set"

# --- Summary ---
echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║${NC}        Installation Complete!          ${GREEN}║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo "Installed to: $TARGET_DIR"
echo "Terminal app: $TERMINAL_APP"
echo ""
echo "Next steps:"
echo "  1. Review shared/prompts/ and customize"
echo "  2. Run ./sync.sh iphone to pull latest config"
echo ""
