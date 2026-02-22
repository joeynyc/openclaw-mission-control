# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Build
swift build

# Run (debug binary)
.build/debug/SparksMissionControl

# Build, bundle as .app, and launch
./build-and-install.sh
```

There are no tests in this project.

## Architecture

This is a **Swift 6.2 / SwiftUI macOS app** (macOS 14+) with no external dependencies — pure SPM, no third-party packages.

### Data flow

`AppState` (an `@MainActor ObservableObject`) is the single source of truth, injected at the root via `.environmentObject`. It owns:
- `GatewayConnection` — HTTP-only client for the OpenClaw gateway (health checks every 15s via `DispatchSourceTimer`, chat via `/v1/chat/completions`, actions via `/hooks/agent` and `/hooks/wake`)
- `GatewayConfig` — loaded once at init from `~/.openclaw/openclaw.json`
- `AgentIdentity` — loaded from `~/clawd/IDENTITY.md` or `~/.openclaw/clawd/IDENTITY.md`
- Background polling Tasks: services (30s), cron jobs (30s), node info (60s)

`GatewayConnection` uses **HTTP only** — no WebSocket. "Connected" state is determined by whether `GET http://127.0.0.1:<port>/` returns HTTP 200–499. Chat uses the OpenAI-compatible `/v1/chat/completions` endpoint.

Two separate tokens exist with different scopes:
- `gateway.auth.token` → used for health checks and chat (`Authorization: Bearer`)
- `hooks.token` → used for `/hooks/agent` and `/hooks/wake`

### View layer

`DashboardView` is the root view, composing all dashboard cards in a fixed layout. Each card is a self-contained view that receives `AppState` via `@EnvironmentObject`. `GlassCard` is the reusable container for all panels.

### Theming

All colors, radii, and fonts live in `Theme` (`Styles/Theme.swift`). Never hardcode colors in views — always use `Theme.*`. Key values: accent yellow `#FFD60A`, online green `#30D158`, card corner radius `16pt`, monospaced font via `Theme.mono(_:weight:)`.

### Config file schema (`~/.openclaw/openclaw.json`)

`GatewayConfig.loadFromDisk()` uses multi-path key resolution to handle variations in config layout. Key paths:
- Port: `gateway.port` or `port`
- Gateway token: `gateway.auth.token`
- Hooks token: `hooks.token`
- Primary model: `agents.defaults.model.primary`
- Node name: `node.name`, `nodes.default.name`, `nodes.local.name`, or any `nodes.<key>.name`

### Skills discovery

Skills are enumerated at launch from these directories (in order): `~/.openclaw/skills`, `~/.openclaw/clawd/skills`, `~/clawd/skills`, `/opt/homebrew/lib/node_modules/openclaw/skills`. A skill is any subdirectory containing a `SKILL.md` file.
