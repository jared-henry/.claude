#!/usr/bin/env bash
# =============================================================================
# Pre-push Hook Template
# =============================================================================
# Copy this to your project's .git/hooks/pre-push
# This runs before pushing to remote.
# =============================================================================

set -e

echo "Running pre-push checks..."

# Run tests
npm test || {
    echo "Tests failed. Push aborted."
    exit 1
}

# Run type check
npm run typecheck || {
    echo "Type check failed. Push aborted."
    exit 1
}

echo "All checks passed!"
exit 0
