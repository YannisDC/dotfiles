#!/bin/bash

echo "Starting installation..."

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "Homebrew already installed"
fi

# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh already installed"
fi

# Required for Ghidra
softwareupdate --install-rosetta --agree-to-license

# Install packages from Brewfile
if [ -f "Brewfile" ]; then
    echo "Installing packages from Brewfile..."
    brew bundle --file=Brewfile
else
    echo "Error: Brewfile not found in current directory"
    exit 1
fi

echo "Installation complete! 🎉"
echo "Please restart your terminal for changes to take effect." 
