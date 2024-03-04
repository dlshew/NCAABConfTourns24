*If your here on the 4th this isn't ready yet only the part 5 link and I'm behind on that.

I decided to looks at some basic stats and apply a few different models to see if I can find anything predictive about college basketball conference tournaments. There’s going to be a lot of words, plots, and code here so I’m going to split it into 5 parts. The first one will be explaining the process of cleaning the data, some basic charts, and other information to give us an idea of how teams that win typically look. The second will be some basic regression with the Julia GLM package. The third is decision trees and random forest classifiers with the Julia MLJ package. The fourth will be a deep learning model using the Julia Lux package. The 5th https://docs.google.com/document/d/15zAJxRoarIvmlGH3pme2DRRLyUpUqSXvBlvoFGhPLh0/edit?usp=sharing will be the actual predictions from all the models.

The first four parts are going to more about the process of building the models and cleaning the datasets. I think there is some intresting stuff in them but if you just want the predictions you can skip to part 5. Starting with 5 and then going back to read from the beginning might be the best use of your time since tournaments are starting now. (My guess is the ASun will have already started by the time I get this out.) I made the decision to try and put as little as code as possible into the writing to make it more readable but there will be a little just to show the process. The rest is all available in this GitHub repo.

A couple choices I made may hurt the predictions I only used data from 2016 to 2023, minus the COVID year, which may not be enough. But my personal belief is when it comes to sports I don't love going back to far just because the way games are played is constantly changing. If I do this again I probably will add a few more year though. The biggest issue though is I didn't include past seeds, which means I didn't take into account how the tournaments are set up (byes, homecourt,...) I think this could be a huge disadvantage. In general the context dependent stuff that's missing just means I wouldn't use any of this blindly because the models are also missing any recent injury information. I also decided to use only use stats available at Bart Torvik's site (https://barttorvik.com/#) because you can get preconference tournament data without any web scrapping. This approach limited the number of stats availble and they're pretty basic.

But I decided no scrapping and it being free would allow other people to use this more easily and the trade off was worth it. There’s a site (https://adamcwisports.blogspot.com/p/data.html) where Torvik explains how to get data and ask you to please not scrape his site. For the most part I just went to the part of his site I wanted and added csv=1 to the url. The issue with this approach is the data came back pretty ugly without column names or conferences. This meant a decent amount of cleaning. You can see everything I did in the cleaning.jl file. I went over the top and made like 40 CSV files. We’re only going to use a few but since I was cleaning the data I figured I might as well have it split a bunch of ways just in case. That’s why there’s so many lines of code it wasn’t as bad as I or time consuming as I made it. Feel free to downlaod the CSV files, images, code, or whatever that gets saved here.

There may be issues with the data I tried checking it as much as I could but I wouldn't be surprised if everything wasn't perfect. I also used old KenPom data I had to add the conferences, which is the most likely thing I messed up. Some parts of the code are pretty ugly and some are inefficient. I plan on cleaning it up but one tournament starts March 4th and a few more the 5th and I wanted it running by the 5th. Feel free to download any of the files or use any of the code. If you have any complaints or advice you can let me know, I appreciate it either way. An example of the end product for the Big 10 is below.
