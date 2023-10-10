#!/bin/bash

# Fetch the latest tags from the remote repository
git fetch --tags

# Get a list of all tags
tags=$(git tag -l)

# Loop through each tag and delete it
for tag in $tags; do
    echo "Deleting tag: $tag"
    git tag -d "$tag"         # Delete the local tag
    git push origin ":refs/tags/$tag"  # Delete the remote tag
done

echo "All tags have been removed from all branches."
