# slide deck: Gender Mix

# If a live birth occurs, what is the probability that the child is male? Most people would say 50%. That is close but not exactly right.
# What is the proportion of males in a given set of births?
# Does this vary by the age of the mother, the geographical location, or the race of the mother.

library(tidyverse)
library(plotly)

# This data is from CDC Wonder and covers the years 2007 through 2019. The race variable we are using was dropped for 2020.
load("Gender.Rdata")

# To retrieve this data from scratch:
# wonder.cdc.gov, Births link, 2007-2020, group by drop downs: census, age mom 9, mom's bridged race, gender, year 

# Gender <- read_delim("Natality, 2007-2020.txt", 
#                      delim = "\t", escape_double = FALSE, 
#                      col_names = TRUE, trim_ws = TRUE) %>% 
#   select(`Census Region Code`, `Age of Mother 9`,Year,
#          `Mother's Bridged Race`,Gender,Births) %>% 
#   filter(Year < 2020)  %>% 
#   drop_na() 

# Do a summary(), glimpse(), and head() of the dataframe.
summary(Gender)
glimpse(Gender)
head(Gender)

# We want to have two separate columns name Male and Female. These columns contain the numbers of births.
# Use pivot_wider() to accomplish this. Check the results with the three functions above.
# pivot_wider() "widens" data, increasing the number of columns and decreasing the number of rows. The inverse transformation is pivot_longer().

Gender = Gender %>% 
  pivot_wider(names_from = Gender, values_from = Births) %>% 
  drop_na() 

summary(Gender)
glimpse(Gender)
head(Gender)

# Use the code from slide deck Fertility 3 slide 5 to fix the names and values in this dataframe.
Gender = Gender %>% 
  rename(Region = `Census Region Code`,
         Race = `Mother's Bridged Race`,
         Age = `Age of Mother 9`) %>% 
  mutate(Region = ifelse(Region == "CENS-R1","NE",Region),
         Region = ifelse(Region == "CENS-R2","MW",Region),
         Region = ifelse(Region == "CENS-R3","SO",Region),
         Region = ifelse(Region == "CENS-R4","WE",Region),
         Race = ifelse(Race == "American Indian or Alaska Native","AmInd",Race),
         Race = ifelse(Race == "Asian or Pacific Islander","API",Race),
         Race = ifelse(Race == "Black or African American","Black",Race))

View(Gender)
glimpse(Gender)

# Use all of the data to compute the proportion of males in live births.
Gender %>% 
  summarize(Male = sum(Male),
            Female = sum(Female)) %>% 
  mutate(p = Male/(Male + Female))
# proportion = 0.5116

# https://www.ssa.gov/oact/STATS/table4c6.html
# the Period of Life table shows death probability and life expectancy of males and females.
# even though more males are born, males have a lower life expectancy and higher death probability

# info about Confidence Intervals: https://rpubs.com/HaroldNelsonJr43/122215

# Use this data to ask if the Male ratio differs by Age.
Gender %>% 
  group_by(Age) %>% 
  summarize(n = sum(Male + Female),  # number
            p = sum(Male)/(n)) %>%  # proportion
  mutate(se = sqrt(p*(1-p)/n),  # standard error
         ub = p + 1.96 * se,  # upper bound
         lb = p - 1.96 * se) %>%  # lower bound
  ggplot(aes(y = Age ) )  +
  geom_point(aes(x = p), color = "black") +
  geom_point(aes(x = lb), color = "red") +
  geom_point(aes(x = ub), color = "blue") +
  ggtitle("95% Confidence Intervals for Male Ratio") +
  geom_vline(aes(xintercept =.5116))

# Use this data to ask if the Male ratio differs by Race.
Gender %>% 
  group_by(Race) %>% 
  summarize(n = sum(Male + Female),
            p = sum(Male)/(n)) %>% 
  mutate(se = sqrt(p*(1-p)/n),
         ub = p + 1.96 * se,
         lb = p - 1.96 * se) %>% 
  ggplot(aes(y = Race ) )  +
  geom_point(aes(x = p), color = "black") +
  geom_point(aes(x = lb), color = "red") +
  geom_point(aes(x = ub), color = "blue") +
  ggtitle("95% Confidence Intervals for Male Ratio") +
  geom_vline(aes(xintercept =.5116))

# Use this data to ask if the Male ratio differs by Year.
Gender %>% 
  group_by(Year) %>% 
  summarize(n = sum(Male + Female),
            p = sum(Male)/(n)) %>% 
  mutate(se = sqrt(p*(1-p)/n),
         ub = p + 1.96 * se,
         lb = p - 1.96 * se) %>% 
  ggplot(aes(y = Year ) )  +
  geom_point(aes(x = p), color = "black") +
  geom_point(aes(x = lb), color = "red") +
  geom_point(aes(x = ub), color = "blue") +
  ggtitle("95% Confidence Intervals for Male Ratio") +
  geom_vline(aes(xintercept =.5116))

# Use this data to ask if the Male ratio differs by Region.
Gender %>% 
  group_by(Region) %>% 
  summarize(n = sum(Male + Female),
            p = sum(Male)/(n)) %>% 
  mutate(se = sqrt(p*(1-p)/n),
         ub = p + 1.96 * se,
         lb = p - 1.96 * se) %>% 
  ggplot(aes(y = Region ) )  +
  geom_point(aes(x = p), color = "black") +
  geom_point(aes(x = lb), color = "red") +
  geom_point(aes(x = ub), color = "blue") +
  ggtitle("95% Confidence Intervals for Male Ratio") +
  geom_vline(aes(xintercept =.5116))