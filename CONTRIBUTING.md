# Contributing to Midnight Commander for ASUSTOR

Thank you for your interest in contributing to this project!

## How to Contribute

1. **Fork the repository**
   - Click the "Fork" button at the top right of the repository page

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/mc-asustor.git
   cd mc-asustor
   ```

3. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make your changes**
   - Update version numbers if needed (in `build.sh` and `apkg/CONTROL/config.json`)
   - Test your changes by running the build script
   - Update documentation if needed

5. **Test your build**
   ```bash
   ./build.sh
   ```

6. **Commit your changes**
   ```bash
   git add .
   git commit -m "Description of your changes"
   ```

7. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

8. **Create a Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Select your branch
   - Describe your changes

## What to Contribute

### Good First Contributions
- Update Midnight Commander version
- Improve documentation
- Add more detailed error messages
- Improve the icon design
- Add configuration examples

### Larger Contributions
- Add support for additional architectures
- Optimize build process
- Add automated tests
- Improve installation scripts
- Add S-Lang support alongside ncurses

## Code Style

- Use 4 spaces for indentation in shell scripts
- Add comments for complex logic
- Keep lines under 100 characters when possible
- Use descriptive variable names

## Testing

Before submitting a PR:
1. Ensure the build script runs successfully
2. Verify the package structure is correct
3. Test that all scripts are executable
4. Check that documentation is up to date
5. Verify that binaries run correctly (test mc, mcedit, mcview)
6. Verify that all binaries run on ASUSTOR NAS (if testing on actual hardware)

## Build Configuration

The build uses ncurses for terminal UI. If you want to test alternative configurations:
- S-Lang support: Add `--with-screen=slang` to configure
- X11 support: Remove `--without-x` (not recommended for NAS)

## Questions?

If you have questions, please:
- Open an issue for discussion
- Check existing issues and pull requests
- Review the README.md for guidance

## License

By contributing, you agree that your contributions will be licensed under the GPL-2.0 license.
