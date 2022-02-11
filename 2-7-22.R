# Slide deck: Exercises on ggplot2

library(tidyverse)
load("county_clean.Rdata")
state_region <- read_csv("state_region.csv")

glimpse(county_clean)  # note column state is not capitalized
glimpse(state_region)  # note column State is capitalized

# Do a simple scatter plot of per_capita_income on the y-axis against homeownership on the x-axis.
county_clean %>%
  ggplot(aes(homeownership, per_capita_income)) +
  geom_point()

# alternative:
# ggplot(county_clean, aes(homeownership, per_capita_income)) +
#   geom_point()

# Use the alpha and size parameters of geom_point() to clean up the overplotting. Add a smoother.
county_clean %>%
  ggplot(aes(homeownership, per_capita_income)) +
  geom_point(alpha = 0.5, size = 0.5) +
  geom_smooth(color = "red")

# The variable median_edu is categorical and the variable per_capita_income is quantitative. Put the education variable
# on the x-axis and the income variable on the y-axis. Use geom_point().
county_clean %>%
  ggplot(aes(median_edu, per_capita_income)) +
  geom_point()  # plot has a lot of overlapping

# Repeat with geom_jitter(). Play with the size parameter to get a value you like.
county_clean %>%
  ggplot(aes(median_edu, per_capita_income)) +
  geom_jitter(size = 0.5)  # can see how many data points there are for each x-axis value since they're no longer overlapping

# Add labels to the graph
# LOOK AT HIS CODE - SLIDE 15
county_clean %>%
  ggplot(aes(median_edu, per_capita_income)) +
  geom_jitter(size = 0.5) +
  xlab("Education Level") +
  ylab("Income Level") +
  ggtitle("Per Capita Income by Education Level", subtitle = "US Counties 2017")

# Use left_join to join the region dataframe to the bulk of the data. Glimpse the result.
# LOOK AT HIS CODE
county_clean_joined = county_clean %>%
  left_join(state_region, by = c("state" = "State"))

glimpse(county_clean_joined)

# missed slide 18-19















