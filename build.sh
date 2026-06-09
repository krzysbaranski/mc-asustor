#!/bin/bash
set -e

# Build script for Midnight Commander and dependencies for ASUSTOR NAS
# This script downloads, compiles, and packages Midnight Commander

MC_VERSION="4.6.1"

# Build configuration
# PREFIX: Path used during build/staging (can be any path for development)
# INSTALL_PREFIX: Actual runtime path where ASUSTOR will install the package
PREFIX="/usr/local/mc"
BUILD_DIR="$(pwd)/build"
STAGING_DIR="$(pwd)/staging"
PACKAGE_DIR="$(pwd)/apkg"

# ASUSTOR installs packages to /usr/local/AppCentral/<package_name>
# We need to set RPATH to ensure binaries use the packaged libraries
INSTALL_PREFIX="/usr/local/AppCentral/mc"

# Create build and staging directories
mkdir -p "$BUILD_DIR"
mkdir -p "$STAGING_DIR"
cd "$BUILD_DIR"

echo "================================================"
echo "Building Midnight Commander ${MC_VERSION} for ASUSTOR NAS"
echo "================================================"

# Function to download and extract
download_and_extract() {
    local name=$1
    local version=$2
    local url=$3

    echo "Downloading ${name} ${version}..."
    wget -q "${url}" -O "${name}-${version}.tar.gz"
    echo "Extracting ${name} ${version}..."
    tar xzf "${name}-${version}.tar.gz"
}

# Download sources
echo "Step 1: Downloading source packages..."
download_and_extract "mc" "$MC_VERSION" "https://ftp.gnu.org/gnu/mc/mc-${MC_VERSION}.tar.gz"

# Build Midnight Commander
echo ""
echo "Step 2: Building Midnight Commander..."
cd "mc-${MC_VERSION}"

export PKG_CONFIG_PATH="${STAGING_DIR}${PREFIX}/lib/pkgconfig:$PKG_CONFIG_PATH"
export PATH="${STAGING_DIR}${PREFIX}/bin:$PATH"
export LD_LIBRARY_PATH="${STAGING_DIR}${PREFIX}/lib:$LD_LIBRARY_PATH"
export CPPFLAGS="-I${STAGING_DIR}${PREFIX}/include"
export LDFLAGS="-L${STAGING_DIR}${PREFIX}/lib -Wl,-rpath,${INSTALL_PREFIX}/lib"

LDFLAGS="-L${STAGING_DIR}${PREFIX}/lib -Wl,-rpath,${INSTALL_PREFIX}/lib" \
./configure \
    --prefix="$PREFIX" \
    --with-screen=ncurses \
    --enable-background \
    --disable-debug \
    --without-gpm \
    --without-x

make -j$(nproc)
make install DESTDIR="${STAGING_DIR}"
cd ..

# Note: Package preparation is done by package.sh after build
cd ..

echo ""
echo "================================================"
echo "Build completed successfully!"
echo "================================================"
echo ""

# Run the packaging script
if [ -f "$(pwd)/package.sh" ]; then
    echo "Running package.sh to prepare ASUSTOR package..."
    "$(pwd)/package.sh"
else
    echo "Warning: package.sh not found, skipping package preparation"
fi

echo ""

# Run the validation script
if [ -f "$(pwd)/validate-package.sh" ]; then
    echo "Running validate-package.sh to validate package contents..."
    "$(pwd)/validate-package.sh" || echo "Note: Validation completed with warnings or errors (see above)"
else
    echo "Warning: validate-package.sh not found, skipping validation"
fi
