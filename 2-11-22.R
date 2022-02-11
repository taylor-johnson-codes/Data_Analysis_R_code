# Slide deck: Exercises on ggplot2 (3)

library(tidyverse)
load("county_clean.Rdata")
state_region <- read_csv("state_region.csv")

# left_join code from end of 2-7-22
# Use left_join to join the region dataframe to the bulk of the data. Glimpse the result.
# LOOK AT HIS CODE
county_clean_joined = county_clean %>%
  left_join(state_region, by = c("state" = "State"))
glimpse(county_clean_joined)


# Display the distribution of per_capita_income using a histogram.
county_clean_joined %>%
  ggplot(aes(per_capita_income)) + 
  geom_histogram()

# see slide 6

# see slide 7
# Display the distribution per_capita_income using geom_density()
county_clean_joined %>%
  ggplot(aes(per_capita_income)) + 
  geom_density()

# see slide 9


# see slide 10
county_clean_joined %>%
  ggplot(aes(per_capita_income)) + 
  geom_density(adjust = 0.5)  # shows more shape detail on line

county_clean_joined %>%
  ggplot(aes(per_capita_income)) + 
  geom_density(adjust = 2)  # shows less shape detail on line/more of a curve; equivalent to using smaller number of bins in a histogram

# see slide 12
county_clean_joined %>%
  ggplot(aes(per_capita_income)) + 
  geom_density() +
  geom_rug()  # one stroke per observation is displayed along the x-axis

# see slide 15
# Do a facet by region of the last graph



