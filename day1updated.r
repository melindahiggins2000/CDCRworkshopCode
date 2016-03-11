# ========================================
# Day 1, March 10, 2016

# Session 1 ==============================

# ======================================
# see what directory R is currently set to 
# ======================================
getwd()

# ======================================
# change your "working directory"
# to a location of your choice
# ======================================
setwd('C:/MyGithub/CDCRworkshopCode')

# ======================================
# check location again
# ======================================
getwd()

# ======================================
# Typing in commands - do simple math
# ======================================
2 + 2
3 + (4*8)
3+4*8
6 + (8**2) # exponents can be done using two
           # asterix's ** or you can use
           # the caret ^ symbol
12^2

# ======================================
pi         # pi is a built in Constant
4 * pi

# ======================================
help(Constants)
LETTERS
letters
month.abb
month.name

# ====================================
# create x which had 1 numeric value
# ======================================
x = 3 * 5
x <- 3 * 5    # notice nothing is shown in the console
              # you have to type the name of the object 
              # to "see" it
x

# ======================================
# create y which is a numeric (integer) vector
# with 12 elements
# ======================================
y <- 1:12
y

# you'll notice that y is a vector of integers
# you can convert between numeric and integer type
# data classes using the as.numeric() 
# and as.integer() functions.

ynum <- as.numeric(y)
yint <- as.integer(ynum)

# ======================================
# create z a numeric vector
# containing a sequence of numbers from
# 0 to 10 in units of 0.5
# ======================================
z <- seq(0,10,.5)
z

# ======================================
# the above code can also be done with the
# explict function arguments defined
# see the examples in help(seq)
# ======================================
help(seq)
z <- seq(from=0, to=10, by=0.5)
z

# ======================================
# create new object sinz which is a numeric
# vector now containing the sin (sine function) 
# of the z values
# ======================================
sinz <- sin(z)

# ======================================
# look at objects created get simple listing
# and get listing with structure information
# ======================================
ls()
ls.str()

# ========================================
# while you can see information about each of these
# objects in the Global Environment (top right)
# of the RStudio window, the function length()
# is useful for determining how many elements are
# in a given vector/data object.
# ========================================
length(x)
length(y)
length(z)
length(sinz)

# ========================================
# other functions that are helpful for finding
# out about data objects is the str() "structure"
# function and the class() function.

# ====================================
# NOTE ON ADDING COMMENTS
# ====================================
# highlight all comment lines
# then hit CTRL+SHIFT+C to toggle back and forth
# between code and comments.

#'this is
#'a new line of commenting that begins with
#'a hashtag or number # sign followed by a single quote
#'then when you hit return the comment delimiter #'
#'is automatically added until you type in a
#'single hashtag without the single quote.
# then remove single quote and begin new line for r code

# ========================================
str(y)
class(y)
str(z)
class(z)

# ======================================
# create some vectors with different objects
# 
# ======================================
a1 <- c(1,2,3,4,10,11)
a1
a2 <- c('a','g','f','r','t','s')
a2
a3 <- c(TRUE,FALSE,TRUE,TRUE,FALSE,TRUE)
a3
a4 <- c(1,2,'a','b',TRUE,FALSE)
a4
a5 <- c(1,2,3,4,TRUE,FALSE)
a5

a6 <- c(5,10,x)

# ======================================
# use the class() function to investigate these further
# ======================================
class(a1)
class(a2)
class(a3)
class(a4)
class(a5)

# ======================================
# using cbind() - this makes a matrix
# where every element has to be the same 
# type - these are now all characters
# ======================================
a1to5cbind <- cbind(a1,a2,a3,a4,a5)
a1to5cbind
class(a1to5cbind)
str(a1to5cbind)
dim(a1to5cbind)

# ======================================
# using rbind() - like cbind()
# but now the vectors come in as rows
# ======================================
a1to5rbind <- rbind(a1,a2,a3,a4,a5)
a1to5rbind
class(a1to5rbind)
str(a1to5rbind)
dim(a1to5rbind)

# ======================================
# using list() - notice the dim()
# function doesn't return anything
# dim() does not work for lists
# ======================================
a1to5list <- list(a1,a2,a3,a4,a5)
a1to5list
class(a1to5list)
str(a1to5list)
dim(a1to5list)

