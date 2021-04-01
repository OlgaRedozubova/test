#!/usr/bin/env bash
set -eu

#REPO="https://<user>:${{ secrets.user_token }}@github.com/org/dest-repo"
repo_uri="https://x-access-token:$DEPENDENCIES_TOKEN@github.com/OlgaRedozubova/smiles-test.git"
remote_name="origin"
main_branch="master"
target_branch="dependencies-latest-4"

#REPO="https://x-access-token:$DEPENDENCIES_TOKEN@github.com/$GITHUB_REPOSITORY.git"
#REPO="https://github.com/OlgaRedozubova/smiles-test.git"
# Create Temporary Directory
TEMP=$(mktemp -d)

# Setup git
git config --global user.name "$GITHUB_ACTOR"
git config --global user.email "$GITHUB_EMAIL"

echo "git repo_uri=> $repo_uri"
echo "git GITHUB_USERNAME=> $GITHUB_USERNAME"
echo "git REPOSITORY_NAME=> $REPOSITORY_NAME"
echo "git GITHUB_REPOSITORY=> $GITHUB_REPOSITORY"

git clone "$repo_uri" "$TEMP"
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
