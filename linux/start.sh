#!/bin/bash
# Skywall start script
# Launches the Skywall Flask server

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKYWALL_DIR="$(dirname "$SCRIPT_DIR")"
DATA_DIR="${SKYWALL_DATA_DIR:-$HOME/.skywall}"

mkdir -p "$DATA_DIR"

cd "$SKYWALL_DIR"
exec ./Skywall