# ======================================
# create some lists made up of other lists
# ======================================
alist1 <- list(x, z, sinz, a1to5list)
alist1
str(alist1)
class(alist1)

# ======================================
# using data.frame() - this is a special
# kind of list - this time dim() works
# ======================================
a1to5df <- data.frame(a1,a2,a3,a4,a5)
a1to5df
class(a1to5df)
str(a1to5df)
dim(a1to5df)

# ======================================
# this time with stringsAsFactors
# set to FALSE
# ======================================
a1to5dfnf <- data.frame(a1,a2,a3,a4,a5,
                        stringsAsFactors = FALSE)
a1to5dfnf
class(a1to5dfnf)
str(a1to5dfnf)
dim(a1to5dfnf)

# ======================================
# EXERCISE 1
# Create a new data frame object called `df1` 
# using the # `data.frame()` command. Combine 
# the object `y` with the built in constant 
# for `month.name` and `month.abb`.

y
month.name
month.abb

mydf <- data.frame(y, month.name, month.abb)
c(y,month.name,month.abb)

# 
# Create the data frame again and call it 
# `df2` using the same 3 objects 
# (`y`, `month.name` and `month.abb`) and 
# set `stringsAsFactors` to FALSE.
# ======================================
# exercise 1 - key

df1 <- data.frame(y, month.name, month.abb)
df1
str(df1)

df2 <- data.frame(y, month.name, month.abb,
                  stringsAsFactors = FALSE)
df2
str(df2)

# Session 2 ==============================

# ======================================
# look at data objects - you can use
# the fix() command to edit your data
# ======================================
fix(z)
fix(alist1)
fix(df2)

# ======================================
# use head() and tail() to only look
# at a few rows at a time
# ======================================
head(df1)
tail(df1)

# ======================================
# you can also invoke the viewer 
# with View()
# ======================================
View(df1)
view(df1)

# ======================================
# let's make a simple plot
# ======================================
plot(z,sinz)

# ======================================
# add some customization
# ======================================
plot(z, sinz, 
     xlab='Z = Sequence 0 to 10 by 0.5', 
     ylab='Sin(Z)', 
     main='Main title', 
     sub='example subtitle')

# ======================================
# add a BLUE line using lines()
# ======================================
lines(z,sinz,col='blue')

# ======================================
# customize the points using points()
# plotting character pch 23 is a filled diamond
# col defines the color
# bg defines the filled or background color
# ======================================
points(z,sinz,pch=23,col='red',bg='black')

# ======================================
# select code above, right click and "run selection"
# or highlight code and click CTRL-R
# specifically run the following code all together
# the spaces and line returns added for clarity
# Note: RStudio helps with good formatting practices
# ======================================

# ======================================
# all together in one block
# ======================================
plot(z, sinz,
     xlab = 'Z = Sequence 0 to 10 by 0.5',
     ylab = 'Sin(Z)',main='Main title',
     sub = 'example subtitle')
lines(z, sinz, col = 'blue')
points(z, sinz, pch = 23, col = 'red', bg = 'black')

# ======================================
# use graphics device to make a PDF
# of the plot
# ======================================
pdf(file = "plot1.pdf")

plot(z, sinz,
     xlab = 'Z = Sequence 0 to 10 by 0.5',
     ylab = 'Sin(Z)',main='Main title as of today my name is Melinda',
     sub = 'example subtitle')
lines(z, sinz, col = 'blue')
points(z, sinz, pch = 23, col = 'red', bg = 'black')

dev.off()

# ======================================
# EXERCISE 2
# Look up which "device" will create and 
# save the plot as a JPEG. Use the commands 
# above as your guide and create and save the 
# figure as a JPEG formatted file.
#
# Create a second JPEG where the width is 
# 750 pixels and the height is 500 pixels 
# and set the background color to yellow 
# and the quality to 50.
# ======================================
# exercise 2 - key

jpeg(file = "plot1.jpg")

plot(z, sinz,
     xlab = 'Z = Sequence 0 to 10 by 0.5',
     ylab = 'Sin(Z)',main='Main title',
     sub = 'example subtitle')
