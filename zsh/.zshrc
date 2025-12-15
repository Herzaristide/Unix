# ==============================================================================
# 0. SHELL ENVIRONMENT (Recommended for Bluefin/Distrobox)
# ==============================================================================
# Set your preferred shell path (usually set by OMZ install)
export SHELL=/bin/zsh

# Set the locale to ensure proper character handling and avoid warnings
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# ==============================================================================
# 1. OH MY ZSH SETUP
# ==============================================================================
# Set ZSH_CUSTOM directory (where we downloaded the plugins)
export ZSH="$HOME/.oh-my-zsh"

# Set Zsh theme to blank or robbyrussell. 
# We use 'robbyrussell' here, but the 'starship' prompt below will override it.

ZSH_THEME="my-refined"

# List of plugins to load (OMZ built-ins first, custom ones last)
# NOTE: zsh-syntax-highlighting MUST be last in this list for proper function.
plugins=(
    # OMZ Built-ins
    git          # Essential Git aliases (e.g., gst for git status)
    sudo
    docker
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Initialize Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ==============================================================================
# 2. BLUEFIN/CUSTOM UTILITIES INTEGRATION
# ==============================================================================

# --- Atuin Setup (Advanced Shell History) ---
# Bluefin uses atuin for persistent, searchable history (Ctrl+R)
# This line initializes atuin.
if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi


# ==============================================================================
# 4. CUSTOM ALIASES
# ==============================================================================

# Recommended Bluefin Aliases (using modern utilities)

# Standard Aliases
alias grep='grep --color=auto'
alias nv='nvim'                # Alias vim/vi to nvim if installed
alias rm='rm -i'               # Always ask before deleting
alias cp='cp -i'               # Always ask before overwriting
alias mv='mv -i'               # Always ask before moving
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
