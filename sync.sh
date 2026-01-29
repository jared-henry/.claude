#!/usr/bin/env bash
# =============================================================================
# .claude Multi-Environment Sync
# =============================================================================
# Routes to the correct environment-specific sync script.
# Sync pulls latest config from the repo and applies it to the local env.
#
# Usage:
#   ./sync.sh                    # Auto-detect environment
#   ./sync.sh <environment>      # Sync for specific environment
#   ./sync.sh --list             # List available environments
#   ./sync.sh --help             # Show help
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_DIR="$SCRIPT_DIR/environments"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; }

list_environments() {
    echo "Available environments:"
    for dir in "$ENV_DIR"/*/; do
        [ -d "$dir" ] || continue
        env_name=$(basename "$dir")
        if [ -f "$dir/sync.sh" ]; then
            echo "  - $env_name"
        fi
    done
}

detect_environment() {
    if [ -f "/proc/ish/version" ] || [[ "$(uname -a)" == *"iSH"* ]]; then
        echo "iphone"
        return
    fi

    if [ -n "$ASHELL" ] || [[ "$(uname -a)" == *"Darwin"* && "$(uname -m)" == "arm64" && -d "/private/var/mobile" ]]; then
        echo "iphone"
        return
    fi

    echo ""
}

show_help() {
    echo "Usage: ./sync.sh [OPTIONS] [ENVIRONMENT]"
    echo ""
    echo "Options:"
    echo "  --list       List available environments"
    echo "  --help       Show this help message"
    echo ""
    echo "Environments:"
    list_environments
}

case "${1:-}" in
    --list|-l)
        list_environments
        exit 0
        ;;
    --help|-h)
        show_help
        exit 0
        ;;
esac

echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║${NC}     .claude Multi-Environment Sync    ${GREEN}║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""

# Pull latest from remote first
info "Pulling latest from remote..."
cd "$SCRIPT_DIR"
if git pull --ff-only 2>/dev/null; then
    success "Repo up to date"
else
    warn "Could not fast-forward. Resolve manually if needed."
fi
echo ""

ENV_NAME="${1:-}"

if [ -z "$ENV_NAME" ]; then
    info "Auto-detecting environment..."
    ENV_NAME=$(detect_environment)

    if [ -z "$ENV_NAME" ]; then
        warn "Could not auto-detect environment."
        echo ""
        list_environments
        echo ""
        read -rp "Enter environment name: " ENV_NAME
    else
        success "Detected: $ENV_NAME"
    fi
fi

ENV_SCRIPT="$ENV_DIR/$ENV_NAME/sync.sh"

if [ ! -f "$ENV_SCRIPT" ]; then
    error "No sync script found for environment: $ENV_NAME"
    echo ""
    list_environments
    exit 1
fi

info "Running $ENV_NAME sync..."
echo ""
bash "$ENV_SCRIPT" "${@:2}"