lines(z, sinz, col = 'blue')
points(z, sinz, pch = 23, col = 'red', bg = 'black')

dev.off()

jpeg(file = "plot1yellow.jpg", 
     width=750, height=500,
     bg = "yellow",
     quality = 50)

plot(z, sinz,
     xlab = 'Z = Sequence 0 to 10 by 0.5',
     ylab = 'Sin(Z)',
     main='Main title',
     sub = 'example subtitle')

lines(z, sinz, col = 'blue')
points(z, sinz, pch = 23, col = 'red', bg = 'black')
dev.off()

# ======================================
# let's install a package
# ======================================
install.packages("ggplot2")

# ======================================
# load the package using library()
# ======================================
library(ggplot2)

# ======================================
# once it is loaded we can get info
# and help on the package - see
# more in the "Packages" window
# ======================================
help(package = "ggplot2")

# ======================================
# now that ggplot2 is loaded we can
# use the qplot() function
qplot(z, sinz,
      geom = c("point", "line"),
      xlab = 'Z = Sequence 0 to 10 by 0.5',
      ylab = 'Sin(Z)',
      main = 'Main title')

# ======================================
# we can also call variables inside a data frame
# ======================================
df2 <- data.frame(z,sinz)

ggplot(df2, aes(x=z, y=sinz)) +
  geom_line(colour = "red", linetype = "dashed") +
  geom_point(shape = 23,
             colour = "red",
             fill = "black") +
  xlab("z is sequence from 0 to 10 in units of 0.5") + 
  ylab("Sin(z)") +
  ggtitle("Here is a Main Title") + 
  theme_light()

# ======================================
# here is the plot using basic R
# graphics
# ======================================
plot(z, sinz,
     xlab = 'Z = Sequence 0 to 10 by 0.5',
     ylab = 'Sin(Z)',main='Main title',
     sub = 'example subtitle')
lines(z, sinz, col = 'blue')
points(z, sinz, pch = 23, col = 'red', bg = 'black')

# ======================================
# using ggplot2 to build the plot layer by layer
# ======================================

# ======================================
# make the basic plot window
# ======================================
p <- ggplot(df2, aes(x=z, y=sinz))
p

# ======================================
# add a line geom (geometric object)
# ======================================
p <- p + geom_line(colour = "red", linetype = "dashed")
p

# ======================================
# add the points geom
# ======================================
p <- p + geom_point(shape = 23,
                    colour = "red",
                    fill = "black")
p

# ======================================
# add some labels and a title
# ======================================
p <- p + xlab("z is sequence from 0 to 10 in units of 0.5") +
  ylab("Sin(z)") + 
  ggtitle("Here is a Main Title")
p

# ======================================
# we can apply a basic "theme" for the overall
# look and style of the plot
# ======================================
p <- p + theme_light()
p

# ======================================
# Let's also add the ggthemes package
# and really try out some cool
# plot styles
# ======================================

library(ggthemes)
p <- p + theme_economist() + ggtitle("The Economist Theme")
p

p <- p + theme_fivethirtyeight() + ggtitle("The 538 Theme")
p

p <- p + theme_tufte() + ggtitle("The Edward Tufte Theme")
p

p <- p + theme_wsj() + ggtitle("The WSJ Theme")
p


# ======================================
# it is always a good idea to make sure
# you cite the packages you used and give
# the creators proper credit
# it also helps document the version
# you are using
# ======================================
citation(package = "base")
citation(package = "ggplot2")
citation(package = "ggthemes")

# ======================================
# also document all of current
# session settings, add-ons, versions,
# and computer system info.
# ======================================
sessionInfo()

# session 3 ===============================

# ======================================
# let's make some more data objects
# ======================================
x <- 3 * 8 + 6
y <- 1:12
y2 <- y**2

# ======================================
# create a matrix
# ======================================
df1 <- cbind(y, y2, month.abb, month.name)
class(df1)
str(df1)

# ======================================
# create a data frame
# ======================================
df1a <- data.frame(y,y2,month.abb,month.name)
class(df1a)
str(df1a)

