# Go
export GOPATH='/Users/joachimhorshauge/go'
export PATH="$PATH:$HOME/go/bin"

# Nix
export NIX_CONF_DIR=$HOME/.config/nix
export PATH=/run/current-system/sw/bin:$PATH

# Homebrew
export PATH=/opt/homebrew/bin:$PATH


export EDITOR=nvim

# fzf
source <(fzf --zsh)


alias la=tree
alias cat=bat

# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

# Nix
alias reload-nix='darwin-rebuild switch --flake ~/dotfiles/nix-darwin/.#personal' 

# NeoVim
alias vim="nvim"

# Zathura
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"

## LSP
export PATH="/opt/homebrew/Cellar/lua-language-server/3.13.4/bin:$PATH"
export PATH="/opt/homebrew/Cellar/gopls/0.17.0:$PATH"
export PATH="/opt/homebrew/Cellar/pyright/1.1.391/bin/pyright:$PATH"

# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship.toml


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
