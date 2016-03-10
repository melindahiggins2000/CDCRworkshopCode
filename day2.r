
# session 1 =========================
# summary stats

help(package = "datasets")
data()
mtcars
str(mtcars)

summary(mtcars[,c("mpg","cyl","disp","hp")])

mycars <- mtcars
mycars$cyl <- as.factor(mtcars$cyl)

summary(mycars[,c("mpg","cyl","disp","hp")])

mycarsNA <- mycars
mycarsNA[(mycarsNA$cyl)==6,"mpg"] <- NA

summary(mycarsNA[,c("mpg","cyl","disp","hp")])

fivenum(mycars$mpg)
quantile(mycars$mpg, c(.25,.75))
fivenum(mycarsNA$mpg)

mystats <- function(x, na.omit=FALSE){
  if(na.omit)
    x <- x[!is.na(x)]
  m <- mean(x)
  n <- length(x)
  s <- sd(x)
  md <- mad(x)
  q5 <- quantile(x, .05)
  q25 <- quantile(x, .25)
  q75 <- quantile(x, .75)
  q95 <- quantile(x, .95)
  return(c(n=n, mean=m, stdev=s, MAD=md, 
           q5, q25, 
           q75, q95))
}

mystats(mycars$mpg)
mystats(mycarsNA$mpg, na.omit=TRUE)

# let's apply these to a range of variables

myvars <- c("mpg","cyl","disp","hp")
sapply(mycars[myvars], fivenum)
sapply(mtcars[myvars], fivenum)

out <- sapply(mtcars[myvars], fivenum)
kable(out)

sapply(mtcars[myvars], mystats)
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

# Hmisc package
library(Hmisc)
describe(mtcars[myvars])
describe(mycarsNA[myvars])

# pastecs package
library(pastecs)
stat.desc(mtcars[myvars])

# psych package
library(psych)
describe(mtcars[myvars])

# avoid masking problems using 2 colons ::
Hmisc::describe(mtcars[myvars])
psych::describe(mtcars[myvars])

# session 2 =========================

# descriptions by group - use the by() function
dstats <- function(x)sapply(x,mystats)
by(mtcars[myvars], mtcars$cyl, dstats)

out <- by(mtcars[myvars], mtcars$cyl, dstats)
kable(out[[1]], caption=paste(mtcars$cyl[1]," cylinders"))
kable(out[[2]], caption=paste(mtcars$cyl[2]," cylinders"))
kable(out[[3]], caption=paste(mtcars$cyl[3]," cylinders"))

# doBy package
library(doBy)
out <- summaryBy(mpg+disp+hp~cyl, data=mycars, FUN=mystats)
kable(out)

# frequency and contingency tables
library(vcd)
library(gmodels)

data()

head(Arthritis)
str(Arthritis)

table(Arthritis$Improved)
with(Arthritis, table(Improved))

mytable <- xtabs(~ Treatment + Improved, data=Arthritis)
mytable

margin.table(mytable, 1)
margin.table(mytable, 2)

prop.table(mytable)
prop.table(mytable, 1)
prop.table(mytable, 2)

addmargins(mytable)
addmargins(prop.table(mytable))
addmargins(prop.table(mytable,1), 2)
addmargins(prop.table(mytable,1)*100, 2)
addmargins(prop.table(mytable,2)*100, 1)

chisq.test(mytable)

mytable2 <- xtabs(~Improved+Sex, data=Arthritis)
mytable2
chisq.test(mytable2)
fisher.test(mytable2)

mytable3 <- xtabs(~Treatment+Improved+Sex, data=Arthritis)
mytable3
mantelhaen.test(mytable3)
# results suggest that the treatment received and 
# improvements reported were not independent within 
# each level of sex - in other words treated individuals
# improved more than those receving placebos when 
# controlling for sex

# plots for categorical data

attach(Arthritis)
counts <- table(Treatment, Improved)
spine(counts, main="Spinogram of Treatment by Group",
      gp=gpar(col = "blue", fill=rainbow(6)))
detach(Arthritis)

mosaic(~Treatment+Improved,
       data=Arthritis,
       gp = shading_max, split_vertical = TRUE,
       main="Arthritis: [Treatment] [Improved]")

# correlations

head(state.x77)
states <- state.x77[,1:6]
cor(states)
cor(states, method="spearman")

cor.test(states[,2], states[,3])

sum(is.na(states))

library(psych)
corr.test(states, use="complete")
print(corr.test(states, use="complete"), short=FALSE)

# scatterplot matrices

library(car)
myvars <- c("Murder", "Population", "Illiteracy", "Income", "Frost")
states <- as.data.frame(state.x77[,myvars])
palette("default")
scatterplotMatrix(states)
scatterplotMatrix(states, spread=FALSE)
scatterplotMatrix(states, spread=FALSE,
                  diagonal = "boxplot")

