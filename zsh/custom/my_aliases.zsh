# Custom aliases for Zsh
# Add your custom aliases here

# System aliases
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

# Git aliases (additional to Oh My Zsh git plugin)
alias gst='git status'
alias gaa='git add .'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias glog='git log --oneline --graph --decorate'

# Navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# System shortcuts - Customize these for your OS
# Uncomment the appropriate section for your operating system:

# For Ubuntu/Debian:
alias update='sudo apt update && sudo apt upgrade -y'
alias install='sudo apt install'
alias remove='sudo apt remove'

# For Fedora/RHEL/CentOS:
# alias update='sudo dnf upgrade -y'
# alias install='sudo dnf install'
# alias remove='sudo dnf remove'

# For Arch/Manjaro:
# alias update='sudo pacman -Syu'
# alias install='sudo pacman -S'
# alias remove='sudo pacman -R'

# For macOS:
# alias update='brew update && brew upgrade'
# alias install='brew install'
# alias remove='brew uninstall'

# Utility aliases
alias c='clear'
alias h='history'
alias ports='netstat -tulanp'

# Add your own custom aliases below this line
