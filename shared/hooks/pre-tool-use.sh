#!/usr/bin/env bash
# Pre-tool-use hook - runs before Claude executes a tool.
# Available env vars: CLAUDE_TOOL_NAME, CLAUDE_TOOL_INPUT
# Exit 0 to allow, non-zero to block.
set -e
exit 0
