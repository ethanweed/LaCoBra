#!/bin/bash

# Course info
pandoc --standalone /Users/ethan/Documents/GitHub/LaCoBra/2021/Syllabus.md -o /Users/ethan/Documents/GitHub/LaCoBra/2021/Syllabus.html

pandoc --standalone /Users/ethan/Documents/GitHub/LaCoBra/2021/Schedule.md -o /Users/ethan/Documents/GitHub/LaCoBra/2021/Schedule.html

# Assignments
pandoc --standalone /Users/ethan/Documents/GitHub/LaCoBra/2021/Assignments/Assignment_01_NeuroanatomyQuiz.md -o /Users/ethan/Documents/GitHub/LaCoBra/2021/Assignments/Assignment_01_NeuroanatomyQuiz.html

pandoc --standalone /Users/ethan/Documents/GitHub/LaCoBra/2021/Assignments/Assignment_02_NeuroanatomyQuiz.md -o /Users/ethan/Documents/GitHub/LaCoBra/2021/Assignments/Assignment_02_NeuroanatomyQuiz.html

pandoc --standalone /Users/ethan/Documents/GitHub/LaCoBra/2021/Assignments/Assignment_03_NeuroanatomyQuiz.md -o /Users/ethan/Documents/GitHub/LaCoBra/2021/Assignments/Assignment_03_NeuroanatomyQuiz.html

# ---------------------------------------- 

# Slides

## Lecture Slides

pandoc -t revealjs -s -o /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Lecture_01_Introduction.html /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Lecture_01_Introduction.md -V revealjs-url=https://unpkg.com/reveal.js@3.9.2/

pandoc -t revealjs -s -o /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Lecture_02_Aphasia1.html /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Lecture_02_Aphasia1.md -V revealjs-url=https://unpkg.com/reveal.js@3.9.2/

pandoc -t revealjs -s -o /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Lecture_03_PPA_NeuralRepresentation.html /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Lecture_03_PPA_NeuralRepresentation.md -V revealjs-url=https://unpkg.com/reveal.js@3.9.2/

pandoc -t revealjs -s -o /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Lecture_04_SpeechPerception1.html /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Lecture_04_SpeechPerception1.md -V transition=none -V revealjs-url=https://unpkg.com/reveal.js@3.9.2/


## Lab Slides

pandoc -t revealjs -s -o /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Lab_01_Stroop.html /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Lab_01_Stroop.md -V revealjs-url=https://unpkg.com/reveal.js@3.9.2/

pandoc -t revealjs -s -o /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Lab_01_Introduction.html /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Lab_01_Introduction.md -V revealjs-url=https://unpkg.com/reveal.js@3.9.2/

pandoc -t revealjs -s -o /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Lab_02_ResearchDesign.html /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Lab_02_ResearchDesign.md -V revealjs-url=https://unpkg.com/reveal.js@3.9.2/

pandoc -t revealjs -s -o /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Lab_03_HypothesisTesting.html /Users/ethan/Documents/GitHub/LaCoBra/2021/Slides/Lab_03_HypothesisTesting.md -V revealjs-url=https://unpkg.com/reveal.js@3.9.2/





# ---------------------------------------- 

# Push to github

git add -A
git commit -m "auto updated from desktop"
git push