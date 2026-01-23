#!/usr/bin/env bash
# =============================================================================
# Post-session Hook for Claude Code
# =============================================================================
# This hook runs after a Claude Code session ends.
# Use it for cleanup, logging, or notifications.
# =============================================================================

set -e

# Example: Log session end time
# echo "$(date): Session ended in $(pwd)" >> ~/.claude/logs/sessions.log

# Example: Send notification
# osascript -e 'display notification "Claude Code session ended" with title "Claude Code"'

# Example: Cleanup temporary files
# find . -name "*.tmp" -delete

exit 0
