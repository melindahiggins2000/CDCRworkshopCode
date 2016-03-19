# ========================================
# Day 2, March 11, 2016
# code and comments updated
# as of March 16, 2016
#
# by Melinda Higgins, PhD.
# ========================================

# DAY 2 ==================================

# ======================================
# make sure your directory is set
# ======================================

getwd()
setwd("C:/MyGithub/CDCRworkshopCode")

# ======================================
# today's sessions will focus
# more on data management
# creating new variables
# recoding and missing data
# ======================================

# ======================================
# let's create Gender as a Factor
# instead of as just number codes
# Factors are useful in plots
# and tables providing labels for the
# labels. Factors are also helpful
# in various models.
# ======================================

# reload the datafile
data.csv <- read.csv(file="Dataset_01_comma.csv")
data.csv

# fix the typo in Height and compute 
# BMI at both time points
data.csv[18,"Height"] <- 5.6
data.csv$bmiPRE <- (data.csv$WeightPRE*703)/((data.csv$Height*12)**2)
data.csv$bmiPOST <- (data.csv$WeightPOST*703)/((data.csv$Height*12)**2)

# create a factor variable for gender
data.csv$GenderFactor <- factor(data.csv$GenderCoded,
                                levels = c(1,2),
                                labels = c("Male","Female"))

# look at dataset to make sure the new
# gender factor was added successfully
data.csv
head(data.csv[,c("GenderCoded","GenderFactor")])

# look at this factor variable including
# the structure and class
data.csv$GenderFactor
str(data.csv$GenderFactor)
class(data.csv$GenderFactor)

# table() is similar to PROC FREQ in SAS
# which is useful for summarizing
# factor variables.
# the option useNA can be set to list any missing NAs
table(data.csv$GenderFactor)
table(data.csv$GenderFactor, useNA = "ifany")

# alternatively you can use the option
# exclude = NULL
table(data.csv$GenderFactor, exclude = NULL)

# once a factor is created and the
# labels defined, these are helpful
# when constructing and labeling a plot
# compare making a barplot with the
# numeric coded variables compared
# to the factor variable
barplot(table(data.csv$GenderCoded))
barplot(table(data.csv$GenderFactor))

# try some more recoding
# create new variable with BMI categories
# we'll use within() function to make the 
# coding easier
# the code below creates 2 new variables
# with character labels for each category

# using logical operators to
# find (index) rows where the
# logical condition is TRUE
# two equal signs together == tests for TRUE
# putting an exclamation point in front
# of the equal sign means "not equal to" !=
# see what results these expressions provide

data.csv$Age == 45
data.csv$Age != 45
data.csv$GenderFactor != "Female"

# ====================================
# NOTE on MISSING DATA
# it is important to note that missing data
# NAs cannot be "found" using logic statements
# ====================================
# set the variable a to missing NA
a <- NA

# notice that all 4 of these logic comparisons
# result in NA - by definition missing data
# is unknown and cannot be compared to anything
a == NA
a < NA
a > NA
a != NA

# two ways to find missing data using R is the 
# function is.na() and anyNA() - both of these
# statements result in TRUE
is.na(a)
anyNA(a)

# create categorical variables for BMI
# note you need to initialize the new variable
# bmiPREcat with NAs (missing) to start
data.csv <- within(data.csv,{
  bmiPREcat <- NA
  bmiPREcat[bmiPRE < 18.5] <- "underweight"
  bmiPREcat[bmiPRE >= 18.5 & bmiPRE < 25] <- "normal"
  bmiPREcat[bmiPRE >= 25 & bmiPRE < 30] <- "overweight"
  bmiPREcat[bmiPRE >= 30 & bmiPRE < 60] <- "obese"
})

# notice that this new categorical variable
# is a character variable and the categories
# are listed in alphabetical order not
# in the order we expect (i.e. overweight before obese)
str(data.csv$bmiPREcat)

# look at the frequencies - with and without the missing NAs
table(data.csv$bmiPREcat, exclude = NULL)
table(data.csv$bmiPREcat)

# now create the categories again 
# for the POST BMI
data.csv <- within(data.csv,{
  bmiPOSTcat <- NA
  bmiPOSTcat[bmiPOST < 18.5] <- "underweight"
  bmiPOSTcat[bmiPOST >= 18.5 & bmiPOST < 25] <- "normal"
  bmiPOSTcat[bmiPOST >= 25 & bmiPOST < 30] <- "overweight"
  bmiPOSTcat[bmiPOST >= 30] <- "obese"
})

# frequency summary for BMI POST categories
# with and without missing NAs
table(data.csv$bmiPOSTcat)
table(data.csv$bmiPOSTcat, exclude=NULL)

# note the structure of these new
# categorical variables - character NOT factors
str(data.csv$bmiPREcat)
str(data.csv$bmiPOSTcat)

# you can look at the data by listing which
# variables you want to look at
# and they will be shown in the order you list
# the variables
data.csv[,c("bmiPRE","bmiPREcat","bmiPOST","bmiPOSTcat")]

# you can also use this approach to rearrange the columns of
# data in your dataset to the order of interest.
# here is an example of rearranging the variables
# in this dataset.
# the current order of variables:
#' "SubjectID"    
#' "Age"          
#' "WeightPRE"    
#' "WeightPOST"  
#' "Height"       
#' "SES"          
#' "GenderSTR"    
#' "GenderCoded" 
#' "bmiPRE"       
#' "bmiPOST"      
#' "GenderFactor" 
#' "bmiPREcat"   
#' "bmiPOSTcat"
#' 
#' let's create a variable with a new 
#' variable order

