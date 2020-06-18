#!/usr/bin/env bash

while read p; do
    OLD_REPO=$(echo $p | cut -d' ' -f1)
    NEW_REPO=$(echo $p | cut -d' ' -f2)
    echo old $OLD_REPO
    echo new $NEW_REPO

    rm -rf repo || true
    git clone $OLD_REPO repo

    cd repo

    echo pulling branches
    for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master `; do
        git branch --track ${branch#remotes/origin/} $branch
    done

    echo changing history
    git filter-repo --mailmap ../mailcap.txt

    echo updating repo path
    git remote rm origin
    git remote add origin $NEW_REPO

    echo pushing
    git push --all --force
    git push --tags --force

    cd ..
done < "repos.txt"