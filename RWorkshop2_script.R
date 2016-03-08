# =======================================
# R Code from Workshop 2
# held 02/19/2016
# Melinda Higgins, PhD.
# =======================================

# =======================================
# PART 1
# =======================================
# check which directory you are currently in
# with getwd(). Then change it to the directory
# you want to be working in using setwd().

getwd()
setwd('C:/MyR/2016_Spring_RWorkshops')
getwd()

# clean up your global environment - remove
# all of the objects. Useful when you 1st
# start a new study/set of analyses/project.

rm(list = ls())
ls()

# let's create some new objects

x <- 3 * 8 + 6
y <- 1:12
y2 <- y**2

# let's combine y and y2 both of which are vectors of length 12
# with the 2 Constants month.abb and month.name.
# an easy way to do this is to use cbind() - but this will 
# make (or coerce) ALL of the vectors to the same type.
# Here we're mixing numbers and characters, so R makes them all
# character variables.

df1 <- cbind(y, y2, month.abb, month.name)

# another way to do this is using the data.frame() function
# the data frame can handle multiple different data types at the 
# same time. The data frame is actually a specical case of a list type
# which also mixes different types of objects and variables.
#
# since y, y2, month.abb and month.name are all the same
# length of 12 - we can combine them together as follows.
# data frames require the vectors to all be the same length.

df1a <- data.frame(y,y2,month.abb,month.name)

# lists are more general - you can mix and match types of variables
# and mix and match types of objects. In the example below 
# we can combine 3 objects
#   x - a single number (vector of length 1)
#   y - a integer vecotr of length 12
#   df1a - the data frame we created above

list1 <- list(x,y,df1a)

# for the dataset we created using cbind() above, df1
# we can "select" elements from inside df1 as follows.
# you can select elements using the object name
# followed by brackets []. Inside the brackets
# you can put in 2 values - the row number followed by
# the column number separated by a comma.
# let's select the ELEMENT in row 3, column 3
# of df1.

df1[3,3]

# we can also select a whole column by leaving the row
# value empty which implies to select all rows and then
# only provide the column number after the comma.
# let's select COLUMN 3 of df1.

df1[,3]

# we can also select a whole row by leaving the column
# value empty which implies to select all columns and then
# only provide the row number before the comma.
# let's select ROW 5 of df1.

df1[5,]

# as we noted above ALL of the elements in df1 are
# character type becuase we used the cbind() command
# and we mixed numeric and character type vectors.
# we can confirm this by using the class() and str()
# functions to see the class and structure of 
# the 1st column of df1.

df1[,1]
class(df1[,1])
str(df1[,1])

# Let's compare this with the 1st column of df1a which was
# created using the data.frame() command where the types of
# vectors could be mixed together.
# so the class() and str() of df1a[,1] should be
# an integer type instead of character type.

df1a[,1]
class(df1a[,1])
str(df1a[,1])

# let's make some more objects. we'll create a sequence
# of numbers from 0 to 10 in units of 0.5.

z <- seq(from=0,to=10,by=.5)
# this is the same as z <- seq(0,10,.5) where the argument
# settings are recognized by the sequence listed
# the from argument is first, followed by to, 
# followed by by - see help(seq).

# next let's take the sin() of these values
sinz <- sin(z)

# and we'll put both z and sinz into another data frame.
df2 <- data.frame(z, sinz)

# now that we've put y and y2 into df1 and df1a
# and we put z and sinz into df2, we can remove
# the individual objects y, y2, z, sinz which are now
# redundant. so we clean up our workspace by
# removing rm() these objects.

ls()
rm(y, y2, z, sinz)
ls()

# ls() is the basic list command - only lists the objects
# ls.str() also provide the structure of each object
# when listed to the console

ls()
ls.str()

# let's select the 1st column of df2.
# in addition to using the brackets []
# you can also SELECT variables in lists or in
# data frames by using the $ dollar sign which is
# another selector in R.
# also you can put comments after code

df2[,1] # use the column number
df2$z # select by column name

# you can combine these selectors.
# here were use the $ dollar sign to select
# the column "month.name" in df1a.
# once that column is selected, we can use the
# brackets to pull out the 3rd element
# this should be the month name "March"
# suppose select 3rd row for month.name in df1a

