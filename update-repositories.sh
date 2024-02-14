#!/bin/bash

# Store the current directory
CurrentDir=$(pwd)

# Path to the file containing the list of repositories
REPO_LIST_FILE=~/x/scripts/repos.txt

# Loop through each repository and pull the latest changes
while read repo; do
    echo "Updating repository in $repo"
    cd "$repo"          # Navigate to the repository
    git pull            # Pull the latest changes
    cd "$CurrentDir"    # Return to the original directory
done < $REPO_LIST_FILE

echo "All repositories have been updated."

# Return to the original directory
cd "$CurrentDir"

