#!/usr/bin/env bash
# =============================================================================
# Pre-tool-use Hook for Claude Code
# =============================================================================
# This hook runs before Claude executes a tool.
# Environment variables available:
#   - CLAUDE_TOOL_NAME: Name of the tool being executed
#   - CLAUDE_TOOL_INPUT: JSON input to the tool
#
# Exit 0 to allow the tool, non-zero to block it.
# =============================================================================

set -e

# Example: Block dangerous commands
# if [[ "$CLAUDE_TOOL_NAME" == "Bash" ]]; then
#     if echo "$CLAUDE_TOOL_INPUT" | grep -qE "rm -rf|sudo|chmod 777"; then
#         echo "Blocked potentially dangerous command"
#         exit 1
#     fi
# fi

# Example: Log tool usage
# echo "$(date): Tool $CLAUDE_TOOL_NAME used" >> ~/.claude/logs/tools.log

exit 0
