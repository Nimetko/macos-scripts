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
        echo "Changes found in $repoPath. Adding, committing, and pushing..."
        git add .
        git commit -m "Auto commit."
        git push
    else
        echo "No changes in $repoPath."
    fi

    # Return to the original directory
    cd "$CurrentDir"
done < "$REPO_LIST_FILE"

echo "All repositories have been processed."

# Return to the original directory
cd "$CurrentDir"

