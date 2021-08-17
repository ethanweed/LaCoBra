#!/bin/bash

# Course info
pandoc --standalone /Users/ethan/Documents/GitHub/LaCoBra/2021/Syllabus.md -o /Users/ethan/Documents/GitHub/LaCoBra/2021/Syllabus.html

# Slides
pandoc -t revealjs -s -o /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Aphasia1.html /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Aphasia1.md -V revealjs-url=https://unpkg.com/reveal.js@3.9.2/



# Push to github

git add -A
git commit -m "auto updated from desktop"
git push