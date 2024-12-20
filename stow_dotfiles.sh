

#!/bin/bash

# Directory containing your dotfiles folders
DOTFILES_DIR=$(pwd)

# Folders to exclude
EXCLUDED_FOLDERS=("nix-darwin" ".git")



#!/bin/bash

# Directory containing your dotfiles folders
DOTFILES_DIR=$(pwd)

# Folders to exclude
EXCLUDED_FOLDERS=("nix-darwin" ".git")

# Function to sync dotfiles
sync_dotfiles() {
    local folder=$1

    echo "\nSyncing $folder..."

    # Check if the folder exists
    if [ ! -d "$folder" ]; then
        echo "Error: Folder '$folder' does not exist."
        return 1
    fi

    # Dry-run to detect potential conflicts
    conflicts=$(stow -n -v "$folder" 2>&1 | grep "existing target is not owned by stow")

    if [[ -n $conflicts ]]; then
        echo "WARNING! Stowing $folder would cause conflicts:"
        echo "$conflicts"
        echo -n "Do you want to resolve these conflicts by overwriting? [y/N] "
        read -r resolve_conflicts

        if [[ $resolve_conflicts =~ ^[Yy]$ ]]; then
            # Resolve conflicts by removing conflicting targets
            echo "$conflicts" | awk -F ': ' '{print $2}' | while read -r conflict; do
                echo "Removing conflicting target: $conflict"
                rm -rf "$conflict"
            done
        else
            echo "Skipping $folder due to conflicts."
            return 1
        fi
    fi

    # Stow the folder
    stow -v "$folder"
}

# List available dotfiles folders
echo "Available dotfiles folders:"
folders=($(find . -maxdepth 1 -type d -not -name "." -exec basename {} \+))

# Remove excluded folders from the list
for excluded in "${EXCLUDED_FOLDERS[@]}"; do
    folders=(${folders[@]//*$excluded*/})
done

folders+=("all")

select folder in "${folders[@]}"; do
    if [ "$folder" == "all" ]; then
        for f in "${folders[@]}"; do
            if [ "$f" != "all" ]; then
                sync_dotfiles "$f"
            fi
        done
        break
    elif [ -n "$folder" ]; then
        sync_dotfiles "$folder"
        break
    else
        echo "Invalid selection. Try again."
    fi
done

# List available dotfiles folders
echo "Available dotfiles folders:"
folders=($(find . -maxdepth 1 -type d -not -name "." -exec basename {} \+))

# Remove excluded folders from the list
for excluded in "${EXCLUDED_FOLDERS[@]}"; do
    folders=(${folders[@]//*$excluded*/})
done

folders+=("all")

select folder in "${folders[@]}"; do
    if [ "$folder" == "all" ]; then
        for f in "${folders[@]}"; do
            if [ "$f" != "all" ]; then
                sync_dotfiles "$f"
            fi
        done
        break
    elif [ -n "$folder" ]; then
        sync_dotfiles "$folder"
        break
    else
        echo "Invalid selection. Try again."
    fi
done
