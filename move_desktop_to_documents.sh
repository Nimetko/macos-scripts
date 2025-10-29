#!/bin/bash

# Exit if any command fails
set -e

# Define paths
SRC="$HOME/Desktop"
DEST="$HOME/Documents/Desktop"

# Create destination folder if it doesn't exist
mkdir -p "$DEST"

echo "Moving files from: $SRC"
echo "To: $DEST"
echo

# Move everything (hidden files too) safely
# Use 'find' to handle dotfiles like .DS_Store
find "$SRC" -mindepth 1 -maxdepth 1 -exec mv -vn {} "$DEST" \;

echo
echo "All items from Desktop moved to $DEST"

