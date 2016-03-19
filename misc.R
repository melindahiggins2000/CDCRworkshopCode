
setwd('C:/MyGithub/CDCRworkshopCode')

library(haven)

df <- read_sas('cars1.sas7bdat')
df <- read_sas('data1.sas7bdat')

search()

within(xdf, {
  t1 <- table(x1)
  s1 <- sum(x1)
  m1 <- mean(x1)
  search()})

table(xdf$x1)
sum(x1)
mean(x1)

xdf$t1 <- xdf$s1 <- xdf$m1 <- NULL

with(xdf, table(x1))
with(xdf, sum(x1, na.rm=TRUE))
with(xdf, mean(x1, na.rm=TRUE))

with(xdf, {
  print(table(x1))
  print(sum(x1, na.rm=TRUE))
  print(mean(x1, na.rm=TRUE))
  b <- 5
  print(xdf)
})

within(xdf, {
  print(table(x1))
  print(sum(x1, na.rm=TRUE))
  print(mean(x1, na.rm=TRUE))
  b <- 5
  print(xdf)
})

# with() v within() v transform()

#' see http://www.r-bloggers.com/friday-function-triple-bill-with-vs-within-vs-transform/
#

fahrenheit_to_celcius <- function(f) (f - 32) / 1.8

airquality <- with(airquality, list(
  fahrenheit_to_celcius(Temp),
  log(Ozone),
  month.abb[Month]
))

rm(airquality)

airquality <- within(airquality,
                     {
                       cTemp2     <- fahrenheit_to_celcius(Temp)
                       logOzone2  <- log(Ozone)
                       MonthName2 <- month.abb[Month]
                     })

airquality <- transform(airquality,
                        cTemp3     = fahrenheit_to_celcius(Temp),
                        logOzone3  = log(Ozone),
                        MonthName3 = month.abb[Month]
)


#' The most important lesson to take away from this is 
#' that if you are manipulating data frames, then with, 
#' within and transform can be used almost interchangeably, 
#' and all of them should be used in preference to attach. 
#' For further refinement, I prefer with for single updates 
#' to data frames, and within or transform for multiple updates.
#

# also see more at http://r4stats.com/2013/01/22/comparing-tranformation-styles/ 
# with v mutate v within - votes in favor of within...

datafile<-tempfile()
codefile<-tempfile()
write.foreign(esoph,datafile="datafile1.txt",
              codefile="codefile1.sys",package="SPSS")
unlink(datafile)
unlink(codefile)






