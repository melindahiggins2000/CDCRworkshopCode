
# ************* gender recoding *****************

data.csv <- read.csv(file="Dataset_01_comma.csv")
data.csv

# this is the variable we need to fix
data.csv$GenderSTR

# make a copy of this variable
# set all text case to lower case
data.csv$GenderNew <- data.csv$GenderSTR
data.csv$GenderNew <- tolower(data.csv$GenderNew)

# use nested ifelse() statements to fix this
# 1. find all subjects with gender as "m" or "male" and not missing
# 2. if true set the fixed value to "Male" if not true
# 3. then ask if gender was "f" or "female"
# 4. if true set to female
# 5. if false set the rest to missing NA

data.csv$GenderFixed <- ifelse(((data.csv$GenderNew == "m") | 
                                (data.csv$GenderNew == "male")) &
                                (data.csv$GenderNew != ""),
                               "Male",
                               ifelse(((data.csv$GenderNew == "f") | 
                                       (data.csv$GenderNew == "female")) &
                                       (data.csv$GenderNew != ""),
                                      "Female",
                                      NA))
data.csv

# run a quick check to compare all the ways gender was coded for
# a quick comparison
vars <- c("GenderSTR", "GenderCoded", "GenderNew", "GenderFixed")
data.csv[,vars]

# if desired make a list of the variables
# you don't want to keep and remove them
# all but GenderFixed
# 1. make a list of the variables you want to remove
# 2. create a variable index (TRUE's or "FALSE's) for
#   which variables you want to remove by comparing
#   these to the whole variable list in the dataset
# 3. use this index to keep all of the variables
#   for which this is not true 
vars <- c("GenderSTR", "GenderCoded", "GenderNew")
rmlist <- names(data.csv) %in% vars
data.csv <- data.csv[!rmlist]
data.csv
