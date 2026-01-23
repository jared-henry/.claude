# /commit - Smart Commit Command

Generate a meaningful commit message based on staged changes.

## Usage

```
/commit
/commit -m "optional message"
```

## Behavior

1. Analyze staged changes with `git diff --staged`
2. Generate a conventional commit message
3. Create the commit with the generated message

## Commit Format

Follow conventional commits:
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation
- `style:` Formatting
- `refactor:` Code restructuring
- `test:` Adding tests
- `chore:` Maintenance