# ======================================
# create a list
# ======================================
list1 <- list(x,y,df1a)
class(list1)
str(list1)

# you can use the fix() function
# to edit data and save the changes

fix(df1a)

# ======================================
# select the element on the 3rd row
# and 3rd column
# ======================================
df1[3,3]

# ======================================
# select the whole 3rd column
# ======================================
df1[,3]

# ======================================
# select the 5th row and every column
# in that row
# ======================================
df1[5,]

# ======================================
# compare the 1st column in the
# data matrix df1 and 1st column in
# the data frame df1a
# ======================================
df1[,1]
class(df1[,1])
str(df1[,1])

df1a[,1]
class(df1a[,1])
str(df1a[,1])

# ======================================
# create a sequence of numbers
# put them into a vector z
# perform math on that vector and
# save it. then combine both
# vectors into a data frame
# ======================================
z <- seq(0,10,.5)
sinz <- sin(z)
df2 <- data.frame(z, sinz)

# ======================================
# now let's clean up some of our objects
# using the rm() command to selectively
# remove objects no longer needed
# ======================================
ls()
rm(y, y2, z, sinz)
ls()

# ======================================
# other ways to select a column of data
# i.e. select a variable in a dataset.
# ======================================
df2[,1] # use the column number
df2$z # select by column name

# ======================================
# after selecting a variable
# by the column name, then select the
# 3rd element (3rd row of the month.name
# variable) which is "March"
# ======================================
df1a$month.name[3]

# find the row for which y equals 5
# in df1a

pickrow <- df1a$y == 5
df1a[pickrow, ]

pickrow <- df1a$y > 6
df1a[pickrow, ]

df1a[df1a$y == 5, ]


# ======================================
# use save.image() or save() to save all 
# or selected objects - these are saved
# as *.RData files
# ======================================
save.image("allobjects.RData")
save(df2, file="df2.RData")

# ======================================
# remove all of the objects
# and then load them back - either one
# at a time or all of them together
# ======================================
rm(list = ls())
load(file="df2.RData")
load("allobjects.RData")
ls()

# ======================================
# get data from dropbox at 
# https://www.dropbox.com/sh/vlo5bzrl5ayo1bk/AADD0WieyuEdyGwiveuCoRr-a?dl=0 
# download these files and put them
# into your working directory
# for this next exercise
# ======================================

# ======================================
# read in as comma delimited
# ======================================
data.rt <- read.table(file="Dataset_01_comma.csv",header=TRUE,sep=",")
data.rt

# ======================================
# read in a CSV
# ======================================
data.csv <- read.csv(file="Dataset_01_comma.csv")
data.csv

# ======================================
# read in a TAB delimited TXT file
# ======================================
data.tab <- read.delim(file="Dataset_01_tab.txt")
data.tab

# ======================================
# read in a XLS Excel file
# functions from readxl package

library(readxl)
# ======================================
data.xls <- read_excel("Dataset_01.xls", sheet=1)
data.xls

# ======================================
# read in a XLSX Excel file
# ======================================
data.xlsx <- read_excel("Dataset_01.xlsx", sheet=1)
data.xlsx

# suppose I have a 2nd sheet named "new"

datanew.xlsx <- read_excel("Dataset_01addsheet.xlsx", sheet="new")
datanew.xlsx

data.xlsx <- read_excel("Dataset_01.xlsx", sheet=1)
data.xlsx

# ======================================
# read in a SPSS SAV file

library(foreign)

# ======================================
data.spss <- read.spss(file = "Dataset_01.sav",
                       to.data.frame=TRUE)
data.spss

# ======================================
# read in a SAS Export XPT file
# ======================================
data.xpt <- read.xport(file = "Dataset_01.xpt")
data.xpt

# Suggestion in class
# try HAVEN package
install.packages("haven")
library(haven)
test1.sas <- read_sas("http://crn.cancer.gov/resources/ctcodes-procedures.sas7bdat")
test2.sas <- read_sas("ctcodes-procedures.sas7bdat")

# ======================================
# IGNORE THIS - USE HAVEN EXAMPLE
# ABOVE WITH read_sas() FUNCTION
# Using the sas7bdat packafe
# try reading the SAS file directly
# this is experimental and didn't work
# ======================================
#data.sas <- read.sas7bdat(file = "Dataset_01.sas7bdat")
#data.sas

