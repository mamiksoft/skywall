#!/bin/bash
# Skywall Linux build script
# Usage: ./build.sh [version]
# Requires: pyinstaller

set -e

VERSION="${1:-1.1.0}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUTPUT_NAME="Skywall_v${VERSION}"

echo "============================================"
echo " Skywall v${VERSION} - Linux Builder"
echo "============================================"

echo ""
echo "Step 1: Build executable with PyInstaller..."
cd "$SCRIPT_DIR"
python3 -m PyInstaller -y skywall.spec
echo "OK - PyInstaller completed."

echo ""
echo "Step 2: Create tar.gz archive..."
cd "$SCRIPT_DIR/dist"
if [ -d "Skywall" ]; then
    tar -czf "${OUTPUT_NAME}.tar.gz" Skywall/
    mv "${OUTPUT_NAME}.tar.gz" "$SCRIPT_DIR/"
    echo "OK - Archive created: ${OUTPUT_NAME}.tar.gz"
else
    echo "ERROR: dist/Skywall/ not found"
    exit 1
fi

echo ""
echo "Step 3: Generate SHA256 checksum..."
cd "$SCRIPT_DIR"
sha256sum "${OUTPUT_NAME}.tar.gz" > "${OUTPUT_NAME}.tar.gz.sha256"
echo "OK - Checksum generated: ${OUTPUT_NAME}.tar.gz.sha256"

echo ""
echo "============================================"
echo " COMPLETED!"
echo " Package: ${OUTPUT_NAME}.tar.gz"
echo " Checksum: ${OUTPUT_NAME}.tar.gz.sha256"
echo "============================================"
