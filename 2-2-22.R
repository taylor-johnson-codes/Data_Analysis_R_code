# Slide deck: Dplyr Exercises

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
  select(-exerany) %>%  # or select(!exerany)
  glimpse()

# Create cdc2 by removing the variables exerany and genhlth from cdc.
cdc2 <- cdc %>%
  select(-exerany & -genhlth) %>%  # or select(!exerany & !genhlth)
  glimpse()
# OR
# cdc2 <- cdc %>%
#   select(-c(exerany,genhlth) %>%  # "-" could be "!" instead
#   glimpse()

# Create a dataframe strong_couch which contains people who don't exercise and do smoke but have excellent 
# general health. Start with cdc. Use glimpse() to examine the results. Get a table of gender.
strong_couch <- cdc %>%
  filter(exerany == 0 & smoke100 == 1 & genhlth == "excellent") %>%
  glimpse()

table(strong_couch$gender)

# Create cdc2 from cdc by adding a factor version of smoke100 with labels "Non-Smoker" and "Smoker".
cdc2 <- cdc %>%
  mutate(smokef = factor(smoke100,labels=c("Non-smoker", "Smoker"))) %>%
  glimpse()

# Use mutate to create a variable odd. This variable is true if a man weighs less than 150 or 
# a woman weighs more than 200. Use mean() and sum() in summarize() to get the fraction of odd people and
# the count of odd people in cdc.
cdc %>% 
  mutate(odd = (gender == "m" & weight < 150) |
               gender == "f" & weight > 200) %>% 
  summarize(mean(odd), sum(odd))

# Create a dataframe health_gender from cdc with one row for every combination of genhlth and gender. 
# Use summarize to get the count of cases and the mean of weight. Don’t forget to ungroup(). Use glimpse to see the result.
health_gender = cdc %>% 
  group_by(genhlth,gender) %>% 
  summarize(count = n(), mean_weight = mean(weight)) %>% 
  ungroup() %>% 
  glimpse()

# Extend your code from the previous exercise to sort your dataframe in ascending order by count. Use head() to see the result.
health_gender = cdc %>% 
  group_by(genhlth,gender) %>% 
  summarize(count = n(), mean_weight = mean(weight)) %>% 
  ungroup() %>% 
  arrange(count) 

head(health_gender)

# Repeat the previous exercise, but sort in descending order by mean_weight.
health_gender = cdc %>% 
  group_by(genhlth,gender) %>% 
  summarize(count = n(), mean_weight = mean(weight)) %>% 
  ungroup() %>% 
  arrange(desc(mean_weight)) 

head(health_gender)


load("county.rda")

# Do a summary of the dataframe to look for anomalies.
summary(county)  

# Where are the NA values coming from?
county %>% 
  filter(is.na(pop2017) |
           is.na(pop2000) |
           is.na(pop_change) |
           is.na(median_edu) |
           is.na(median_hh_income) |
           is.na(unemployment_rate) |
           is.na(metro) |
           is.na(per_capita_income))

# Replace county with county_clean, from which all the bad data has been removed. Research: Remove cases with missing values using dplyr.
# Repeat the summary and verify.

county_clean = county %>% 
  select(-smoking_ban) %>% 
  drop_na() 

summary(county_clean)
glimpse(county_clean)

# Calculate the total population in each state for 2017. Sort the results in ascending order. Use head() and tail() to examine the results.
state_pop = county_clean %>% 
  select(state,pop2017) %>% 
  group_by(state) %>% 
  summarize(pop = sum(pop2017)) %>% 
  arrange(pop)

head(state_pop)
tail(state_pop)

# What happens if we do this with county instead of county_clean?
state_pop = county %>% 
  select(state,pop2017) %>% 
  group_by(state) %>% 
  summarize(pop = sum(pop2017)) %>% 
  arrange(pop)

head(state_pop)
tail(state_pop)

# Calculate state per capita income for 2017 and arrange in ascending order. Examine the head and the tail.
# Hint: Begin by calculating total income for each county.
state_per_cap_income = county_clean %>% 
  mutate(inc_17 = pop2017 * per_capita_income) %>% 
  group_by(state) %>% 
  summarize(total_pop = sum(pop2017), total_inc = sum(inc_17)) %>% 
  ungroup() %>% 
  mutate(state_per_cap = total_inc/total_pop) %>% 
  select(state,state_per_cap) %>% 
  arrange(state_per_cap)

head(state_per_cap_income)
tail(state_per_cap_income)

save(state_per_cap_income, file = "state_per_cap_income.Rdata")