df1a$month.name[3]

# let's save our current workspace
# this saves all objects
save.image("workshop2objects.RData") # save all objects

# we can also save a specific object
save(df2, file="df2.RData") # save only df2

# let's clean up our workspace and remove everything
rm(list = ls())

# we can then only load back 1 data frame df2
load(file="df2.RData")
ls()

# or we can load back the whole workspace and
# bring back ALL of the objects we had before.
load("workshop2objects.RData")
ls()

# =======================================
# PART 2
# datafiles at DROPBOX
# at https://www.dropbox.com/sh/vlo5bzrl5ayo1bk/AADD0WieyuEdyGwiveuCoRr-a?dl=0
# =======================================
# we can read in a CSV comma delimited file
# using read.table() from base R. We give it the
# filename, that there is a header row, and that the
# separator or delimiter used was a comma.

data.rt <- read.table(file="C:/MyGithub/A_Series_of_R_Workshops/datasets/Dataset_01_comma.csv",
                      header=TRUE,sep=",")
data.rt

# there is also a function read.csv() that knows by default
# to include a header row and that the delimiter is a 
# comma. So, I can used read.csv and only provide the
# filename.

data.csv <- read.csv(file="C:/MyGithub/A_Series_of_R_Workshops/datasets/Dataset_01_comma.csv")
data.csv

# there is also a function read.delim() that knows by default
# to include a header row and it sets the delimiter to a 
# TAB by default. So, I can used read.delim
# for a TAB delimited file and only provide the
# filename.

data.tab <- read.delim(file="C:/MyGithub/A_Series_of_R_Workshops/datasets/Dataset_01_tab.txt")
data.tab

# what about EXCEL files: XLS and XLSX formats
# note you need to install readxl package first
# install.packages("readxl")
# once you install this package, load it into
# memory using the library() function.

library(readxl)

# the readxl package is useful and only focuses
# on EXCEL files. It has 2 functions read_excel() and
# excel_sheets(). See the help for this package.

help(package="readxl")

# we'll use the read_excel() function to read in a 
# dataset in both XLS (earlier 1997-2003 EXCEL format)
# and the 2007 and later EXCEL format XLSX.

data.xls <- read_excel("C:/MyGithub/A_Series_of_R_Workshops/datasets/Dataset_01.xls", sheet=1)
data.xls

data.xlsx <- read_excel("C:/MyGithub/A_Series_of_R_Workshops/datasets/Dataset_01.xlsx", sheet=1)
data.xlsx

# to read in SPSS and other software formats, we'll use the
# foreign package. Again you'll need to install it first.
# install.packages("foreign") and the load it with library().

library(foreign)

help(package="foreign") # see list of software formats

# to read in a SPSS file, we need to mainly give it the
# name of the file. But we'll also make sure the data
# comes in as a data frame to make it easier to work with.

data.spss <- read.spss(file = "C:/MyGithub/A_Series_of_R_Workshops/datasets/Dataset_01.sav",
                       to.data.frame=TRUE)
data.spss

# from here let's work with data.csv
# since we have weights and height we can compute
# BMI. Let's do that here with weights in pounds and
# heigh in decminal feet which we'll convert to
# inches in the formula given here.
# you'll notice that I'm selecting the variables
# using the $ dollar sign. I'm also creating 2 NEW
# variables bmiPRE and bmiPOST. By creating them
# on the left side of the <- and using the $
# this automatically APPENDS these new variables to the
# exisiting data frame "data.csv". When we do this
# the data frame data.csv will go from having 8
# variables to 9 and then to 10. Watch the global
# environment window as you run each line of code below.

data.csv$bmiPRE <- (data.csv$WeightPRE*703)/((data.csv$Height*12)**2)
data.csv$bmiPOST <- (data.csv$WeightPOST*703)/((data.csv$Height*12)**2)

