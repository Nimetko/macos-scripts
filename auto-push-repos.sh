#!/bin/bash

# Store the current directory
CurrentDir=$(pwd)

# Path to the file containing the list of repositories
REPO_LIST_FILE=~/x/scripts/repos.txt

# Read each line from the file
while read repo; do
    echo "Checking $repo for changes..."
    cd "$repo"

    # Check for changes
    gitStatus=$(git status --porcelain)
    if [ ! -z "$gitStatus" ]; then
        echo "Changes found in $repo. Adding, committing, and pushing..."
        git add .
        git commit -m "Auto commit."
        git push
    else
        echo "No changes in $repo."
    fi

    cd "$CurrentDir"
done < "$REPO_LIST_FILE"

echo "All repositories have been processed."

# Return to the original directory
cd "$CurrentDir"