myvars <- c("SubjectID","Age","SES","GenderSTR",
            "GenderCoded","GenderFactor","Height",
            "WeightPRE","bmiPRE","bmiPREcat",
            "WeightPOST","bmiPOST","bmiPOSTcat")

data.csv.neworder <- data.csv[,myvars]
View(data.csv.neworder)

# ======================================
# Make Ordered Factor Variables
# ======================================
# notice that the table lists
# the categories in alphabetical order
# which is not what we want
# we would like "overweight" listed
# before "obese".
# so let's assign an order to our levels
# we will create an ordered factor

data.csv$bmiPREcat.or <- factor(data.csv$bmiPREcat,
                                order = TRUE,
                                levels = c("underweight", 
                                           "normal",
                                           "overweight",
                                           "obese"))

data.csv$bmiPOSTcat.or <- factor(data.csv$bmiPOSTcat,
                                order = TRUE,
                                levels = c("underweight", 
                                           "normal",
                                           "overweight",
                                           "obese"))

# compare the structure
# notice that "bmiPREcat.or" is listed as an
# Ord.factor "ordered factor".
str(data.csv$bmiPREcat)
str(data.csv$bmiPREcat.or)

# compare the tables for the unordered and ordered
# character variable and factor variable
# Notice that:
#   1. the 1st character variable only lists the
#      unordered categories WITH data
#   2. the Ordered Factor variable list the
#      categories in the correct order AND lists
#      the categories with 0 data (i.e. "underweight")
table(data.csv$bmiPREcat)
table(data.csv$bmiPREcat.or)
table(data.csv$bmiPOSTcat.or)

# we could update the order one more time
myvars <- c("SubjectID","Age","SES","GenderSTR",
            "GenderCoded","GenderFactor","Height",
            "WeightPRE","bmiPRE","bmiPREcat","bmiPREcat.or",
            "WeightPOST","bmiPOST","bmiPOSTcat","bmiPOSTcat.or")

data.csv.neworder <- data.csv[,myvars]
View(data.csv.neworder)

# now that we have the ordered factors
# we do NOT need to keep the unordered character
# variables "bmiPREcat" and "bmiPOSTcat". Let's
# set these to NULL and delete/remove them
# from our dataset. We'll do this for the "neworder"
# dataset data.csv.neworder.
data.csv.neworder$bmiPREcat <- NULL
data.csv.neworder$bmiPOSTcat <- NULL

# using these Ordered Factor categories
# create a barplot from the table frequencies
barplot(table(data.csv$bmiPREcat.or),
        main ="PRE BMI Categories")
barplot(table(data.csv$bmiPOSTcat.or),
        main ="POST BMI categories")

# alternative using with with() function
with(data.csv, 
     barplot(table(bmiPREcat.or),
             main ="PRE BMI Categories"))
with(data.csv, 
     barplot(table(bmiPOSTcat.or),
             main ="POST BMI Categories"))

# ==================================
# an example creating and working
# with missing NA data
# ==================================
# suppose we wanted to set all subjects
# under the age of 35 to missing

# first create a new variable for these
# ages set to missing "Age35plus"
data.csv$Age35plus <- data.csv$Age

# next find everyone < 35 and set them 
# all to NA missing
# this should set the ages for subjects 
# 5 and 15 to NA for the variable "Age35plus"
data.csv[data.csv$Age35plus < 35, "Age35plus"] <- NA

# let's summarise this data
# look at original "Age" variable and 
# the new variable "Age35plus"
summary(data.csv[,c("Age", "Age35plus")])

# define the variable list you're intereted in
# then use that as a filter to select only these variables
myvars <- c("Age", "Age35plus", "bmiPRE", "bmiPOST", "GenderFactor")
summary(data.csv[,myvars])

# suppose I just want the women
# define a filter for the rows or subjects
myrows <- data.csv$GenderFactor == "Female"
data.csv[myrows,myvars]
summary(data.csv[myrows,myvars])

# ==========================================
# you'll notice that the summary for every
# variable shows 1 NA this is because the 1 subject
# missing gender stays in the selected data
# we can fix this a couple of ways
# ==========================================
# METHOD 1: use the na.omit() function
#           however this will omit all rows
#           with ANY missing NAs data on any of 
#           the variables included
summary(na.omit(data.csv[myrows,myvars]))

# METHOD 2: A better way would be to fix it
#           at the myrows definition - add a statement
#           to make sure there is no missing data
myrows <- (data.csv$GenderFactor == "Female") & 
          (is.na(data.csv$GenderFactor) == FALSE)
data.csv[myrows,myvars]
summary(data.csv[myrows,myvars])

# another example for BMI's > 30 at PRE
# notice that the 2nd line of code is 
# exactly the same as above all we did was
# change which rows we wanted to see
myrows <- (data.csv$bmiPRE > 30) &
          (is.na(data.csv$bmiPRE) == FALSE)
data.csv[myrows,myvars]
summary(data.csv[myrows,myvars])

# find mean Age for all of the subjects
# and for those 35 and older
# with and without missing data
mean(data.csv$Age)
mean(data.csv$Age35plus) # this results in NA
# you have to tell R to remove the missing
# setting na.rm=TRUE.
mean(data.csv$Age35plus, na.rm=TRUE)

# same code above run using with() function
with(data.csv, mean(Age))
with(data.csv, mean(Age35plus))
with(data.csv, mean(Age35plus, na.rm=TRUE))

