# Chrome Extension Agent Skill

Privacy-first Chrome Manifest V3 extension development skill for AI agents.

## Overview

This skill provides elite-level guidance for building modern browser extensions with:

- **Privacy-first defaults**: Minimize data collection and host permissions
- **Least-privilege permissions**: Request only what's absolutely necessary
- **Service worker lifecycle mastery**: Survive termination bugs
- **Side panel architecture**: Modern Chrome sidePanel API with cross-browser compatibility
- **Storage strategies**: Choose the right storage for each use case
- **Debugging playbook**: Fix the most common MV3 extension bugs

## Installation

### OpenCode

```bash
cd /path/to/your/project
bash <(curl -fsSL https://raw.githubusercontent.com/Alcyone-Labs/chrome-extension-agent-skill/main/resources/install.sh) --local

# Or globally
bash <(curl -fsSL https://raw.githubusercontent.com/Alcyone-Labs/chrome-extension-agent-skill/main/resources/install.sh) --global
```

Then load the skill in OpenCode:

```
/load-chrome-extension-architect Build a side panel note-taker
```

### Gemini CLI

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Alcyone-Labs/chrome-extension-agent-skill/main/resources/install.sh)
```

Then use:

```bash
/skill chrome-extension-architect Why does my service worker lose state?
```

### FactoryAI Droid

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Alcyone-Labs/chrome-extension-agent-skill/main/resources/install.sh)
```

Then use:

```bash
/skill chrome-extension-architect Debug my extension permissions
```

## Usage

### OpenCode

```
/load-chrome-extension-architect Build a side panel note-taker
/load-chrome-extension-architect Audit my extension permissions
/load-chrome-extension-architect Debug why my service worker loses state
```

### Gemini CLI

```bash
/skill chrome-extension-architect Build a privacy-first side panel extension
/skill chrome-extension-architect Review my permission list
```

### FactoryAI Droid

```bash
/skill chrome-extension-architect Make my extension work in Firefox
/skill chrome-extension-architect Fix storage persistence issues
```

## Skill Contents

### Main File

- `SKILL.md` : Core skill definition with workflow instructions

### Reference Guides

- `references/sidepanel/README.md`: Chrome sidePanel API, Firefox sidebarAction, Safari fallbacks
- `references/permissions/README.md`: Least-privilege permission design, host permission minimization
- `references/service-worker-lifecycle/README.md`: SW termination, state persistence, event patterns
- `references/storage-state/README.md`: Storage matrix (local/sync/session/IndexedDB), lifecycle awareness
- `references/cross-browser/README.md`: Chrome/Edge vs Firefox vs Safari compatibility, feature detection
- `references/debugging/README.md`: Debugging checklist, common bugs, SW lifecycle debugging
- `references/templates/README.md`: Copy-paste boilerplate for common patterns

### Resources

- `resources/install.sh`: Multi-platform installation script (OpenCode, Gemini, FactoryAI)
- `command/chrome-extension-architect.md`: OpenCode command definition

## Key Features

### 1. Side Panel Architecture

- `chrome.sidePanel` API usage (Chrome 114+)
- `setPanelBehavior({ openPanelOnActionClick: true })`
- Per-tab and global panel options
- Layout awareness (left/right placement)
- Firefox `sidebarAction` compatibility
- Safari fallback strategies

### 2. Permission Minimalism

- Prefer `activeTab` over `<all_urls>`
- Narrow host permissions
- Optional permissions for advanced features
- Privacy risk warnings for each permission
- Web Store approval guidance

### 3. Service Worker Lifecycle

- Top-level listener registration
- Storage-backed state (no globals)
- Async response handling (`return true`)
- WebSocket reconnection
- Alarms for scheduled tasks
- Offscreen documents for DOM work

### 4. Storage Strategy

- `chrome.storage.local` for persistent data
- `chrome.storage.sync` for cross-device settings
- `chrome.storage.session` for ephemeral data
- IndexedDB for large datasets
- Storage matrix: what to use when

### 5. Cross-Browser Compatibility

- Feature detection (no UA-sniffing)
- `webextension-polyfill` usage
- Separate manifest keys per browser
- Fallback UI patterns

### 6. Debugging Playbook

- Service Worker Inspector usage
- Termination testing
- Message tracing
- Storage monitoring
- Common bug fixes

## Privacy Philosophy

This skill emphasizes:

1. **Data minimization**: Only collect what's necessary
2. **On-device processing**: Prefer local storage over remote
3. **Transparency**: Warn users about privacy implications of every permission
4. **User control**: Allow users to disable data collection features
5. **Default safe**: Privacy-first defaults, with opt-in for advanced features

## Example Queries

1. "Build a Chrome MV3 extension with a side panel that saves notes per tab"
2. "Why does my service worker lose auth after a minute?"
3. "Audit my permissions - what can I remove?"
4. "Make my extension work in Firefox too"
5. "My side panel isn't opening - what's wrong?"
6. "How do I store large datasets in an extension?"

## File Structure

```
chrome-extension-agent-skill/
├── SKILL.md                                  # Main skill definition
├── command/
│   └── load-chrome-extension-architect.md   # OpenCode command
├── references/
│   ├── sidepanel/README.md                  # Side panel API guide
│   ├── permissions/README.md                # Permission minimization
│   ├── service-worker-lifecycle/README.md   # SW lifecycle
│   ├── storage-state/README.md              # Storage matrix
│   ├── cross-browser/README.md              # Cross-browser compat
│   ├── debugging/README.md                  # Debugging guide
│   └── templates/README.md                  # Code templates
├── resources/
│   └── install.sh                           # Installation script
└── README.md                                # This file
```

## License

MIT License - See LICENSE.txt for details

## Contributing

Contributions welcome! Please:

1. Keep explanations concise
2. Include code examples
3. Note cross-browser differences
4. Add privacy warnings for high-impact APIs
5. Reference official documentation

## Resources

- [Chrome Extensions Docs](https://developer.chrome.com/docs/extensions/)
- [Firefox Add-ons Docs](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions)
- [WebExtension Polyfill](https://github.com/mozilla/webextension-polyfill)
- [Plasmo Framework](https://www.plasmo.com/)
- [WXT Framework](https://wxt.dev/)

## Author

Created for AI-assisted Chrome extension development with privacy-first principles.

**Target Browsers:**

- Chrome/Edge (MV3)
- Firefox (MV2/MV3 hybrid)
- Safari (with fallbacks)

**Manifest Version:** MV3 (preferred), with MV2 fallbacks where needed
