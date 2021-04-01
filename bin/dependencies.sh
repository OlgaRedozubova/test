#!/usr/bin/env bash
set -eu

repo_uri="https://x-access-token:$DEPENDENCIES_TOKEN@github.com/$GITHUB_USERNAME/$REPOSITORY_NAME.git"

# Create Temporary Directory
TEMP=$(mktemp -d)

# Setup git
git config --global user.name "$GITHUB_ACTOR"
git config --global user.email "$GITHUB_EMAIL"

echo "... repo_uri=> $repo_uri"
echo "... GITHUB_USERNAME=> $GITHUB_USERNAME"
echo "... REPOSITORY_NAME=> $REPOSITORY_NAME"
echo "... GITHUB_REPOSITORY=> $GITHUB_REPOSITORY"

git clone "$repo_uri" "$TEMP"
cd "$TEMP"
echo "git status=> "

git status

git remote -v
echo "git remote=> "

# start out with a pristine target branch
git checkout -B "$TARGET_BRANCH"

echo "git branch=> "
git branch


npm install mathpix-markdown-it

echo "git add=> "
git add .

echo "git commit=> "
git commit -m "updated dependencies 3"
#if [ "$?" != "0" ]; then
#	echo "nothing to commit"
#	exit 0
#fi

echo "git log=> "
git log

echo "push origin => $TARGET_BRANCH"

#git remote set-url "$remote_name" "$repo_uri"
git push --force-with-lease "$REMOTE_NAME" "$TARGET_BRANCH"
