#!/usr/bin/env bash
# =============================================================================
# Pre-commit Hook for Claude Code
# =============================================================================
# This hook runs before Claude commits changes.
# Add your validation logic here.
#
# Exit 0 to allow the commit, non-zero to block it.
# =============================================================================

set -e

# Example: Check for debug statements
# if grep -r "console.log\|debugger\|print(" --include="*.js" --include="*.ts" --include="*.py" .; then
#     echo "Warning: Debug statements found. Please remove before committing."
#     exit 1
# fi

# Example: Run linter
# npm run lint --silent || exit 1

# Example: Run tests
# npm test --silent || exit 1

exit 0
