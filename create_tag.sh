#!/bin/bash

# Fetch the latest changes from the remote repository
git fetch origin

# Get a list of remote branches starting with "release/"
release_branches=$(git branch -r | grep 'origin/release/')

# Loop through each release branch and check if it has any tag
for branch in $release_branches; do
    branch_name=$(echo "$branch" | sed 's/origin\///')
    tag_name="v$(echo "$branch_name" | sed 's/release\///')"

    # Check if the branch has any tag
    if ! git show-ref --tags | grep -q "refs/tags/$tag_name"; then
        echo "Creating a tag '$tag_name' for the branch '$branch_name'."
        git tag "$tag_name" "$branch_name"
        git push origin "$tag_name"
    else
        echo "The branch '$branch_name' already has a tag '$tag_name'."
    fi
done
