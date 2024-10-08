#!/bin/bash

# Store the current directory
CurrentDir=$(pwd)

# Path to the file containing the list of repositories
REPO_LIST_FILE="$HOME/x/scripts/repos.txt"

# Read each line from the file
while read repo; do
    # Replace ~ with $HOME for proper path expansion
    repoPath="${repo/#\~/$HOME}"
    echo "Checking $repoPath for changes..."
    cd "$repoPath" || { echo "Unable to access $repoPath"; continue; }

    # Check for changes
    gitStatus=$(git status --porcelain)
    if [ ! -z "$gitStatus" ]; then
        # echo "Changes found in $repoPath."
        # git status --porcelain
        echo -e "Changes found in $repoPath."
        echo -e "\033[0;31m$gitStatus\033[0m"
    else
        echo "No changes in $repoPath."
    fi

    # Return to the original directory
    cd "$CurrentDir"
done < "$REPO_LIST_FILE"

echo "All repositories have been processed."

# Return to the original directory
cd "$CurrentDir"

