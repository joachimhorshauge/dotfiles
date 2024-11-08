# Go
export GOPATH='/Users/joachimhorshauge/go'

# Nix
export NIX_CONF_DIR=$HOME/.config/nix
export PATH=/run/current-system/sw/bin:$PATH

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

alias reload-nix='darwin-rebuild switch --flake ~/dotfiles/nix-darwin/.#personal && home-manager switch --experimental-features flakes && sudo chmod +x ~/.config/sketchybar/sketchybarrc'


# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship.toml
