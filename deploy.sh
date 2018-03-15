#!/bin/bash
message=$1
#hexo clean
#hexo g
#hexo deploy
git add .
git commit -m '$message'
git push origin master 