# so, yes, it is a pain to have to type in the data frame
# followed by a dollar sign and then the variable.
# if you know for sure you're going to mainly be working
# with one data frame. You can ATTACH the variables inside
# data frame to your current environment so you can
# access the variables withouth having to type
# the name of the data fram and $ each time.
#
# for more info see this blog post at R-boggers
# http://www.r-bloggers.com/to-attach-or-not-attach-that-is-the-question/
#
# once we attach the dataset, you can call the variables
# directly. see example below to compute the
# change in BMI from PRE-to-POST and then find
# the mean of these differences.

attach(data.csv)

diff <- bmiPOST - bmiPRE
mean(diff)

detach(data.csv)

# ALWAYS remember to DETACH your data frame when finished.

# now that we have a new variable created "diff" it is 
# sitting in the global environment not attached to the
# original data frame. so, we can add it to the 
# data frame data.csv as follows:

data.csv$diff <- diff

# now that we've updated our dataset, let's save it
# using the basic save() function we can save it as
# a R formatted file xxx.RData

save(data.csv, 
     file="C:/MyGithub/A_Series_of_R_Workshops/datasets/datacsv.RData")

# we can also save the dataset as a CSV comma delimited
# or TAB delimited format using the write.csv()
# and write.delim() functions built into R.

write.csv(data.csv, 
          file="C:/MyGithub/A_Series_of_R_Workshops/datasets/datacsv.csv")

write.table(data.csv, 
            file="C:/MyGithub/A_Series_of_R_Workshops/datasets/datacsv.txt",
            sep="\t")

# =======================================
# PART 3
# =======================================
#
# if you closed out and reopened R
# let's make sure we have the data file in our
# environment.

data.csv <- read.csv(file="C:/MyGithub/A_Series_of_R_Workshops/datasets/Dataset_01_comma.csv")

# in base R the summary() function is a quick way to 
# get summary statistics on every variable
# inside a data frame as follows.

summary(data.csv)

# let's also make a histogram using the hist()
# function. I added back the BMI equations
# to make sure these are in the dataset.

data.csv$bmiPRE <- (data.csv$WeightPRE*703)/((data.csv$Height*12)**2)
data.csv$bmiPOST <- (data.csv$WeightPOST*703)/((data.csv$Height*12)**2)
hist(data.csv$bmiPRE)

# you'll notice there is an obvious outlier
# in the dataset for BMI PRE. This is due to a typo in
# height. so, let's fix the typo for subject 18.
# the typo in height for subject 18's
# data was 2.6, this should be 5.6
# we can reference this value by specifying
# the row number (which is also the subject ID here)
# and reference the column by using the 
# column name which is "Height"

data.csv[18,"Height"] <- 5.6

# we could also use logic to find the height
# that was too low (findrow). Then use that logic
# vector to select only the row that was true.

findrow <- (data.csv[,"Height"] < 5)
data.csv[findrow,"Height"]

# now that we fixed height, recompute BMI at
# PRE and at POST. Then redo the histogram.
# this time I added the option freq=FALSE
# which will make the histogram in terms
# of density or proportion (0 to 1) instead
# of using the raw frequency counts like before.
# then we add a non-parametric "density" curve.

data.csv$bmiPRE <- (data.csv$WeightPRE*703)/((data.csv$Height*12)**2)
data.csv$bmiPOST <- (data.csv$WeightPOST*703)/((data.csv$Height*12)**2)
hist(data.csv$bmiPRE, freq=FALSE)
lines(density(data.csv$bmiPRE))

# we can also make a scatterplot of the PRE BMI's
# versus the POST BMIs to compare them and see
# how correlated they were. First the scatterplot
# with some nicer labels.

plot(data.csv$bmiPRE, data.csv$bmiPOST, "p",
     xlab="BMI at PRE",
     ylab="BMI at POST",
     main="Compare BMI at PRE and POST")

# then overlay the best fit line using abline
# which pulls the intercept and slope
# from the linear model lm() regressing
# the POST BMI on the PRE BMI's.
abline(lm(data.csv$bmiPOST ~ data.csv$bmiPRE), col="red")

# I also added a second line with is using the non-parametric
# lowess() function to find the best fit smoothed line
# through the points. this is added with the lines()
# function.
lines(lowess(data.csv$bmiPRE, data.csv$bmiPOST), col="blue")







