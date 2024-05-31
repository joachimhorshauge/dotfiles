# My Dotfiles

Welcome to my dotfiles repository! This repository contains my personal configuration files for various tools and applications. The setup is designed to be easy to use and manage using GNU Stow and Homebrew.

## Table of Contents

- [Installation](#installation)
- [Structure](#structure)
- [Customizing](#customizing)

## Installation

To set up your environment with these dotfiles, follow the instructions below:

1. **Clone this repository**:
    ```sh
    git clone https://github.com/joachimhorshauge/dotfiles.git $HOME/dotfiles
    ```

2. **Run the setup script**:
    ```sh
    cd $HOME/dotfiles
    ./setup_dotfiles.sh
    ```

This script will:
- Install Homebrew if it is not already installed.
- Install GNU Stow if it is not already installed.
- Clone this dotfiles repository to your home directory.
- Use GNU Stow to symlink the configuration files to the appropriate locations.
- Install packages specified in the `brew/.Brewfile`.

## Structure

The repository is structured as follows:

```
dotfiles/
├── bash/
├── git/
├── vim/
├── brew/
├── zsh/
└── ...
```

Each directory contains the configuration files for a specific application or tool. GNU Stow will create the necessary symlinks in your home directory.

## Customizing

Feel free to customize the configurations to suit your preferences. Here’s how you can manage your dotfiles:

- **Adding new configurations**: Create a new directory for the tool and place the configuration files inside. Then, run `stow <directory>` to symlink the files.
- **Updating configurations**: Modify the files in the appropriate directory and they will be reflected in your home directory.
- **Removing configurations**: Run `stow -D <directory>` to remove the symlinks.

---

Happy dotfiling!
