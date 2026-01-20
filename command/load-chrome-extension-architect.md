---
description: Load Chrome Extension Architect skill for privacy-first MV3 extension development
---

Load the Chrome Extension Architect skill and help with browser extension architecture, permissions audits, and debugging.

## Workflow

### Step 1: Check for --update-skill flag

If $ARGUMENTS contains `--update-skill`:

1. Determine install location by checking which exists:
   - Local: `.opencode/skill/chrome-extension-architect/`
   - Global: `~/.config/opencode/skill/chrome-extension-architect/`

2. Run the install command from the skill:

   ```bash
   bash <(curl -fsSL https://raw.githubusercontent.com/Alcyone-Labs/chrome-extension-agent-skill/main/resources/install.sh)
   ```

3. Output success message and stop.

### Step 2: Load skill

```
skill({ name: 'chrome-extension-architect' })
```

### Step 3: Identify task type from user request

Analyze $ARGUMENTS to determine:

- **Browser target** (Chrome/Edge, Firefox, Safari, or cross-browser)
- **Task category** (side panel, permissions, service worker lifecycle, storage, debugging, templates)
- **Data sensitivity** (what user data is touched)

Use the decision tree in SKILL.md to select correct references.

### Step 4: Read relevant reference files

Based on task type, read from `references/<category>/`:

| Task                           | Files to Read                                   |
| ------------------------------ | ----------------------------------------------- |
| Side panel/sidebar design      | `references/sidepanel/README.md`                |
| Permission review/minimization | `references/permissions/README.md`              |
| Service worker lifecycle bugs  | `references/service-worker-lifecycle/README.md` |
| Storage/persistence decisions  | `references/storage-state/README.md`            |
| Cross-browser compatibility    | `references/cross-browser/README.md`            |
| Debugging broken extension     | `references/debugging/README.md`                |
| Quick start / boilerplate      | `references/templates/README.md`                |

### Step 5: Execute task

Apply Chrome MV3 privacy-first patterns and APIs from references to complete the user's request.

### Step 6: Summarize

```
=== Chrome Extension MV3 Task Complete ===

Target: <Chrome MV3 | Firefox | Safari | Cross-browser>
Focus: <sidepanel | permissions | lifecycle | storage | debugging>
Files referenced: <reference files consulted>

<brief summary of what was done>
```

<user-request>
$ARGUMENTS
</user-request>
