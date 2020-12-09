#!/bin/bash
#mk git repo
echo "# $1" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M master
git remote add origin https://github.com/rayiik/"$1".git
git push -u origin master

git push  --set-upstream https://github.com/rayiik/cheatsheets master
