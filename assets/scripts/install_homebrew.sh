#!/bin/bash

LOG_FILE="$(dirname "$0")/install_log.log"  # Log file in the same directory as the script
echo "" > "$LOG_FILE"  # Clear previous logs

# Check if Homebrew is already installed
if ! command -v brew &>/dev/null; then
    echo "🔹 Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Verify if Homebrew installed successfully
    if command -v brew &>/dev/null; then
        echo "✅ Homebrew installed successfully."
    else
        echo "❌ Homebrew installation failed!"
        echo "fail" > "$LOG_FILE"
        exit 1
    fi
else
    echo "✅ Homebrew is already installed. Skipping installation."
fi

# Install Android Platform Tools if Homebrew is available
if command -v brew &>/dev/null; then
    echo "🔹 Installing Android Platform Tools..."
    brew install android-platform-tools --cask
    echo "✅ Android Platform Tools installation completed."
fi


# Check if installation was successful
if brew list android-platform-tools &>/dev/null; then
    echo "success" > "$LOG_FILE"
    exit 0
else
    echo "fail" > "$LOG_FILE"
    exit 1
fi