# find out how much missing data there is
# using the function is.na()
# is.na() returns a logic vector of TRUE and FALSE
is.na(data.csv$Age35plus)
# you can sum() these and the TRUEs are all 1
# and the FALSEs are all 0's, so it counts
# up the number of TRUEs.
sum(is.na(data.csv$Age35plus))

# you can also do this using the with() statement
with(data.csv, 
     sum(is.na(Age35plus)))

# how much missing NAs is in the whole dataset
# we have gender in here twice "GenderCoded" and
# "GenderFactor" each has 1 missing value for subject 9
# and we have 2 subjects (5 and 15) missing ages in the 
# "Age35plus" variable we created, so there should
# be 4 missing values in the whole dataset.
sum(is.na(data.csv))

# keep only data for complete cases
# subject 9 missing gender
# subjects 5 and 15 missing Age35plus
dataall <- na.omit(data.csv) 
# data without subjects 5, 9 and 15
# this new dataset now only has 17 subjects

# CREATE an INDEX to FIND MISSING CASES
# find which cases have missing data
# create an index to find the cases with
# no missing data using complete.cases() function
i <- complete.cases(data.csv)
i
# if we sum this index we'll find 17 cases
# have complete data
sum(i)

# we can use this index to find where
# complete.cases is NOT TRUE or is FALSE
# here are the options below.
# since i is a logical vector, we can use the 
# not operator ! to find all the cases where
# i is not TRUE or is FALSE
data.csv$SubjectID[!i]
data.csv$SubjectID[i==FALSE]

# perhaps a BETTER way to do this is to
# at the start find the cases 
# where complete.cases = FALSE
i <- complete.cases(data.csv)==FALSE
i
# if we sum this index we'll find
# 3 cases with incomplete data
sum(i)

# use this index to retrieve the list of subjects with
# incomplete data
data.csv$SubjectID[i]

# we can use the logic vector i to keep
# all of the cases with complete data 
# where i is FALSE
dataall2 <- data.csv[i==FALSE,]

# ===================================
# ALWAYS REMEMBER to SAVE
# you workspace as you go just in case
# ===================================
save.image("mycurrentwork.RData")

# clear your workspace and add everything back
rm(list=ls())
load("mycurrentwork.RData")

# ===================================
# make a plot using ggplot2 package
# for bmiPRE vs bmiPOST
# ===================================
library(ggplot2)

p <- ggplot(data.csv, aes(bmiPRE, bmiPOST)) + 
  geom_point() + 
  geom_smooth(method = "loess", colour = "red", se = FALSE) + 
  geom_smooth(method = "lm", colour = "blue") +
  ggtitle("BMI PRE v POST: RED smoothed line, BLUE linear fit line")
p

# ======================================
# we'll use the GenderFactor to split
# the plots into different panels by gender
# ======================================
p <- ggplot(data.csv, aes(bmiPRE, bmiPOST)) + 
  geom_point() + 
  geom_smooth(method = "loess", colour = "red", se = FALSE) + 
  geom_smooth(method = "lm", colour = "blue") + 
  facet_wrap(~GenderFactor) + 
  ggtitle("Panels for Gender, RED smoothed line, BLUE linear fit line")

p

# do the plot again but REMOVE the panel
# where GenderFactor is missing NA
myrows <- is.na(data.csv$GenderFactor) == FALSE
p <- ggplot(data.csv[myrows,], aes(bmiPRE, bmiPOST)) + 
  geom_point() + 
  geom_smooth(method = "loess", colour = "red", se = FALSE) + 
  geom_smooth(method = "lm", colour = "blue") + 
  facet_wrap(~GenderFactor) + 
  ggtitle("Panels for Gender, RED smoothed line, BLUE linear fit line")

p

# ======================================
# we can also use this factor to color
# code the points and associated model fits
# NOTE: It can be hard to see but 
# this plot includes the data for subject
# 9 who was missing gender - this subject
# shows up as a darker grey dot in the middle
# of the plot.
# ======================================
p <- ggplot(data.csv, aes(bmiPRE, bmiPOST)) + 
  geom_point(aes(colour = GenderFactor)) + 
  geom_smooth(method = "lm", aes(colour = GenderFactor)) + 
  ggtitle("Colored by Gender")

p

# ======================================
# let's take a quick look at the linear
# model object that has the output
# from fitting a linear model to the
# PRE and POST BMI data.
# Notice that the formula for the model
# is in the form y ~ x where the tilde ~
# symbol indicates y is "modeled as" or
# y is "modeled by" x.
# ======================================
fit1 <- lm(bmiPOST ~ bmiPRE, data=data.csv)

# look at the fit1 object. This only prints a minimal
# amount of output to the screen - the model and
# the fitted coefficients
fit1
# ALSO take a look at all of the pieces inside the 
# fit1 object in the "Global Environment" window
# at the top right  - notice that fit1 is a 
# list of 12 objects:
#     1. coefficients
#     2. residuals
#     3. effects
#     4. rank
#     5. fitted values
#     6. assign
#     7. qr
#     8. df.residual
#     9. xlevels
#     10. call
#     11. terms
#     12. model
# you can also see this list using the attributes()
# command which lists the named elements in the
# "fit1" list and the class of the fit1 object
attributes(fit1)
# You can also use the fix() function
# to see everything in plain text 
# but for large list objects
# this can get confusing fast
fix(fit1)

# the fit1 object is actually of class "lm"
# see help(lm) for more info - scroll down in the
# help listing for the description under "Value" which
# described the output from the lm() function.
# You can also learn a lot more from John Fox - see
# his book: "Applied Regression Analysis and Generalized Linear Models"
# and the companion book: "An R Companion to Applied Regression"
# this is where the "car" package comes from.
class(fit1)

