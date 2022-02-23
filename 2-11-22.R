# Slide deck: Exercises on ggplot2 (3)

library(tidyverse)
library(ggplot2)
load("county_clean.Rdata")
state_region <- read_csv("state_region.csv")

# Use left_join to add the region data to county_clean. Glimpse county_clean to make sure you’re OK.
county_clean = county_clean %>%
  left_join(state_region, by = c("state" = "State")) %>%
  glimpse()

# Display the distribution of per_capita_income using a histogram.
county_clean %>%
  ggplot(aes(x=per_capita_income)) + 
  geom_histogram()

# The data displayed by default with a histogram is the count of observations in each bin. You can also ask that the data be normalized so that the total area of the histogram is equal to 1.0. 
# To see this, in the call to geom_histogram() insert aes(y = ..density..).
# The .. .. indicates to ggplot2 that this “variable” is not present in the dataframe, but will be made available.
county_clean %>% 
  ggplot(aes(x = per_capita_income)) +
  geom_histogram(aes(y = ..density..))

# We have an alternative, geom_density(), to geom_histogram() which displays the distribution of a single quantitative variable.
# Display the distribution of per_capita_income using geom_density() in place of geom_histogram().
county_clean %>% 
  ggplot(aes(x = per_capita_income)) + 
  geom_density()  # makes a curved continuous line instead of jagged bars

# Add geom_histogram() to the previous graph for comparison.
county_clean %>% 
  ggplot(aes(x = per_capita_income)) + 
  geom_histogram(aes(y = ..density..)) +
  geom_density() 

# geom_density has an optional parameter, adjust. The default value is 1. Try setting it to .5 and 2.
county_clean %>%
  ggplot(aes(per_capita_income)) + 
  geom_density(adjust = 0.5)  # shows more shape detail along the line

county_clean %>%
  ggplot(aes(per_capita_income)) + 
  geom_density(adjust = 2)  # shows less shape detail along the line, more of a curve; equivalent to using smaller number of bins in a histogram

# Use geom_density() and add geom_rug(). There is a stroke for each observation.
county_clean %>%
  ggplot(aes(per_capita_income)) + 
  geom_density() +
  geom_rug()  # one stroke per observation is displayed along the x-axis

# Do a facet by region of the last graph
county_clean %>% 
  ggplot(aes(x = per_capita_income)) + 
  geom_density() +
  geom_rug() +
  facet_wrap(~Region, ncol = 1)  # creates one graph for each region (so four graphs total)