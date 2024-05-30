#!/bin/bash

# Install Homebrew
if ! command -v brew &> /dev/null
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Install GNU Stow
if ! command -v stow &> /dev/null
then
    echo "Installing GNU Stow..."
    brew install stow
else
    echo "GNU Stow is already installed."
fi

# Clone your dotfiles repository
if [ ! -d "$HOME/dotfiles" ]; then
    echo "Cloning dotfiles repository..."
    git clone https://github.com/joachimhorshauge/dotfiles.git $HOME/dotfiles
else
    echo "Dotfiles repository already exists."
fi

# Change to the dotfiles directory
cd $HOME/dotfiles

# Stow all directories
for dir in */
do
    stow ${dir%*/}
done

echo "Dotfiles setup complete."

