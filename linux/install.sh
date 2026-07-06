#!/bin/bash
# Skywall install script
# Usage: ./install.sh [target_dir]
# Default target: ~/.local/share/skywall

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="${1:-$HOME/.local/share/skywall}"
BIN_DIR="$HOME/.local/bin"
AUTOSTART_DIR="$HOME/.config/autostart"
DATA_DIR="${SKYWALL_DATA_DIR:-$HOME/.skywall}"
PACKAGE="$SCRIPT_DIR/Skywall_v1.1.0.tar.gz"

if [ ! -f "$PACKAGE" ]; then
    echo "ERROR: Package not found: $PACKAGE"
    echo "Run build.sh first or specify the correct path."
    exit 1
fi

echo "Installing Skywall v1.1.0..."

# Create target directory
mkdir -p "$TARGET"

# Extract archive
echo "Extracting to $TARGET..."
tar -xzf "$PACKAGE" -C "$TARGET"

# Create data directory
mkdir -p "$DATA_DIR"

# Create start/stop scripts in data dir
cp "$SCRIPT_DIR/start.sh" "$DATA_DIR/"
cp "$SCRIPT_DIR/stop.sh" "$DATA_DIR/"
chmod +x "$DATA_DIR/start.sh" "$DATA_DIR/stop.sh"

# Create symlink in ~/.local/bin
mkdir -p "$BIN_DIR"
ln -sf "$DATA_DIR/start.sh" "$BIN_DIR/skywall"
echo "Created symlink: $BIN_DIR/skywall -> $DATA_DIR/start.sh"

# Install autostart
mkdir -p "$AUTOSTART_DIR"
cat > "$AUTOSTART_DIR/skywall.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Skywall
Comment=Skywall - Aircraft tracking radar
Exec=$TARGET/Skywall
Terminal=true
Categories=Utility;Network;
StartupNotify=false
X-GNOME-Autostart-enabled=true
EOF
echo "Installed autostart: $AUTOSTART_DIR/skywall.desktop"

echo ""
echo "============================================"
echo " Installation completed!"
echo ""
echo " Access the radar:"
echo "   http://localhost:5050"
echo ""
echo " Run: skywall start"
echo " Stop: $DATA_DIR/stop.sh"
echo ""
echo " Data directory: $DATA_DIR"
echo " Install directory: $TARGET"
echo "============================================"