# for the lm class objects there are some useful
# functions which help summarize and extract
# components from the fit1 object - here are
# a few of the helpful functions to see the various
# lm model results for "fit1"
# see more in help(lm) - scroll almost to bottom
# and look under the section "See Also" for more
# functions

# summary() gives you the usual regression output
# with information on the model (call)
# the residuals, the coefficients with std.error and t-tests
# and the model fit r2 stats and F-test results
# summary() here is a generic function that actually
# is running summary.lm() - see help(summary.lm).
summary(fit1)

# coef() is shorthand for coefficients()
# this only extracts the coefficients
coef(fit1)

# anova() extracts only the model fit
# statistics for the "Sums of Squares" table
anova(fit1)

# for RMarkdown - later example
# in the library "knitr" there is a function
# kabel() which will create a nice
# table in "markdown" formatting for creating
# RMD "Rmarkdown" documents. See Menu
# Help/Markdown Quick Reference - scroll down to
# bottom where they show the formatting for
# "Tables". the kable() function below from knitr
# will create a table in markdown formatting
# you have to make the coef() output into a data.frame
# first using as.data.frame().
library(knitr)
kable(as.data.frame(coef(fit1)))

# =================================
# find the column or variable
# names in a data set use names() function
# let's look at the built-in dataset
# mtcars
# =================================
names(mtcars)

# the mtcars dataset has 32 observations
# and 11 variables - see help(mtcars)
help(mtcars)

# ==================================
# we'll use the mtcars dataset below for
# some more examples
# ==================================
# to see more on the built-in datasets
help(package = "datasets")

# can also call data() to open a window with a
# compelte list of all datasets from the base R
# package and any that have been loaded with
# different packages thus far using the library()
# command.
data()

# look at mtcars and its structure
mtcars
str(mtcars)

# from the quick-R website - here is a 
# more complicated linear model using the
# mtcars dataset - for this we'll use
# some of the functions from the car package
library(car)
fit <- lm(mpg~disp+hp+wt+drat, data=mtcars)
summary(fit)

# we could if we wanted update
# the "cyl" number of cylinders from a 
# numeric variable to a factor variable
summary(mtcars[,c("mpg","cyl","disp","hp")])
mycars <- mtcars
mycars$cyl <- as.factor(mtcars$cyl)
summary(mycars[,c("mpg","cyl","disp","hp")])

# let's find some statistics on "mpg"
# we could use the basic summary()
# function or directly compute the mean() 
# or sd() standard deviation
summary(mtcars)
mean(mtcars$mpg)
sd(mtcars$mpg)

# we can also use other built in statistical
# functions like fivenum() to get the 5-number summary
# and quantile() to find specific percentiles we want
fivenum(mtcars$mpg)
quantile(mtcars$mpg, c(.25,.75))

# what if want a CUSTOM list of statistics?
# we can write our OWN function called mystats()
# here is an example function. We will also
# add a check at the beginning to make sure
# we are running the statistics for only
# the non-missing values. The code below does this
# NOTE: This example is adapted from the book:
# "R in Action" by Rob Kabacoff;
# see the "Quick-R" website http://www.statmethods.net/ 

mystats <- function(x, na.omit=FALSE){
  if(na.omit)
    x <- x[!is.na(x)]
  m <- mean(x)
  n <- length(x)
  s <- sd(x)
  med <- median(x)
  q5 <- quantile(x, .05)
  q25 <- quantile(x, .25)
  q75 <- quantile(x, .75)
  q95 <- quantile(x, .95)
  return(c(n=n, mean=m, stdev=s, Median=med, 
           q5, q25, 
           q75, q95))
}

mystats(mtcars$mpg)

# let's run mystats for every 
# variable in mtcars - for this we'll
# use the sapply() function which will
# "apply" the function (FUN) we specify
# to every variable column in our dataset.
sapply(X=mtcars, FUN=mean)
sapply(X=mtcars, FUN=fivenum)
sapply(X=mtcars, FUN=mystats)

# we can also save the output into
# an object "myoutput" to use/review later.
myoutput <- sapply(X=mtcars, FUN=mystats)
class(myoutput)
str(myoutput)
# notice that "myoutput" is a numeric MATRIX

# let's apply these to a list of variables
# we specify in the "mtcars" dataset
# and for our "mycars" dataset where "cyl"
# is now a factor.
myvars <- c("mpg","cyl","disp","hp")
sapply(mycars[myvars], fivenum) 
     # this generates an error since "cyl" is a factor
sapply(mtcars[myvars], fivenum)
     # this works ok

# since the output is a matrix, we can save
# it and use it with kable() for
# LATER RMARKDOWN RMD documents
out <- sapply(mtcars[myvars], fivenum)
kable(out)

# this time let's use our CUSTOM list
# of statistics from the "mystats()" function
# we created above.
sapply(mtcars[myvars], mystats)

# save the matrix output and make a table
out <- sapply(mtcars[myvars], mystats)
kable(out)

# select only rows of cars that have 6 cylinders
d1 <- mtcars[mtcars$cyl==6,myvars]
sapply(d1, mystats)

# select cars that have 4 cylinders (cyl==4) and 
# are automatic transmission (am==0)
d2 <- mtcars[(mtcars$cyl==4 & mtcars$am==0),myvars]
sapply(d2, mystats)

# can also use the subset() function
d3 <- subset(mtcars, cyl==4 & am==0, select=myvars)
d3
sapply(d3, mystats) # sort of silly for only 3 cars

