# Quick Start Guide

This guide will help you get started with building the Midnight Commander ASUSTOR package.

## Prerequisites

You need:
- A Linux environment (Ubuntu 20.04+ recommended)
- Internet connection to download sources
- About 300MB free disk space
- Build tools (see below)

## Option 1: Automated Build with GitHub Actions (Recommended)

1. Fork this repository
2. Push to the `main` or `master` branch
3. GitHub Actions will automatically build the package
4. Download the built `.apk` file from the Actions artifacts

## Option 2: Local Build

### Option 2a: Build with Docker (Recommended for Consistency)

Build inside a Docker container to ensure a consistent environment:

```bash
# Clone the repository
git clone https://github.com/krzysbaranski/mc-asustor.git
cd mc-asustor

# Build using Docker
docker run --rm -v $(pwd):/workspace -w /workspace ubuntu:22.04 bash -c "
  apt-get update && \
  apt-get install -y build-essential wget gzip make texinfo \
    libncurses5-dev libslang2-dev libx11-dev && \
  chmod +x build.sh && \
  ./build.sh
"
```

### Option 2b: Build Directly on Host

#### Install Dependencies

On Ubuntu/Debian:
```bash
sudo apt-get update
sudo apt-get install -y \
  build-essential wget gzip make texinfo \
  libncurses5-dev libslang2-dev
```

#### Build the Package

```bash
# Clone the repository
git clone https://github.com/krzysbaranski/mc-asustor.git
cd mc-asustor

# Run the build script
chmod +x build.sh
./build.sh
```

This will:
1. Download Midnight Commander
2. Compile everything
3. Install files into the `apkg/` directory

#### Package the ASUSTOR APK

Using Docker:
```bash
docker run --rm \
  -v $(pwd)/apkg:/source \
  -v $(pwd)/dist:/dest \
  ghcr.io/asustor-contrib/apkg-tools:latest
```

The `.apk` file will be created in the `dist/` directory.

## Installing on ASUSTOR NAS

1. Download the `.apk` file
2. Log into your ASUSTOR NAS web interface
3. Open App Central
4. Click the gear icon and select "Install Manually"
5. Upload the `.apk` file
6. Follow the installation wizard

## Using Midnight Commander

After installation, connect to your NAS via SSH and run:

```bash
# Check installation
mc --version

# Start Midnight Commander
mc

# Open Midnight Commander in a specific directory
mc /mnt/HDA_ROOT

# Use mcedit (built-in editor)
mcedit filename.txt

# Use mcview (file viewer)
mcview filename.txt
```

### Basic Navigation

- **Arrow keys**: Navigate between files/directories
- **Tab**: Switch between left and right panels
- **Enter**: Open file or enter directory
- **F10**: Exit Midnight Commander
- **F1**: Help
- **F5**: Copy files
- **F6**: Move files
- **F8**: Delete files
- **F9**: Access menu
- **F4**: Edit file with mcedit
- **F3**: View file with mcview

## Troubleshooting

### Build fails with "command not found"
- Make sure all dependencies are installed
- Check that you're using a compatible Linux distribution

### Build runs out of space
- Free up at least 300MB of disk space
- The build process creates temporary files in the `build/` directory

### Package installation fails on ASUSTOR
- Check that your NAS OS version is 4.0.0 or higher
- Verify the `.apk` file is not corrupted (check file size)

### MC shows garbled characters
- Ensure your terminal supports UTF-8 encoding
- Check locale settings: `locale`

## Getting Help

- Check the [README.md](README.md) for detailed documentation
- Open an issue on GitHub for bugs or questions
- See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines

## Next Steps

Once Midnight Commander is installed:
- Read the [Midnight Commander Wiki](https://wiki.midnight-commander.org/)
- Learn keyboard shortcuts and features
- Check out the [MC manual pages](https://midnight-commander.org/)
- Explore configuration options in `~/.config/mc/`
