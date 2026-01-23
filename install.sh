#!/usr/bin/env bash
# =============================================================================
# .claude Installation Script
# =============================================================================
# Bootstrap script for setting up Claude Code configuration on a new machine.
#
# Usage:
#   ./install.sh           # Interactive install
#   ./install.sh --force   # Overwrite existing files
# =============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

# Flags
FORCE=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --force|-f)
            FORCE=true
            shift
            ;;
        --help|-h)
            echo "Usage: ./install.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  -f, --force    Overwrite existing files"
            echo "  -h, --help     Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Helper functions
info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Header
echo ""
echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${NC}    .claude Configuration Installer     ${BLUE}║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Check if we're in the right directory
if [[ "$SCRIPT_DIR" != "$CLAUDE_DIR" ]]; then
    warn "Script is not in ~/.claude"
    info "Moving repository to ~/.claude..."

    if [[ -d "$CLAUDE_DIR" ]] && [[ "$FORCE" != true ]]; then
        error "~/.claude already exists. Use --force to overwrite."
        exit 1
    fi

    # Backup existing if force
    if [[ -d "$CLAUDE_DIR" ]] && [[ "$FORCE" == true ]]; then
        warn "Backing up existing ~/.claude to ~/.claude.backup"
        rm -rf "$CLAUDE_DIR.backup"
        mv "$CLAUDE_DIR" "$CLAUDE_DIR.backup"
    fi

    cp -r "$SCRIPT_DIR" "$CLAUDE_DIR"
    success "Copied to ~/.claude"
fi

# Make hooks executable
info "Setting up hooks..."
if [[ -d "$CLAUDE_DIR/hooks" ]]; then
    chmod +x "$CLAUDE_DIR/hooks/"*.sh 2>/dev/null || true
    success "Hooks are executable"
else
    warn "No hooks directory found"
fi

# Make templates executable
info "Setting up templates..."
if [[ -d "$CLAUDE_DIR/templates/hooks" ]]; then
    chmod +x "$CLAUDE_DIR/templates/hooks/"*.sh 2>/dev/null || true
    success "Template hooks are executable"
fi

# Check for Claude Code CLI
info "Checking for Claude Code..."
if command -v claude &> /dev/null; then
    success "Claude Code CLI found: $(which claude)"
else
    warn "Claude Code CLI not found in PATH"
    echo "  Install from: https://claude.ai/code"
fi

# Create local settings if not exists
if [[ ! -f "$CLAUDE_DIR/settings.local.json" ]]; then
    info "Creating local settings template..."
    cat > "$CLAUDE_DIR/settings.local.json" << 'EOF'
{
  "env": {
    "EDITOR": "code --wait"
  }
}
EOF
    success "Created settings.local.json (customize as needed)"
else
    info "settings.local.json already exists, skipping"
fi

# Summary
echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║${NC}        Installation Complete!          ${GREEN}║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo "Your .claude configuration is ready at: $CLAUDE_DIR"
echo ""
echo "Next steps:"
echo "  1. Review and customize prompts in ~/.claude/prompts/"
echo "  2. Add project configs in ~/.claude/projects-config/"
echo "  3. Enable hooks as needed in ~/.claude/hooks/"
echo ""
echo "To sync changes:"
echo "  cd ~/.claude && git add -A && git commit -m 'Update' && git push"
echo ""
