#!/usr/bin/env bash
set -eu

repo_uri="https://x-access-token:$DEPENDENCIES_TOKEN@github.com/$GITHUB_REPOSITORY.git"
remote_name="origin"
main_branch="master"
target_branch="dependencies-latest"

cd "$GITHUB_WORKSPACE"

echo "GITHUB_WORKSPACE => $GITHUB_WORKSPACE"

git config user.name "$GITHUB_ACTOR"
git config user.email "$GITHUB_EMAIL"

echo "git status=> "

git status

# start out with a pristine target branch
git checkout -B "$target_branch"

echo "git branch=> "

git branch


npm install mathpix-markdown-it

git add .

git commit -m "updated dependencies"
if [ "$?" != "0" ]; then
	echo "nothing to commit"
	exit 0
fi

git remote set-url "$remote_name" "$repo_uri"
git push --force-with-lease "$remote_name" "$target_branch"
