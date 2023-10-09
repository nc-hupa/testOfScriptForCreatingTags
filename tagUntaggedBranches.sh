#!/bin/bash

REMOTE_REPO_URL="https://github.com/nc-hupa/testOfScriptForCreatingTags.git"  # Replace this with your remote repository URL

# Fetch branches starting with "release/"
git fetch origin 'refs/heads/release/*:refs/remotes/origin/release/*'

# Check if a branch has been merged into master
function is_branch_merged {
    local branch_name=$1
    git branch -r --merged origin/master | grep -q "origin/$branch_name"
    return $?
}

# Iterate over remote branches starting with "release/"
for branch in $(git branch -r | grep 'origin/release/' | sed 's/origin\///'); do
    # Extract version number from branch name (assuming branch name is in the format release/x.x.x)
    version=$(echo "$branch" | sed 's/release\///')

    # Check if the branch has been merged into master
    if is_branch_merged "$branch"; then
        # Check if the tag already exists
        if git rev-parse -q --verify "v$version" >/dev/null; then
            echo "Tag v$version already exists. Skipping branch $branch."
        else
            # Create a Git tag for the branch
            git tag -a "v$version" -m "Version $version" "origin/$branch"

            # Push the tag to the remote repository
            git push origin "v$version"

            echo "Tag v$version created and pushed for branch $branch."
        fi
    else
        echo "Branch $branch has not been merged into master. Skipping."
    fi
done

echo "Tags created and pushed successfully."





