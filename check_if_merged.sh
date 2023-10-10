#!/bin/bash

# Fetch the latest changes from the remote repository
git fetch origin

# Get a list of remote branches starting with "release/"
release_branches=$(git branch -r | grep 'origin/release/')

# Loop through each release branch and check if it's merged into main
for branch in $release_branches; do
    branch_name=$(echo "$branch" | sed 's/origin\///')
    if git merge-base --is-ancestor "$branch_name" origin/main; then
        echo "The release branch '$branch_name' has been merged into the main branch."
    else
        echo "The release branch '$branch_name' has not been merged into the main branch."
    fi
done


