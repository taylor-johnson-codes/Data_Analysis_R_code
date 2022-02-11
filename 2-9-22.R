# Slide deck: Exercises on ggplot2 (2)

library(tidyverse)
load("county_clean.Rdata")
state_region <- read_csv("state_region.csv")

# left_join code from end of 2-7-22
# Use left_join to join the region dataframe to the bulk of the data. Glimpse the result.
# LOOK AT HIS CODE
county_clean_joined = county_clean %>%
  left_join(state_region, by = c("state" = "State"))
glimpse(county_clean_joined)

# An alternative for Two Categorical Variables
# Examine the relationship between median educational level and region. Put region on the x-axis and median education on
# the y-axis. Use geom_jitter(). Try some different size values in jitter.
county_clean_joined %>%
  ggplot(aes(Region, median_edu)) + 
  geom_jitter(size = 0.8)

# Repeat with geom_count() instead
county_clean_joined %>%
  ggplot(aes(Region, median_edu)) + 
  geom_count()


# Cleveland style (starting simple and progressing to more complex)

# Get a barplot of the number of counties in each state using geom_bar().
county_clean_joined %>%
  ggplot(aes(state)) +
  geom_bar()  # x-axis labels are unreadable due to overlapping

# Add coord_flip() as a layer
county_clean_joined %>%
  ggplot(aes(state)) +
  geom_bar() +
  coord_flip()  # now they're on the y-axis and readable

# Use dplyr to create a dataframe state_counties with state name and the count of counties
state_counties <- county_clean_joined %>%
  group_by(state) %>%
  summarize(count = n()) %>%
  ungroup()
state_counties

# Use state_counties as the data argument of ggplot. In the aes, max x to count and y to state. Use geom_col()
state_counties %>%
  ggplot(aes(count, state)) + 
  geom_col()

# Instead of state, use reorder(state, count)
state_counties %>%
  ggplot(aes(count, reorder(state, count))) +  # puts states on the y-axis in order of states that have the lowest count to the highest count
  geom_col()

# Replace geom_col() with geom_point()
state_counties %>%
  ggplot(aes(count, reorder(state, count))) +  
  geom_point()  # harder to read

# Add a geom_col() and set width = 0.1
state_counties %>%
  ggplot(aes(count, reorder(state, count))) +  
  geom_point() +
  geom_col(width = 0.1)  # a little better to read; this is the ultimate Cleveland style


# Get a histogram of pop2017
county_clean_joined %>%
  ggplot(aes(pop2017)) + 
  geom_histogram()  # not useful without logarithmic scale

county_clean_joined %>%
  ggplot(aes(pop2017)) + 
  geom_histogram() +
  scale_x_log10()