# =================================
# MORE WAYS to get SUMMARY STATS
# =================================
# Hmisc package - use the describe() function
library(Hmisc)
myvars <- c("mpg","cyl","disp","hp")
describe(mtcars[myvars])

# pastecs package - use the stat.desc() function
library(pastecs)
stat.desc(mtcars[myvars])

# psych package - use the describe() function
# which has the SAME name as Hmisc above
# YES - this can get confusing!
library(psych)
# notice that we get WARNINGS about
# difference objects and functions
# which are now masked
describe(mtcars[myvars])

# TO AVOID CONFUSION
# avoid masking problems using 2 colons ::
# which links the package::function together
Hmisc::describe(mtcars[myvars])
psych::describe(mtcars[myvars])

# ================================
# summarizing data BY groups
# ================================

# descriptions by group - use the by() function
# we need to give it the data, the indices of the group
# and the function we want to use
by(data = mtcars$mpg, 
   INDICES = mtcars$cyl, 
   FUN = mean)

# you can also just list the arguments in order
# without explicitly defining them - "lazy" coding
by(mtcars$mpg, mtcars$cyl, mean)

# we can also apply our custom function
# mystats() - this creates a list with 3
# elements with the summary stats for
# each cylinder group (4, 6 or 8 cylinders).
out1 <- by(mtcars$mpg, mtcars$cyl, mystats)
out1

# We can modify mystats() slightly by 
# creating a new function dstats()
# to use in the by() function call below
# which creates a PRETTIER list
dstats <- function(x)sapply(x,mystats)
out2 <- by(data = mtcars[myvars], 
   INDICES = mtcars$cyl, 
   FUN = dstats)
out2

# using the NEW dstats() function with the
# PRETTIER lists we can use these with kable()
# to make tables of the summary stats BY 
# the cylinders category groups
out <- by(mtcars[myvars], mtcars$cyl, dstats)

# let's look at the components of "out"
out
class(out) # this is an object of class "by"

out[1]
class(out[1]) # the 1st object in the out list is 
              # a list itself, we have to use 2 [[]]
              # brackets to get to the summary we want

out[[1]]
class(out[[1]]) # this is a matrix

# we can use the "Matrix" parts of the output
# to make the tables we want later in a
# RMarkdown RMD document. in the example
# below, I've also added a caption and
# created the text using the paste() command
# which will combine numbers and text as
# specified. NOTE: The caption WON'T show up here
# but will show up in a RMarkdown RMD document.
kable(out[[1]], caption=paste(mtcars$cyl[1]," cylinders"))
kable(out[[2]], caption=paste(mtcars$cyl[2]," cylinders"))
kable(out[[3]], caption=paste(mtcars$cyl[3]," cylinders"))

# MORE WAYS to get SUMMARY STATS
# # doBy package
library(doBy)

# basic summary stats using descStat()
descStat(mtcars$mpg)

# the summaryBy() function from the
# doBy package will let you summarize
# multiple variable by a categorical variable
# this uses the formula mpg + disp + hp ~ cyl
# which says summarize mpg, disp and hp BY cyl
summaryBy(mpg+disp+hp~cyl, data=mycars, FUN=mean)
summaryBy(mpg+disp+hp~cyl, data=mycars, FUN=sd)
summaryBy(mpg+disp+hp~cyl, data=mycars, FUN=mystats)

# we can save our custom output which is a data.frame
# and use it with the kable() function 
# later in a RMD document.
out <- summaryBy(mpg+disp+hp~cyl, data=mycars, FUN=mystats)
class(out)
kable(out)

# ==================================
# CATEGORICAL DATA
# ==================================
# frequency and contingency tables
# let's also add the vcd and gmodels packages
library(vcd)
library(gmodels)

# there are more datasets that get added with
# these 2 packages - see the list
data()

# let's explore the Arthritis dataset
# from the vcd package
head(Arthritis)
names(Arthritis)
str(Arthritis)

# get frequencies for the "Improved" groups
table(Arthritis$Improved)
with(Arthritis, table(Improved))

# we can get a CROSSTABs type table using
# xtabs() from the R base stats
# this also uses a formula type input
# for the moment nothing is listed on the left
# you begin with the tilde ~ and then list
# the categorical variables you want in the table
# using + plus symbols to add more variables
# the code below will create a 2-x-2 table
xtabs(~ Treatment + Improved, data=Arthritis)

# we can also save the table output
mytable <- xtabs(~ Treatment + Improved, data=Arthritis)
mytable
class(mytable)
# notice mytable is of class "xtabs" and "table"

# see summary frequencies for the MARGINS
# the 2nd argument specifies if you want ROW
# or COLUMN summaries added. 1 is for ROWS
# 2 is for COLUMNS

# see the ROW summaries
margin.table(mytable, 1)

# see the COLUMN summaries
margin.table(mytable, 2)

# see PROPORTIONS instead of
# the frequencies

# proportions of the TOTAL
prop.table(mytable)

# proportions WITHIN the ROWS
# i.e. the rows should add to 1
prop.table(mytable, 1)

# proportions WITHIN the COLUMNS
# the columns should add to 1
prop.table(mytable, 2)

# ADD the MARGINs to the table
# for the frequencies
addmargins(mytable)

# we can combine these to
# add in the margins with
# proportions instead - for the total
addmargins(prop.table(mytable))

# let's add the ROW totals
# the 1 here says to give us
# the proportions WITHIN the ROWS
# ADD a COLUMN with the ROW totals
addmargins(prop.table(mytable,1), 2)

