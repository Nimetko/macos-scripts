#!/bin/bash

# Check if the -r option is provided
if [[ "$1" == "-r" ]]; then
    # Get the remote branch to checkout from
    remote_branch=$(git branch -r | sed 's/origin\///' | sed 's/^ *//g' | fzf)

    echo "Selected branch $remote_branch"
    git checkout "$remote_branch"
else
    # Checkout local branch
    git checkout $(git branch | fzf)
fi
