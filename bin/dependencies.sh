#!/usr/bin/env bash
set -eu

repo_uri="https://x-access-token:$DEPENDENCIES_TOKEN@github.com/$GITHUB_REPOSITORY.git"
remote_name="origin"
main_branch="master"
target_branch="dependencies-latest-3"

#REPO="https://x-access-token:$DEPENDENCIES_TOKEN@github.com/$GITHUB_REPOSITORY.git"
REPO="https://github.com/OlgaRedozubova/smiles-test.git"
# Create Temporary Directory
TEMP=$(mktemp -d)

# Setup git
git config --global user.name "$GITHUB_ACTOR"
git config --global user.email "$GITHUB_EMAIL"

git clone "$REPO" "$TEMP"
cd "$TEMP"
echo "git status=> "

git status

git remote -v
echo "git remote=> "

# start out with a pristine target branch
git checkout -B "$target_branch"

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

echo "push origin => $target_branch"
#git push origin "$target_branch"

#git remote set-url "$remote_name" "$repo_uri"
git push --force-with-lease "$remote_name" "$target_branch"
