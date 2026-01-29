#!/usr/bin/env bash
# Pre-push hook template - copy to .git/hooks/pre-push
set -e

echo "Running pre-push checks..."

npm test || { echo "Tests failed. Push aborted."; exit 1; }
npm run typecheck || { echo "Type check failed. Push aborted."; exit 1; }

echo "All checks passed!"
exit 0
