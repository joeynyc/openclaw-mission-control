# Sparks Mission Control — Native macOS App

Build a standalone macOS SwiftUI app (Swift Package Manager, no Xcode project needed) called "Sparks Mission Control".

## Design: Black Liquid Glass
- Deep black translucent glass aesthetic — like macOS dark mode but darker, more premium
- Use `.ultraThinMaterial` / `.regularMaterial` with dark color scheme forced
- Background: near-black (#0A0A0A) with very subtle ambient color gradients
- Cards: dark translucent glass panels with subtle 1px top highlight borders
- Accent color: electric yellow (#FFD60A) for the Sparks brand
- Green (#30D158) for active/online indicators
- Monospace font for technical values
- Smooth rounded corners (16pt radius on cards)
- Subtle hover effects on interactive elements
- macOS native window with transparent titlebar, full-size content view

## Layout (Single Window Dashboard)
Use a grid/flow layout in a ScrollView. Sections:

### 1. Identity Bar (top)
- ⚡ Sparks avatar (yellow gradient rounded rect)
- "Sparks — Live wire • Executive Assistant to Joey"  
- "claude-opus-4-6 · OpenClaw Gateway"
- Green beacon dot + "ONLINE" status
- Live clock (EST timezone)

### 2. Session Stats Row
- Uptime counter (ticking)
- 12 Tools Active
- 50+ Skills Loaded
- 1 Node

### 3. Core Capabilities Grid (3x3)
Each tile shows emoji + name + green "ACTIVE" dot:
Memory, Cron Jobs, Web Search, Browser, Node Control, Sub-Agents, File System, Messaging, TTS/Voice

### 4. Services Status List
- Gateway: Running (green)
- Telegram: Connected (green)
- ElevenLabs: Paid (green)
- AgentMail: Active (green)
- Govee: No API Key (orange/warning)

### 5. Model Routing
- Badge: claude-opus-4-6
- Conversation → opus-4-6
- Coding → codex-5.2-medium
- Image Gen → gemini-3-pro
- Voice → eleven-v2

### 6. Channels
- Telegram: LIVE (green badge)
- X/Twitter: RELAY (orange badge)
- AgentMail: LIVE (green badge)

### 7. Node Info
- Joey's Mac Mini, M4, 192.168.1.197
- macOS 25.3, Mode: Local

### 8. Skills Arsenal (tag cloud)
Bird, Apple Notes, Apple Reminders, Coding Agent, Healthcheck, Weather, Session Logs, Nano Banana Pro, Canvas Design, Slide Creator, GitHub, Doc Coauthoring, MCP Builder, Skill Creator, Video Frames, Blog Watcher, Whisper, tmux, AgentMail, Find Skills

### 9. Quick Actions (2-col grid of buttons)
Search Memory, Web Search, List Cron Jobs, Ping Node, Spawn Sub-Agent, Node Camera, Session Status, Gateway Restart
(These are display-only for now, just styled buttons)

### 10. Activity Log (bottom, full width)
A few hardcoded log entries with timestamps

## Technical Requirements
- Swift Package Manager project (Package.swift)
- macOS 14.0+ deployment target
- Single window app, NSApp appearance set to dark
- Use SwiftUI's `.background(.ultraThinMaterial)` on cards over dark backgrounds
- Window: default size 1280x900, min 900x600
- Transparent titlebar with inline title
- The app should compile and run with `swift build` then `swift run` or via `open .build/debug/SparksMissionControl.app` equivalent
- Keep it all in one or two Swift files for simplicity

## IMPORTANT
- This is a DISPLAY dashboard — all data is hardcoded/static
- Focus on making it look stunning — the black liquid glass is the star
- No networking, no real data fetching
- Must compile cleanly on macOS 14+ with Swift 5.9+

When completely finished, run: openclaw gateway wake --text "Done: Built Sparks Mission Control native macOS app" --mode now