# Let's do this again, but
# multiply by 100 to get % instead of proportions
addmargins(prop.table(mytable,1)*100, 2)

# switch the numbers to now get
# percents WITHIN COLUMNS
# and ADD a ROW with the COLUMN totals
addmargins(prop.table(mytable,2)*100, 1)

# CH-SQUARE TEST OF INDEPENDENCE  
chisq.test(mytable)

# we can also look at using the
# FISHER'S EXACT test when
# the expected counts are < 5
mytable2 <- xtabs(~Improved+Sex, data=Arthritis)
mytable2
cs.out <- chisq.test(mytable2)
cs.out
cs.out$expected
sum(cs.out$expected < 5)

# there is 1 value with expected counts < 5
# here is the FISHER's EXACT test also
# notice this is run on a 3-x-2 table
# you can't do this in SPSS!!
fisher.test(mytable2)

# Cochran-Mantel-Haenszel Chi-Squared Test for Count Data
mytable3 <- xtabs(~Treatment+Improved+Sex, data=Arthritis)
mytable3
mantelhaen.test(mytable3)
# results suggest that the treatment received and 
# improvements reported were not independent within 
# each level of sex - in other words treated individuals
# improved more than those receving placebos when 
# controlling for sex

# =================================
# PLOTS for categorical data
# we'll use the spine() plot
# from the vcd package
# =================================

attach(Arthritis)
counts <- table(Treatment, Improved)
spine(counts, main="Spinogram of Treatment by Group",
      gp=gpar(col = "blue", fill=rainbow(6)))
detach(Arthritis)

# we can also do this using the with()
# function instead of attach()/detach()

counts <- with(Arthritis,
               table(Treatment, Improved))
with(Arthritis,
     spine(counts, main="Spinogram of Treatment by Group",
      gp=gpar(col = "blue", fill=rainbow(6))))

# we can also make a mosaic() plot
# using the vcd package

mosaic(~Treatment+Improved,
       data=Arthritis,
       gp = shading_max, split_vertical = TRUE,
       main="Arthritis: [Treatment] [Improved]")

# ================================
# PLOTS and STATS for correlations
# ================================
# let's look at the state.x77 dataset
head(state.x77)
help(state.x77)

# this dataset is really a MATRIX
# let's create a copy in our workspace to
# investigate further...
aa <- state.x77
class(aa)

# to see the variable names in this MATRIX
# we use the colnames() function
colnames(aa)

# it turns out the way this dataset was
# created they did NOT have a column for the
# state names or IDs - instead the state names
# are actuall rownames() for this MATRIX
rownames(aa)

# Let's just look at the 1st 6 variables
# Population, Income, Illiteracy, Life Exp, Murder and HS Grad
states <- state.x77[,1:6]

# let's compute the correlation matrix for 
# these 6 variables - by default cor()
# computes the Pearson's correlations r
cor(states)

# we can also change the method to
# compute Spearman's rho values instead
# learn more at help(cor)
cor(states, method="spearman")

# what if we want the p-value
# for a specific correlation test
# use cor.test for 2 variables
# the 2nd column for Income with the
# 3rd column for Illiteracy
cor.test(states[,2], states[,3])

# What if want the p-values for ALL
# of the correlations in the matrix?
# use the psych package
# and the corr.test() function
# NOTE: There is no missing data in this
# dataset BUT you can specify use = "complete"
# to make sure you are only computing 
# correlations for all complete data 
# same as "listwise" deletion in SPSS.
library(psych)
corr.test(states, use="complete")

# to see the confidence intervals for the
# correlations use the print() command
# and the short=FALSE option
print(corr.test(states, use="complete"), short=FALSE)

# we can also look at Spearman's rho
# and specify "Pairwise" deletion when it 
# makes sense to do so.
corr.test(states, use="pairwise", method="spearman")
print(corr.test(states, use="pairwise", method="spearman"), 
      short=FALSE)

# ==============================
# PLOTS - scatterplot matrices
# ==============================
# in base R the simple plot()
# command will create a scatterplot
# matrix when you specify more than 2 columns
#
# let's pick 5 of the variables from the state.x77
# dataset and keep these in a subset called states
myvars <- c("Murder", "Population", "Illiteracy", "Income", "Frost")
states <- as.data.frame(state.x77[,myvars])

# now put this dataset into the plot() command
plot(states)
# this makes a 5-x-5 plot matrix showing all
# of the variables plotted by each other variable

# in the car package there is a cool
# plotting routine for creating custom
# scatterplot matrices
library(car)

# since I used a Rainbow palette above in the
# categorical spine() plots, I'm going back to 
# the default colors for now
palette("default")

# basic plot
scatterplotMatrix(states)
# the green lines show the linear fit
# the red lines are the non-parametric
# loess smoothed fit line which include
# the dashed lines for the 25th, 75th 
# percentile lines for the loess fit line

# you can also use a formula to list the
# variables you want to see and then specify
# the dataset they come from
scatterplotMatrix(~ Murder + Population + Illiteracy, 
                  data = state.x77)

# there are many other ways to customize
# the plot - the most common are to turn off the
# dashed percentile "spead" lines
scatterplotMatrix(states, spread=FALSE)

# you can also customiz what is shown
# on the diagnoal. The default is a density plot
# we can make this a boxplot or perhaps a qqplot
# or none - just the variable name is shown
scatterplotMatrix(states, spread=FALSE,
                  diagonal = "boxplot")
scatterplotMatrix(states, spread=FALSE,
                  diagonal = "qqplot")
scatterplotMatrix(states, spread=FALSE,
                  diagonal = "none")

