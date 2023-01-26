#! /bin/bash

clearBranches()
{
    local wd
    wd=$(pwd)
    for dir in $(ls)
    do
      cd "$wd/$dir"
      if [[ $(ls -a | awk '$1 == ".git" {print $0}') ]]; then
        echo "start clear $dir"
        git fetch -p;
        for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}')
        do
          git branch -D $branch
        done
      else
        echo "check into $dir"
        clearBranches
      fi
    done
}
clearBranches
