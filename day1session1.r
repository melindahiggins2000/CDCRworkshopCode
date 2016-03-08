# ======================================
# Day 1 - Session 1
# March 10, 2016
# by Melinda Higgins, PhD.
# ======================================

# ======================================
# see what directory R is currently set to
getwd()

# ======================================
# change your "working directory"
# to a location of your choice
setwd('C:/MyGithub/CDCRworkshopCode')

# ======================================
# check location again
getwd()

# ======================================

# ========================================
# type in commands to do some math
# ========================================
2 + 2
3 + (4*8)
3 + 4*8
6 + (8**2) # exponents can be done using two
           # asterix's ** or you can use
           # the caret ^ symbol
12^2
pi         # pi is a built in Constant
4 * pi

# ====================================
# pi is a Constant built into R
# what are the others?
# ====================================
help(Constants)

LETTERS
letters
month.abb
month.name

# ====================================
# Let's create some data objects
# and variables with R 
# ====================================
# create x which had 1 numeric value
x <- 3 * 5    # notice nothing is shown in the console
              # you have to type the name of the object 
              # to "see" it
x

# create y which is a numeric (integer) vector
# with 12 elements
y <- 1:12
y

# create z a numeric vector
# containing a sequence of numbers from
# 0 to 10 in units of 0.5
z <- seq(0,10,.5)

# the above code can also be done with the
# explict function arguments defined
# see the examples in help(seq)
help(seq)
z <- seq(from=0, to=10, by=0.5)

# click on Edit/Data Editor
# choose z
# can also invoke data editor with
# fix() function
fix(z)

# create new object sinz which is a numeric
# vector now containing the sin (sine function) 
# of the z values
sinz <- sin(z)

# let's look at the objects created so far
ls()

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
# ========================================
str(y)
class(y)
str(z)
class(z)

# ========================================
# so, what happens when we mix different kinds
# of data inside a vector.
# these first 3 vectors each have elements that 
# are all the same type.
# a1 is numeric
# a2 is character
# a3 is logical
# a4 is mixed numeric, character and logical
#    so R sets all to the best option
#    so a4 becomes all character type
# a5 is also mixed but only numeric and logical
#    In this case, the logical values are converted
#    to numeric and TRUE becomes 1 and FALSE becomes 0
# ========================================
a1 <- c(1,2,3,4,10,11)
a2 <- c('a','g','f','r','t','s')
a3 <- c(TRUE,FALSE,TRUE,TRUE,FALSE,TRUE)
a4 <- c(1,2,'a','b',TRUE,FALSE)
a5 <- c(1,2,3,4,TRUE,FALSE)

# use the class() function to investigate these further
class(a1)
class(a2)
class(a3)
class(a4)
class(a5)

# you can combine these vectors in a couple of ways
# using cbind()
a1to5cbind <- cbind(a1,a2,a3,a4,a5)
class(a1to5cbind)
str(a1to5cbind)
dim(a1to5cbind)

#using rbind()
a1to5rbind <- rbind(a1,a2,a3,a4,a5)
class(a1to5rbind)
str(a1to5rbind)
dim(a1to5rbind)

#using list()
a1to5list <- list(a1,a2,a3,a4,a5)
class(a1to5list)
str(a1to5list)
dim(a1to5list)

#using data.frame()
a1to5df <- data.frame(a1,a2,a3,a4,a5)
class(a1to5df)
str(a1to5df)
dim(a1to5df)

# ========================================
# so we've learned about small data objects
# but ultimately we'll be working with a 
# large dataset with numerous variables of
# different types. In R these datasets are
# called data frames. We can create one
# using the data.frame() function. Let's
# combine y which contains numbers from 1 to 12
# with the abbreviations and names of the months.
# ========================================
df1 <- data.frame(y, month.name, month.abb)

# also try View function
# note that CaSe matters
view(df1)
View(df1)

# since this is a small dataset we can
# look at in the console - just type the
# object name.
df1

# we can also view subsets of the data
# two easy ways to view are head()
# and tail() which lists either the 1st
# 6 rows or the last 6 rows in the 
# data frame.
head(df1)
tail(df1)

# make a simple plot
plot(z,sinz)

# redo plot with axis labels, a title and a subtitle
plot(z, sinz, 
     xlab='Z = Sequence 0 to 10 by 0.5', 
     ylab='Sin(Z)', 
     main='Main title', 
     sub='example subtitle')

# add a BLUE line using lines()
lines(z,sinz,col='blue')

# customize the points using points()
# plotting character pch 23 is a filled diamond
# col defines the color
# bg defines the filled or background color
points(z,sinz,pch=23,col='red',bg='black')

# select code above, right click and "run selection"
# or highlight code and click CTRL-R
# specifically run the following code all together
# the spaces and line returns added for clarity
# Note: RStudio helps with good formatting practices

plot(z, sinz,
     xlab = 'Z = Sequence 0 to 10 by 0.5',
     ylab = 'Sin(Z)',main='Main title',
     sub = 'example subtitle')
lines(z, sinz, col = 'blue')
points(z, sinz, pch = 23, col = 'red', bg = 'black')

# In graphics Window, right click and either
# copy as either metafile or bitmap.
# or Save as metafile or postscript
# Metafile is the Windows Vector graphics format
# which is scalable and portable. The bitmap format
# will not scale as well. Many journals prefer postscript.

# ========================================
# Installing a package
# let's try adding in some additional
# functionality into R. We'll install
# the ggplot2 package using the 
# install.packages() function and then load
# the ggplot2 package using the library()
# function.
# ========================================

install.packages("ggplot2")
library(ggplot2)
help(package="ggplot2")

# ========================================
# However, now that we've added ggplot2
# we can now use the qplot() function
# to do a "quick plot."
# ========================================

qplot(z, sinz,
      geom = c("point", "line"),
      xlab = 'Z = Sequence 0 to 10 by 0.5',
      ylab = 'Sin(Z)',
      main = 'Main title')

# ========================================
# It is a good idea when collaborating
# and sharing your code with others to take
# a snapshot of your computer system and your
# specific R environment and session settings.
# you can do this using the sessionInfo()
# function. Here is mine.
# ========================================

sessionInfo()