# ANOTHER way to graphically view correlations
# is to make correlograms using the corrgram package
# graphical correlation matrix - corrgram package
# see help(corrgram) for details on the various
# customizable graphics for the upper and lower panels
# as well as what is on the diagonal.
# here are 2 examples.
library(corrgram)
help(corrgram)

corrgram(states, order=TRUE,
         lower.panel = panel.pts,
         upper.panel = panel.ellipse,
         diag.panel = panel.density,
         main = "Corrgram of 5 variables from States.x77 dataset")

corrgram(states, order=TRUE,
         lower.panel = panel.shade,
         upper.panel = panel.pie,
         text.panel = panel.txt,
         main = "Corrgram of 5 variables from States.x77 dataset")

# ====================================
# BASIC statistical tests
# ====================================
# let's look back at the mtcars dataset
# let's compare the mpg for automatic
# versus manual cars using the am variable

# we can use the summaryBy() function
# from the doBy package and get our custom
# stats comparing mpg by am
# am=0 for automatic and 1 for manual transmission
summaryBy(mpg ~ am, data=mtcars, FUN=mystats)

# so it looks like on average the 19 automatic cars have
# 17.1 +/- 3.8 mpg
# but for the 13 manual cars the average is
# 24.4 +/- 6.2 mpg

# let's run a t-test to compare statistically
t.test(mpg ~ am, data=mtcars)

# we can also make a plot to see these
# differences visually
# with base R graphics boxplot()
boxplot(mpg ~ am, data=mtcars,
        col = c("blue","green"))

# using the ggplot2 package
ggplot(data=mtcars, aes(as.factor(am), mpg)) +
  geom_boxplot()

# ===============================================
# This example was skipped in class
# but here is an example of making a more detailed
# boxplot - the 1st boxplot is for the VC group
boxplot(len ~ dose, data = ToothGrowth,
        boxwex = 0.25, at = 1:3 - 0.2,
        subset = supp == "VC", col = "yellow",
        main = "Guinea Pigs' Tooth Growth",
        xlab = "Vitamin C dose mg",
        ylab = "tooth length",
        xlim = c(0.5, 3.5), ylim = c(0, 35), yaxs = "i")

# this next boxplot is ADDED on top of the previous boxplot
# adding in orange boxplots for the OJ group
boxplot(len ~ dose, data = ToothGrowth, add = TRUE,
        boxwex = 0.25, at = 1:3 + 0.2,
        subset = supp == "OJ", col = "orange")

# then we ADD a custom legend
legend(2, 9, c("Ascorbic acid", "Orange juice"),
       fill = c("yellow", "orange"))
# ===============================================

# ===============================================
# a little more on linear models
# comparing models and variable selection methods
# ===============================================
head(state.x77)
colnames(state.x77)
states <- as.data.frame(state.x77[,1:5])
names(states)
q <- names(states)[4]

# you'll notice that the 4th variable "Life Exp"
# has a space in it - this can cause problems
# when using the variable names in formulas and such
# so let RENAME this variable and REMOVE the SPACE
names(states)[4] <- "LifeExp"
names(states)

# we can fit a model to ALL of the variables in the
# dataset by using the period . in the formula
# which says fit a model for Murder against all of the
# remaining variables in the dataset
fit1 <- lm(Murder ~ ., data=states)
summary(fit1)

# we can also specify a subset of the variables we want
# this 2nd model leaves out "LifeExp"
fit2 <- lm(Murder ~ Population + Income + Illiteracy, data=states)
summary(fit2)

# we can compare the 2 models using the anova() command
# this compared the FULL vs REDUCED models
# list the REDUCED model first, then the FULL model
# otherwise the sums of squares comes out negative...
anova(fit2, fit1)

# we could also look at a 3rd model
fit3 <- lm(Murder ~ LifeExp, data=states)
summary(fit3)

# try variable selection methods with stepAIC in MASS package
library(MASS)
fit1 <- lm(Murder ~ ., data=states)
summary(fit1)
stepAIC(fit1, direction="backward")
stepAIC(fit1, direction="both")
# both methods basically drop Income from the model

# library leaps - all subsets regression
# SEE John Fox's book for more help 
# on interpreting the output from leaps
library(leaps)

leaps <- regsubsets(Murder ~ ., data=states, nbest=4)
plot(leaps, scale="adjr2")

library(car)
subsets(leaps, statistic="cp",
        main="Cp Plot for All subsets regression")
# this will wait for you to click on the plot where you
# want the legend to go

# The next line adds a reference line
abline(1,1,lty=2,col="red")
# The model closest to the red line with the
# smallest Cp was P-Il-L with Population (P)
# Il (Illiteracy) and L (LifeExp) - basically
# without Income (In) which we also saw above

# ====================================
# looking at interaction effects
# R uses the colon : symbol to indicate
# adding an interaction effect to the model
# let's look at the interaction between
# horsepower (hp) and car weight (wt)
# in the mtcars dataset
# ====================================

fit <- lm(mpg ~ hp + wt + hp:wt, data=mtcars)
summary(fit)

# the effects package is one way to visualize
# these interactions - the code below
# creates a line plot with 3 lines showing
# how the relationship between horsepower and mpg
# changes for cars of weight 2.2, 3.2 or 4.2 (in 1000's lbs)

library(effects)
plot(effect(term="hp:wt", 
            mod=fit,
            vcov.=vcov, 
            xlevels=list(wt=c(2.2, 3.2, 4.2))),
     multiline=TRUE)

