# Motivation
I took an astronomy course in University that had an open-book midterm and final. Being the cheap student I am, I refused to buy the textbook for over $100. As such, I had to collect my own resources to in order to maximize my performance on the exams. After having written the midterm, it came to my attention that the multiple choice questions on the exam was very similar (if not identical) to some of the sample questions provided by Mastering Astronomy. This program was written in order to rip the questions and answers for every chapter from Mastering Astronomy.

# AstroScam
AstroScam is a Ruby script written to rip the Reading Quiz and Concept Quiz questions and answers from Mastering Astronomy. Ruby was chosen as the language of choice due to its powerful regex support. The script uses the Watir framework to automate web browsing.

The script prompts for a username and password in order to access Mastering Astronomy. Since the correct answer is not displayed unless the question has been tried, the script automates selecting the first option for every question. It then prints as output the questions and answers in LaTeX format. The output can then compiled with a table of contents (generated through LaTeX).

# How to Use
Clone the repository
```
  git clone https://github.com/henry252525/AstroScam.git
```
Open your command line and `cd` to where you cloned the repository. Run the script and follow instructions
```
  ruby scam.rb
```
**Note**: You need to have Ruby installed and any gem that's used.
