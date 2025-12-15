# Unix Setup Script

An automated installation and configuration script for Zsh, Oh My Zsh, and Git.

## Features

- 🚀 **One-command installation** - Install and configure everything with a single command
- 🎨 **Pre-configured Zsh** - Beautiful and functional Zsh configuration out of the box
- 🔌 **Plugin support** - Includes popular plugins like zsh-autosuggestions and zsh-syntax-highlighting
- 💻 **Cross-platform** - Works on Ubuntu, Debian, Fedora, CentOS, Arch, macOS, and more
- ⚡ **Custom aliases** - Useful aliases to boost your productivity

## Quick Start

### Installation via curl (Recommended)

Run this single command to install everything:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Herzaristide/Unix/main/herzaristide.sh)"
```

### Manual Installation

1. Clone the repository:
```bash
git clone https://github.com/Herzaristide/Unix.git
cd Unix
```

2. Run the installation script:
```bash
./herzaristide.sh
```

## What Gets Installed

The script will install and configure:

1. **Git** - Version control system (if not already installed)
2. **Zsh** - Modern shell replacement for Bash (if not already installed)
3. **Oh My Zsh** - Framework for managing Zsh configuration
4. **Zsh Plugins**:
   - `zsh-autosuggestions` - Fish-like autosuggestions
   - `zsh-syntax-highlighting` - Syntax highlighting for commands
5. **Custom Configuration**:
   - Pre-configured `.zshrc` file
   - Custom aliases for productivity
   - Custom `my-refined` theme - A minimal and beautiful theme showing git branch, Python version, and more

## Repository Structure

```
Unix/
├── herzaristide.sh           # Main installation script (Run this first!)
└── zsh/                      # Configuration files for Zsh/Oh My Zsh
    ├── .zshrc                # Primary Zsh configuration file
    └── custom/               # Directory for custom OMZ themes/plugins
        ├── my_aliases.zsh    # Custom aliases
        └── themes/           # Custom themes directory
            └── my-refined.zsh-theme  # Custom minimal theme
```

## Customization

After installation, you can customize your setup:

### Edit Zsh Configuration
```bash
vim ~/.zshrc
```

### Edit Custom Aliases
```bash
vim ~/.oh-my-zsh/custom/my_aliases.zsh
```

### Add More Plugins

Edit `~/.zshrc` and add plugins to the `plugins` array:
```bash
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    # Add more plugins here
)
```

## Included Aliases

The setup includes useful aliases from multiple sources:

**From Oh My Zsh Git Plugin** (automatically active):
- `gst` - Git status
- `gaa` - Git add all
- `gcm` - Git commit with message
- `gp` - Git push
- `gl` - Git pull
- And many more! (see [Oh My Zsh git plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git))

**Custom Aliases** (in `zsh/custom/my_aliases.zsh`):
- `ll` - Detailed list view
- `glog` - Pretty git log
- `..` / `...` / `....` - Navigate up directories
- `c` - Clear terminal
- `h` - View history

**OS-Specific Aliases** (commented out by default - uncomment for your OS):
- `update` - System update command
- `install` - Package installation command
- `remove` - Package removal command

See `zsh/custom/my_aliases.zsh` for the complete list and customization options.

## Requirements

- `curl` or `wget` (for remote installation)
- `sudo` privileges (for installing packages)
- Internet connection

## Supported Operating Systems

- Ubuntu / Debian
- Fedora / RHEL / CentOS
- Arch Linux / Manjaro
- macOS (with Homebrew)

## Troubleshooting

### Shell doesn't change to Zsh automatically

If your shell doesn't change automatically, run:
```bash
chsh -s $(which zsh)
```
Then log out and log back in.

### Plugins not working

Make sure you've started a new Zsh session or run:
```bash
source ~/.zshrc
```

## Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features
- Submit pull requests

## License

This project is open source and available under the MIT License.

## Author

Created by Herzaristide

---

**Enjoy your new Zsh setup! 🎉**