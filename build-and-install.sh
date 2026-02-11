#!/bin/bash
# Build Sparks Mission Control and update the .app bundle
set -e
cd "$(dirname "$0")"

echo "⚡ Building Sparks Mission Control..."
swift build

echo "📦 Updating app bundle..."
APP_DIR="$HOME/Applications/Sparks Mission Control.app/Contents/MacOS"
mkdir -p "$APP_DIR"
cp .build/debug/SparksMissionControl "$APP_DIR/SparksMissionControl"

echo "🚀 Launching..."
open "$HOME/Applications/Sparks Mission Control.app"
echo "✅ Done"
