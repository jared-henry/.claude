# iPhone 16 Pro Max Environment

Claude Code configuration for iOS via terminal emulators.

## Supported Terminal Apps

| App | Shell | Package Manager | Notes |
|-----|-------|-----------------|-------|
| **iSH** | Alpine Linux (ash) | apk | Full Linux userland, x86 emulation |
| **a-Shell** | BSD-like | `pkg` (limited) | Native ARM, iOS sandbox restrictions |

## Prerequisites

- iPhone 16 Pro Max (or any iOS 17+ device)
- One of the supported terminal apps installed from the App Store
- Git available in the terminal app

### iSH Setup

```sh
apk add git bash curl openssh
```

### a-Shell Setup

Git is built in. No additional setup needed.

## Limitations

- No background processes (iOS suspends apps)
- Filesystem is sandboxed per app
- No system-wide PATH modifications
- SSH keys must be generated within the terminal app
- Claude Code CLI may not run natively; these configs are for syncing to environments where it does run

## File Paths

- **iSH**: `~/` maps to `/root/` or `/home/user/`
- **a-Shell**: `~/Documents/` is the persistent writable directory
