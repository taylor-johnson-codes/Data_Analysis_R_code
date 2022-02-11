# Slide deck: Dplyr Exercises (slides 1-14)

library(tidyverse)
load("cdc.Rdata")

# Create a subset of cdc, cdc2 which contains only gender, height, and weight. Use head() to look at it.
cdc2 <- cdc %>%
  select(gender, height, weight)
head(cdc2) 

# Using dplyr package, create a dataframe cdc2 starting with cdc and eliminating the variable exerany.
library("dplyr")
glimpse(cdc)
cdc2 <- cdc %>%
  select(!exerany)  # or select(-exerany)
glimpse(cdc2)

# Create cdc2 by removing the variables exerany and genhlth from cdc
cdc2 <- cdc %>%
  select(!exerany & !genhlth)  # or select(-exerany & -genhlth)
glimpse(cdc2)

# Create a dataframe strong_couch which contains people who don't exercise and do smoke but have excellent 
# general health. Start with cdc. Use glimpse() to examine the results. Get a table of gender.
strong_couch <- cdc %>%
  filter(exerany == 0 & smoke100 == 1 & genhlth == "excellent")
glimpse(strong_couch)
table(strong_couch$gender)

# Create cdc2 from cdc by adding a factor version of smoke100 with labels "Non-Smoker" and "Smoker"
cdc2 <- cdc %>%
  mutate(smokef = factor(smoke100,labels=c("non-smoker", "smoker")))
glimpse(cdc2)

# Use mutate to create a variable odd. This variable is true if a man weighs less than 150 or 
# a woman weighs more than 200. Use mean() and sum() in summarize() to get the fraction of odd people and
# the count of odd people in cdc

cdcOdd <- cdc %>%
  mutate(odd = 
           (gender == "m" & weight < 150) |
           (gender == "f" & weight > 200)
        )
# need to finish
# Slide deck: Dplyr Exercises (slides 1-14)