# session 4 ==========================

# ======================================
# create new variables BMI from 
# weight and height
# ======================================
data.csv$bmiPRE <- (data.csv$WeightPRE*703)/((data.csv$Height*12)**2)
data.csv$bmiPOST <- (data.csv$WeightPOST*703)/((data.csv$Height*12)**2)

# ======================================
# you can also use attach and detach
# datasets and then call the variables
# without using the $ selector
# ======================================
attach(data.csv)

diff <- bmiPOST - bmiPRE # creates diff variables 
                         # stands alone not attached
mean(diff)

# create using the variables inside the dataset
# but attach them back to the dataset
data.csv$diff2 <- bmiPOST - bmiPRE

detach(data.csv)

# ADD ENTIRE DATA UPDATE with attach **

# ======================================
# once the dataset is detached
# go back to using the $ selector
# ======================================
data.csv$diff <- diff

# after assigning the new difference
# score diff to the dataset, remove it
# from the global environment.

rm(diff)

attach(data.csv)

bmiPRE

detach(data.csv)

# ======================================
# WRITING or SAVING data
# you can save the file out to *.RData
# ======================================
save(data.csv, file="datacsv.RData")


# ======================================
# you can write datasets out as CSV
# ======================================
write.csv(data.csv, 
          file="datacsv.csv")

# ======================================
# write a dataset out as a TAB delimited 
# TXT file
# ======================================
write.table(data.csv, 
          file="datacsv.txt",
          sep="\t")

# ======================================
# we'll recreate the BMI variables
# and make a histogram
# ======================================
data.csv$bmiPRE <- (data.csv$WeightPRE*703)/((data.csv$Height*12)**2)
data.csv$bmiPOST <- (data.csv$WeightPOST*703)/((data.csv$Height*12)**2)
hist(data.csv$bmiPRE)

# ======================================
# find the typo and fix it
# this seems trivial but it is important
# to document and track data corrections
# like these
# recalculate and redo the histogram
# this time will use probabilities
# instead of frequencies for the histogram
# ======================================
attach(data.csv)

data.csv[18,"Height"] <- 5.6

data.csv$bmiPRE <- (WeightPRE*703)/((Height*12)**2)
data.csv$bmiPOST <- (WeightPOST*703)/((Height*12)**2)

detach(data.csv)
hist(data.csv$bmiPRE, freq=FALSE)
lines(density(data.csv$bmiPRE))

# However, I advise again using attach()
# and detach(), see more at 
# http://www.r-bloggers.com/to-attach-or-not-attach-that-is-the-question/

# ======================================
# make a plot of the PRE vs POST BMI
# add a linear fit line and a 
# lowess smoothed fit line
# ======================================
plot(data.csv$bmiPRE, data.csv$bmiPOST, "p")
abline(lm(data.csv$bmiPOST ~ data.csv$bmiPRE), col="red")
lines(lowess(data.csv$bmiPRE, data.csv$bmiPOST), col="blue")


# ======================================
# do the plot again using ggplot options
# ======================================
p <- ggplot(data.csv, aes(bmiPRE, bmiPOST))
p
p <- p + geom_point()
p
p + geom_smooth(method="lm") + 
  facet_wrap(~GenderCoded) + 
  ggtitle("Panels for Gender")

# ======================================
# let's create Gender as a Factor
# instead of as just number codes
# Factors are useful in plots
# and tables providing labels for the
# labels. Factors are also helpful
# in various models.
# ======================================
data.csv$GenderFactor <- factor(data.csv$GenderCoded,
                                levels = c(1,2),
                                labels = c("Male","Female"))

data.csv$GenderFactor
str(data.csv$GenderFactor)
class(data.csv$GenderFactor)
table(data.csv$GenderFactor)

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

# ======================================
# we can also use this factor to color
# code the points and associated model fits
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
# ======================================
fit1 <- lm(bmiPOST ~ bmiPRE, data=data.csv)
fit1
summary(fit1)
coef(fit1)
anova(fit1)