# graphical correlation matrix - corrgram package
library(corrgram)

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



t.test(mpg ~ am, data=mtcars)
boxplot(mpg ~ am, data=mtcars,
        col = c("blue","green"))
ggplot(data=mtcars, aes(as.factor(am), mpg)) +
  geom_boxplot()

# skip for now.....

boxplot(len ~ dose, data = ToothGrowth,
        boxwex = 0.25, at = 1:3 - 0.2,
        subset = supp == "VC", col = "yellow",
        main = "Guinea Pigs' Tooth Growth",
        xlab = "Vitamin C dose mg",
        ylab = "tooth length",
        xlim = c(0.5, 3.5), ylim = c(0, 35), yaxs = "i")
boxplot(len ~ dose, data = ToothGrowth, add = TRUE,
        boxwex = 0.25, at = 1:3 + 0.2,
        subset = supp == "OJ", col = "orange")
legend(2, 9, c("Ascorbic acid", "Orange juice"),
       fill = c("yellow", "orange"))

# session 3 =========================

# linear models
head(state.x77)
colnames(state.x77)
states <- as.data.frame(state.x77[,1:5])
names(states)
q <- names(states)[4]
names(states)[4] <- "LifeExp"
names(states)

fit1 <- lm(Murder ~ ., data=states)
summary(fit1)
fit2 <- lm(Murder ~ Population + Income + Illiteracy, data=states)
summary(fit2)

anova(fit1, fit2)

fit3 <- lm(Murder ~ LifeExp, data=states)
summary(fit3)

# try variable selection methods with stepAIC in MASS package
fit1 <- lm(Murder ~ ., data=states)
summary(fit1)
stepAIC(fit1, direction="backward")
stepAIC(fit1, direction="both")

# library leaps - all subsets regression
library(leaps)

leaps <- regsubsets(Murder ~ ., data=states, nbest=4)
plot(leaps, scale="adjr2")
library(car)
subsets(leaps, statistic="cp",
        main="Cp Plot for All subsets regression")
abline(1,1,lty=2,col="red")




# looking at interaction effects

fit <- lm(mpg ~ hp + wt + hp:wt, data=mtcars)
summary(fit)
library(effects)
plot(effect(term="hp:wt", 
            mod=fit,
            vcov.=vcov, 
            xlevels=list(wt=c(2.2, 3.2, 4.2))),
     multiline=TRUE)

# simple anova

library(multcomp)
head(cholesterol)
str(cholesterol)
table(cholesterol$trt)

df <- cholesterol

aggregate(df$response, 
          by=list(df$trt), 
          FUN=mean)

aggregate(df$response, 
          by=list(df$trt), 
          FUN=sd)

mystats <- function(x){
  m <- mean(x)
  n <- length(x)
  s <- sd(x)
  return(c(n=n, mean=m, stdev=s))
}

aggregate(df$response, 
          by=list(df$trt), 
          FUN=mystats)

fit <- aov(response ~ trt, df)
summary(fit)

library(gplots)
plotmeans(response ~ trt, data=df, 
          xlab="Treatment Groups",
          ylab="Response",
          main="Means Plot with 95% CI's")

# map example

head(USArrests)
aa <- tolower(rownames(USArrests))
aa2 <- rownames(USArrests)
crimes <- data.frame(state = tolower(rownames(USArrests)),
                     USArrests)
head(crimes)

library(maps)
states_map <- map_data("state")
crime_map <- merge(states_map, crimes, by.x="region", by.y="state")
head(crime_map)

library(plyr)
library(mapproj)
crime_map2 <- arrange(crime_map, group, order)
head(crime_map2)

ggplot(crime_map2, aes(x=long, y=lat, group=group, fill=Assault)) +
  geom_polygon(colour="black") +
  scale_fill_gradient2(low="#559999", mid="grey90", high="#BB650B",
                       midpoint=median(crimes$Assault)) +
  expand_limits(x=states_map$long, y=states_map$lat) +
  coord_map("polyconic")

# do one for Murder

ggplot(crime_map2, aes(x=long, y=lat, group=group, fill=Murder)) +
  geom_polygon(colour="black") +
  scale_fill_gradient2(low="#559999", mid="grey90", high="#BB650B",
                       midpoint=median(crimes$Murder)) +
  expand_limits(x=states_map$long, y=states_map$lat) +
  coord_map("polyconic")

# dates and times with lubridate

Sys.Date()
date()
today <- Sys.Date()
dob <- as.Date("1921-07-06") # Nancy Reagan's birthday
difftime(today, dob, units="weeks")
as.numeric(difftime(today, dob, units="days")/365)

diff1 <- today - dob
diff1
diff1/365

library(lubridate)
as.duration(diff1)
year(today) - year(dob)
wday(dob)
wday(dob, label=TRUE)



