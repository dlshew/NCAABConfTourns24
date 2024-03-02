I decided to looks at some basic stats and apply a few different models to see if I can find anything predictive about college basketball conference tournaments. There’s going to be a lot of words, plots, and code here so I’m going to split it into 5 parts. The first one will be explaining the process of cleaning the data, some basic charts, and other information to give us an idea of how teams that win typically look. The second will be some basic regression with the Julia GLM package. The third is decision trees and random forest classifiers with the Julia MLJ package. The fourth will be a deep learning model using the Julia Lux package. The 5th will be some predictions and model comparisons.
In the first part I would consider the data cleaning part as mostly skippable, unless your into that kind of stuff. In general though you can jump around and read it however you want. What parts your interested in will depend on personal preference, some people will want predictions, some will want to see the charts and stats to make their own predictions, and other people will want the code. Generally I’m going to try and put as little as code as possible into the writing but there will be a little just to show the process. The rest is all available in this GitHub repo.
 I made a couple choices that may hurt the predictions but makes getting the data easier. I decided to use only use stats available at Bart Torvik's site (https://barttorvik.com/#) because you can get pre conference tournament data without any web scrapping. Its also free if anyone wants to try and replicate this or do anything else like it. There’s a site (https://adamcwisports.blogspot.com/p/data.html) where Torvik explains how to get data and ask you to please not scrape his site, I recommend using it since he does give it all away for free. For the most part I just went to the part of his site I wanted and added CSV=1 to the url. The issue with this approach is the data came back pretty ugly without column names or conferences. This meant a decent amount of cleaning. You can see everything I did in the cleaning.jl file. I went over the top and made like 40 CSV files. We’re mostly only going to use 6 but since I was cleaning the data I figured I might want it split into different versions at some point. That’s why there’s so many lines of code it wasn’t as bad as I or time consuming as I made it. Feel free to downlaod the CSV files, images, code, or whatever that gets saved here.
There may be issues with the data I tried checking it as much as I could but I wouldn't be surprised if everything was perfect. I also used old KenPom data I had to add the conferences, which is the most likely thing I messed up. Some parts of the code are pretty ugly and some are inefficient. I plan on cleaning it up but tournaments start March 4th and I wanted it running by then. If you have any complaints or advice you can let me know, I appreciate it either way. That’s all I got for an intro feel free to go to whatever part interest you the most.
