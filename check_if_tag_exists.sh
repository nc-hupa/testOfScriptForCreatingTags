#!/bin/bash

# Fetch the latest changes from the remote repository
git fetch origin

# Get a list of remote branches starting with "release/"
release_branches=$(git branch -r | grep 'origin/release/')

# Loop through each release branch and check if it has a tag
for branch in $release_branches; do
    branch_name=$(echo "$branch" | sed 's/origin\///')

    # Check if the branch has a corresponding tag
    tag_name="v$(echo "$branch_name" | sed 's/^release\///')"
    if git show-ref --tags | grep -q "refs/tags/$tag_name"; then
        echo "The branch '$branch_name' has a corresponding tag '$tag_name'."
    else
        echo "The branch '$branch_name' does not have a corresponding tag."
    fi
done