# ===================================
# simple ONE-WAY ANOVA
# ANOVA is similar to regression
# for this example we'll look at the
# cholesterol dataset in the 
# multcomp package for multiple comparisons
# ===================================
library(multcomp)

# look at the cholesterol dataset
# notice that trt is a factor
head(cholesterol)
str(cholesterol)
table(cholesterol$trt)

# let's create a copy of this dataset
# and call is df (dataframe)
df <- cholesterol

# let's look at some summary statistics
# of the response across the different
# treatment trt categories
# we'll use the aggregate() function here
aggregate(df$response, 
          by=list(df$trt), 
          FUN=mean)
# the column labeled "x" here is the means

aggregate(df$response, 
          by=list(df$trt), 
          FUN=sd)
# the column labeled "x" here is the sd

# we can also define a custom list of stats
# let's just do the sample size of each group n
# with the mean and standard deviation.
mystats <- function(x){
  m <- mean(x)
  n <- length(x)
  s <- sd(x)
  return(c(n=n, mean=m, stdev=s))
}

# then use this custom function of stats
# with agrregate to see the summary for each 
# treatment group.
aggregate(df$response, 
          by=list(df$trt), 
          FUN=mystats)
# now there are 3 columns x.n, x.mean and x.sd
# for our custom stats

# let's also run an ANOVA using 
# the aov() function 
# you input a formula similar to
# a linear model y ~ x but
# now x is usually a factor
fit <- aov(response ~ trt, df)
fit
class(fit)
# many of the same summary function for
# a lm object also work for a aov object
summary(fit)
anova(fit)
coef(fit)

# in the gplots package we can look at
# the means and confidence intervals
# for these different treatment groups
library(gplots)
plotmeans(response ~ trt, data=df, 
          xlab="Treatment Groups",
          ylab="Response",
          main="Means Plot with 95% CI's")

# ======================================
# MAP example
# ======================================
# for this example we'll use the built in dataset USArrests
# see help(USArrests)
head(USArrests)

# use the tolower() function to extract
# the state names and set them all to lowercase
aa <- tolower(rownames(USArrests))
aa

# compare to the rownames for the 
# USArrests dataset which are the state names
aa2 <- rownames(USArrests)
aa2

# let's create a dataset called crimes
# whick is a data.frame and the state names are set
# as the all lowercase rownames from USArrests
# this ADDs a variable states to the dataset with the
# state names
crimes <- data.frame(state = tolower(rownames(USArrests)),
                     USArrests)
head(crimes)

# load the maps package
library(maps)
data(package = "maps")

# the function map_data() comes from
# the ggplot2 package. We will load the "state" US map
# see more at help(map_data)
# create a dataset states_map using this function
states_map <- map_data("state")

# now merge the crime data from USArrests above
# with this new dataset states_map and link them
# using region from the states_map to state from the crimes dataset
# this is done with by.x and by.y
crime_map <- merge(states_map, crimes, by.x="region", by.y="state")
head(crime_map)
# now they are linked together

# let's load the plyr package to use the arrange function
library(plyr)

# this sorts the data by group and then by order 
# for the crime_map dataset
crime_map2 <- arrange(crime_map, group, order)
head(crime_map2)

# next load the mapproj package
# to use the coord_map() function - the last
# layer added in the ggplot commands below
# this will create a chloropleth map for the Assaults
library(mapproj)
ggplot(crime_map2, aes(x=long, y=lat, group=group, fill=Assault)) +
  geom_polygon(colour="black") +
  scale_fill_gradient2(low="#559999", mid="grey90", high="#BB650B",
                       midpoint=median(crimes$Assault)) +
  expand_limits(x=states_map$long, y=states_map$lat) +
  coord_map("polyconic")

# do another map for Murder
ggplot(crime_map2, aes(x=long, y=lat, group=group, fill=Murder)) +
  geom_polygon(colour="black") +
  scale_fill_gradient2(low="#559999", mid="grey90", high="#BB650B",
                       midpoint=median(crimes$Murder)) +
  expand_limits(x=states_map$long, y=states_map$lat) +
  coord_map("polyconic")

# =====================================
# BRIEF into to dates and times
# and the lubridate package
# =====================================

# get the current date
Sys.Date()

# get current date and time
date()

# assign Sys.Date to the object today
today <- Sys.Date()
today
class(today)

# 2 basic classes of date/time in R are
# POSIXct - number of seconds since beginning of 1970 
# in UTC time zone
# and
# POSIXlt

# get the curren date and time
# as a POSIXct object
now <- Sys.time()
now
class(now)

# convert to POSIXlt time which
# oftne includes time zone information
# see more at https://www.r-project.org/doc/Rnews/Rnews_2001-2.pdf 
nowlt <- as.POSIXlt(now)
nowlt
class(nowlt)

# define dob as a date object - let's use Nancy Reagan's birthday
dob <- as.Date("1921-07-06") # Nancy Reagan's birthday
dob

# find the amount of time between when nancy Reagan
# was born and today - let's find the number of weeks elapsed
difftime(today, dob, units="weeks")

# convert to years dividing number of days by 365
# and create the output as.numeric
as.numeric(difftime(today, dob, units="days")/365)

# other date time math
diff1 <- today - dob # defaults to number of days elapsed
diff1
diff1/365

# load the lubridate package to use
# the as.duration() function
# the year() and wday() functions
library(lubridate)
as.duration(diff1) # results shown in seconds and years
year(today) - year(dob) # results in years
wday(dob) # shows the 4th weekday = Wed
          # Sunday is weekday 1 and Saturday is weekday 7
wday(dob, label=TRUE) # this shows the label for the 4th weekday



