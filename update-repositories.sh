#!/bin/bash

# Store the current directory
CurrentDir=$(pwd)

# Path to the file containing the list of repositories
REPO_LIST_FILE="$HOME/x/scripts/repos.txt"

# Loop through each repository and pull the latest changes
while read repo; do
    # Replace ~ with $HOME for proper path expansion
    repoPath="${repo/#\~/$HOME}"
    echo "Updating repository in $repoPath"
    
    if cd "$repoPath"; then
        git pull            # Pull the latest changes
        cd "$CurrentDir"    # Return to the original directory
    else
        echo "Unable to access $repoPath, skipping..."
    fi
done < "$REPO_LIST_FILE"

echo "All repositories have been updated."

# Return to the original directory
cd "$CurrentDir"

