#!/bin/bash
# Skywall uninstall script
# Preserves user data (~/.skywall/)

set -e

TARGET="${1:-$HOME/.local/share/skywall}"
DATA_DIR="${SKYWALL_DATA_DIR:-$HOME/.skywall}"
BIN_DIR="$HOME/.local/bin"
AUTOSTART_DIR="$HOME/.config/autostart"

echo "Uninstalling Skywall..."

# Remove installation directory
if [ -d "$TARGET" ]; then
    rm -rf "$TARGET"
    echo "Removed: $TARGET"
fi

# Remove symlink
if [ -L "$BIN_DIR/skywall" ]; then
    rm "$BIN_DIR/skywall"
    echo "Removed symlink: $BIN_DIR/skywall"
fi

# Remove autostart
if [ -f "$AUTOSTART_DIR/skywall.desktop" ]; then
    rm "$AUTOSTART_DIR/skywall.desktop"
    echo "Removed autostart: $AUTOSTART_DIR/skywall.desktop"
fi

echo ""
echo "Uninstall completed."
echo "User data preserved in: $DATA_DIR"
echo "To remove data as well, run: rm -rf $DATA_DIR"
