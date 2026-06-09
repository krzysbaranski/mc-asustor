# Midnight Commander for ASUSTOR NAS

This repository contains everything needed to build an ASUSTOR APK package for Midnight Commander (mc).

## About

Midnight Commander is a visual file manager for UNIX-like systems. It is a Norton Commander clone that provides a two-panel interface for easy file navigation and operations on your ASUSTOR NAS.

This package provides Midnight Commander binaries compiled for ASUSTOR NAS devices, enabling an intuitive visual file management interface directly on your NAS.

## Features

- Visual two-panel file manager
- Comprehensive file operations (copy, move, delete, etc.)
- Built-in text editor (mcedit)
- File viewer (mcview)
- Archive support (zip, tar, gzip, bzip2, etc.)
- Syntax highlighting
- User-friendly keyboard shortcuts
- Terminal-based UI using ncurses

## Building

### Automated Build (GitHub Actions)

The package can be automatically built using GitHub Actions on every push to the main branch. The workflow:

1. Installs required build dependencies
2. Downloads and compiles Midnight Commander from source
3. Reorganizes files into ASUSTOR package structure (bin/, lib/ at root)
4. Validates package contents against config.json
5. Packages everything into an ASUSTOR APK file
6. Uploads the package as a build artifact

You can download the built APK from the Actions tab after a successful build.

### Manual Build

Quick summary:
```bash
git clone https://github.com/krzysbaranski/mc-asustor.git
cd mc-asustor
chmod +x build.sh
./build.sh
```

The build process:
1. `build.sh` compiles Midnight Commander into a staging directory
2. `package.sh` (called by build.sh) reorganizes files into the ASUSTOR package structure
3. Files are placed in `apkg/bin/`, `apkg/lib/`, and `apkg/share/` directories
4. `validate-package.sh` checks that all files in config.json exist and warns about unexpected files

## Installation

1. Download the `.apk` file from the [Releases](../../releases) page or build artifacts
2. Log in to your ASUSTOR NAS web interface
3. Go to App Central
4. Click "Install Manually" (the gear icon)
5. Upload the `.apk` file
6. Follow the installation prompts

## Usage

After installation, Midnight Commander will be available in `/usr/local/AppCentral/mc/bin/` and symlinked to `/usr/local/bin/`.

Common commands:
```bash
# Start Midnight Commander
mc

# Start with a specific directory
mc /path/to/directory

# Edit a file with mcedit
mcedit filename.txt

# View a file with mcview
mcview filename.txt
```

For more information, see the [Midnight Commander documentation](https://midnight-commander.org/).

## Package Contents

This package includes:
- Midnight Commander (mc)
- mcedit (built-in text editor)
- mcview (file viewer)

## Development

### Repository Structure

```
.
├── .github/
│   └── workflows/
│       └── build.yml          # GitHub Actions workflow
├── apkg/
│   └── CONTROL/
│       ├── config.json        # Package metadata (static file list)
│       ├── description.txt    # Package description
│       ├── changelog.txt      # Version history
│       ├── icon.png           # Package icon
│       ├── pre-install.sh     # Pre-installation script
│       ├── post-install.sh    # Post-installation script
│       ├── pre-uninstall.sh   # Pre-uninstallation script
│       ├── post-uninstall.sh  # Post-uninstallation script
│       └── start-stop.sh      # Service start/stop script
├── build.sh                   # Build script for Midnight Commander
├── package.sh                 # Package preparation script
├── validate-package.sh        # Package validation script
├── .gitignore                 # Git ignore patterns
└── README.md                  # This file
```

### Modifying the Build

To update Midnight Commander version, edit the version variable at the top of `build.sh`:

```bash
MC_VERSION="4.8.31"
```

### Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the build
5. Submit a pull request

## References

- [ASUSTOR App Central Developer Guide](https://downloadgb.asustor.com/developer/App_Central_Developer_Guide_4.2.5_20231030.pdf)
- [Midnight Commander Official Website](https://midnight-commander.org/)
- [Midnight Commander Wiki](https://wiki.midnight-commander.org/)

## License

This packaging is released under GPL-2.0 license, consistent with Midnight Commander's license.

Midnight Commander itself is:
- Copyright (C) Free Software Foundation, Inc.
- Licensed under GPL-2.0-or-later

## Support

For issues related to:
- **This package**: Open an issue in this repository
- **Midnight Commander**: See [Midnight Commander support resources](https://midnight-commander.org/)
- **ASUSTOR NAS**: Contact [ASUSTOR support](https://www.asustor.com/support)
