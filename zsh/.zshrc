# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Plugins to load
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Load Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# User configuration

# Preferred editor
export EDITOR='vim'

# Load custom aliases
if [ -f "$ZSH_CUSTOM/my_aliases.zsh" ]; then
    source "$ZSH_CUSTOM/my_aliases.zsh" 2>/dev/null || true
fi
