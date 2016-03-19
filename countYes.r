# ********* count yes's across variables *************
# capture if a subject has any of the
# conditions across a set of variables
# and only code missing if all are missing
# and if one is a zero then final is 0...

x1 <- c( 0, 1,NA,NA, 1, 1, 0, 0,NA, 0)
x2 <- c( 0,NA,NA,NA, 1, 0, 1, 0, 0, 0)
x3 <- c( 0, 1,NA,NA,NA, 0, 0, 0,NA, 0)
x4 <- c( 1, 1,NA,NA, 0, 1, 0, 0, 1, 1)
x5 <- c( 0, 1,NA,NA, 0, 1, 1, 0,NA, 1)

xdf <- data.frame(x1,x2,x3,x4,x5)
xdf

# create a logic matrix for all of the data
# then compute a row sum for the amount of
# missing across all of the columns of interest
is.na(xdf)
rowSums(is.na(xdf))

# use this approach with the ifelse() function
# 1. find the rows that are not missing all data 
#    in this case all 5 variables are not missing
# 2. if this is true, then set the sum equal to 
#    the number of variables that are yes
# 3. if false, then set the sum to missing or NA
#    i.e. NAs indicate a row with all missing data

xdf$sum <- ifelse(rowSums(is.na(xdf[,1:5]))!=5,
                  rowSums(xdf[,1:5], na.rm=TRUE),
                  NA)
xdf

# we can repeat this process but instead create a
# simple indicator for rows that have 1 or more
# yes and are not missing for every variable in that row.

xdf$yn <- ifelse(rowSums(is.na(xdf[,1:5]))!=5,
                 as.numeric(rowSums(xdf[,1:5], na.rm=TRUE)>0),
                 NA)
xdf
