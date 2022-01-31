load("cdc.Rdata")
summary(cdc)

#1-24-22:

NA == NA
is.na(NA==NA)

P=c(T,T,F,F)
Q=c(T,F,T,F)
P_and_Q = P & Q
df_tt_and = data.frame(P,Q,P_and_Q)
P_or_Q = P | Q
df_tt_or = data.frame(P,Q,P_or_Q)
df_tt_and
df_tt_or

R=c(T,F)
not_R = !R
#finish code from slide 11

Exp1 = !(P&Q)
Exp2 = !P | !Q

tt_df = data.frame(P,Q,Exp1,Exp2)
tt_df

Exp1 == Exp2

sum(Exp1==Exp2)
length(Exp1==Exp2)

sum(Exp1==Exp2) == length(Exp1==Exp2)

mean(Exp1) == mean(Exp2)

# do code for slide 17 and 18, slide deck Logical Values

# class 1-26-22:
# slide deck Exercises on Functions i think

# Create a function my_range() that returns the value of the range of a numeric vector.

my_range = function(x){
  
  return(max(x) - min(x))
}

rn = rnorm(1000)
# The rnorm() function in R generates a random number using a normal(bell curve) distribution. 
# Thus, the rnorm() function simulates random variates having a specified normal distribution.

my_range(rn)


# Create a function range_95() that returns the difference between the 95th percentile and the 
# 5th percentile of a numeric vector.

range_95 = function(x){
  
  return(quantile(x,.95) - quantile(x,.05))
}
# The generic function quantile produces sample quantiles corresponding to the given probabilities. 
#The smallest observation corresponds to a probability of 0 and the largest to a probability of 1.

range_95(rn)


# Create a function range_85() that returns the difference between the 85th percentile and the 
# 15th percentile of a numeric vector.

range_85 = function(x){
  
  return(quantile(x,.85) - quantile(x,.15))
}

range_85(rn)

quantile(rn, .85)

# 1-28-22:

#8 of 17 slide deck Exercises on Functions
# We've created separate functions for range_85() and range_95(). In addition we have the built-in function IQR(), which is
# essentially range_75(). Create a function gen_range(x,pct), where the parameter pct takes the place of 75, 85, and 95 in our examples.

gen_range = function(x, pct){
  top = quantile(x,pct/100)
  bottom = quantile(x,1 - pct/100)
  #finish code from slide 9
  
  
  
}

#slide 10:
# Create a function rmsd(x,y) which returns the square root of the mean of the squares of values of the differences 
# between x and y.

#my code:
rmsd = function(x,y){
  difference = x-y
  sqrtOfDiff = sqrt(difference)
  return (mean(sqrtOfDiff))
}
rmsd(150,100)

#his code:  slide 11

#slide 12:
# Create a function mad(x,y) which returns the mean of the absolute values of the differences between x and y.

#my code:
mad = function(x,y){
  difference = x-y
  absValue = abs(difference)
  return(mean(absValue))
}
x = rnorm(1000)
y = rnorm(1000)
mad(x,y)
  
#his code slide 13

#slide 15: his x should be the rn

#slide 16: 
# Create an inverse of the quantile() function, qinv(x,val). The parameter s is a numeric vector. The parameter val is a
# single number. The function returns the fraction of the values of x that are less than val.

#his code:
qinv = function(x,val){
 return(mean(x<val))
}


# Go thru DC tidyverse course before moving on here
#recommended to read Moderndive (top of moodle) on tidyverse

# Tidyverse slide deck
#slide 4:
# Create a new version of diamonds, called d. Cut, color, and clarity should be simple character variables. Make a new
# variable ppc, the price per carat.

#his code slide 5:
#x,y,z are the dimensions of the diamond; need dimensions to be greater than zero

#slide 6


# 1-31-22:

#slide deck 5 main graphs / chap 2 modern dive


install.packages("tidyverse")
library("tidyverse")

library(ggplot2)
library(dplyr)

load("county.rda")
summary(county)

# Use the county dataframe. Make a scatterplot with poverty on the x-axis and pop_change on the y-axis.
ggplot(data = county, mapping = aes(x = poverty, y = pop_change)) + 
  geom_point()

# Reduce the value of alpha in geom_point() to solve the overplotting problem.
ggplot(data = county, mapping = aes(x = poverty, y = pop_change)) + geom_point(alpha = .2)

# Try using a reduced size (default = 1) instead of alpha.
ggplot(data = county, mapping = aes(x = poverty, y = pop_change)) + 
  geom_point(size = .1)

# Use geom_jitter() instead of geom_point() to solve the problem.
ggplot(data = county, mapping = aes(x = poverty, y = pop_change)) + 
  geom_jitter()

# Add a geom_smooth() layer.
# (This one is not in the Modern Dive reading)
ggplot(data = county, mapping = aes(x = poverty, y = pop_change)) + 
  geom_point(size = .2) + geom_smooth(color = "red")


# Download the file unrate.csv from Moodle and use the “Import Dataset” feature in the upper-right pane, Environment Tab, to get some recent unemployment rate data. Save the code in a chunk.

# data came from FRED St. Louis Fed

# In environment tab, Import Dateset, From Text (readr), Browse, select file, Import

UNRATE <- read_csv("UNRATE.csv")  # unemployment rate data
glimpse(UNRATE)

# Make a linegraph of the unemployment rate.
ggplot(data = UNRATE, 
       mapping = aes(x = DATE, y = UNRATE)) +
  geom_line()

# In the geom_line(), set linetype = “dotted”. Add a geom_point() layer.
# (Dr. Nelson's preferred line graph)
ggplot(data = UNRATE, 
       mapping = aes(x = DATE, y = UNRATE)) +
  geom_line(linetype = "dotted") +  # lines shows direction data is going
  geom_point()  # every dot represents a month


load("cdc.Rdata")
summary(cdc)

# Make a histogram of the variable weight in the cdc dataframe.
ggplot(data = cdc, mapping = aes(x = weight)) +
  geom_histogram()

# Try some different values of bins. The default is 30, so try 15 and 60.
ggplot(data = cdc, mapping = aes(x = weight)) +
  geom_histogram(bins = 15)

ggplot(data = cdc, mapping = aes(x = weight)) +
  geom_histogram(bins = 60)

# Use facetting to get separate histograms of the weights of men and women. Set nrow = 2.
ggplot(data = cdc, mapping = aes(x = weight)) +
  geom_histogram() +
  facet_wrap(~gender,nrow = 2)

# Do a side-by-side boxplot of the weights of men and women.
ggplot(data = cdc, mapping = aes(x = gender, y = weight)) +
  geom_boxplot()

# The boxplot command in ggplot2 requires an x-variable. The base R boxplot does not. If you want to use the ggplot version without an x-variable, you can supply a constant. I recommend a string containing the name of the variable.
ggplot(data = cdc, aes(x = "Weight", y = weight)) + 
  geom_boxplot()

# Create a barplot of gender in the cdc dataframe.
ggplot(data = cdc, aes(x = gender)) + geom_bar()

# The barplot geom does the counting of cases in raw data. If the counting has already been done, we use geom_col() instead.
cdc %>% 
  group_by(gender) %>% 
  summarize(count = n()) %>% 
  ggplot(aes(x = gender,y = count)) +
  geom_col()








