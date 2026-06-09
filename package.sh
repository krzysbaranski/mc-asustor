#!/bin/bash
set -e

# Package script for Midnight Commander ASUSTOR APK
# This script prepares the package structure by copying files from staging

STAGING_DIR="$(pwd)/staging"
PACKAGE_DIR="$(pwd)/apkg"
PREFIX="/usr/local/mc"

echo "================================================"
echo "Packaging Midnight Commander for ASUSTOR"
echo "================================================"

# Check if staging directory exists
if [ ! -d "${STAGING_DIR}${PREFIX}" ]; then
    echo "Error: Staging directory not found at ${STAGING_DIR}${PREFIX}"
    echo "Please run build.sh first to build Midnight Commander"
    exit 1
fi

# Clean up old package structure (keep CONTROL)
echo "Step 1: Cleaning up old package structure..."
find "${PACKAGE_DIR}" -mindepth 1 -maxdepth 1 -type d ! -name "CONTROL" -exec rm -rf {} \; 2>/dev/null || true

# Copy everything from staging to package at root level
echo "Step 2: Copying files from staging to package..."
cp -a "${STAGING_DIR}${PREFIX}/"* "${PACKAGE_DIR}/" 2>/dev/null || true

# Copy required system libraries
echo "Step 3: Copying required system libraries..."
mkdir -p "${PACKAGE_DIR}/lib"
for lib in libncurses.so.6 libncurses.so libtinfo.so.6 libtinfo.so; do
  if [ -f /usr/lib/x86_64-linux-gnu/$lib ]; then
    cp /usr/lib/x86_64-linux-gnu/$lib "${PACKAGE_DIR}/lib/" 2>/dev/null || true
  fi
done

echo ""
echo "================================================"
echo "Package preparation completed successfully!"
echo "================================================"
echo ""
echo "Package structure:"
echo "  bin/: $(find "${PACKAGE_DIR}/bin" \( -type f -o -type l \) 2>/dev/null | wc -l) files"
echo "  lib/: $(find "${PACKAGE_DIR}/lib" \( -type f -o -type l \) 2>/dev/null | wc -l) files (includes libncurses)"
echo "  share/: $(find "${PACKAGE_DIR}/share" \( -type f -o -type l \) 2>/dev/null | wc -l) files"
