# Slide deck: Exercises on ggplot2

library(tidyverse)
library(ggplot2)
load("county_clean.Rdata")
state_region <- read_csv("state_region.csv")

glimpse(county_clean)  # note column state is not capitalized
glimpse(state_region)  # note column State is capitalized

# Do a simple scatter plot of per_capita_income on the y-axis against homeownership on the x-axis.
county_clean %>%
  ggplot(aes(x=homeownership, y=per_capita_income)) +
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
  geom_point()  # plot has a lot of overlapping/overplotting

# Repeat with geom_jitter(). Play with the size parameter to get a value you like.
county_clean %>%
  ggplot(aes(median_edu, per_capita_income)) +
  geom_jitter(size = 0.5)  # can see how many data points there are for each x-axis value since they're no longer overlapping

# Make the graph look more professional.
# Add labels to the graph
# my attempt:
county_clean %>%
  ggplot(aes(median_edu, per_capita_income)) +
  geom_jitter(size = 0.5) +
  xlab("Education Level") +
  ylab("Income Level") +
  ggtitle("Per Capita Income by Education Level", subtitle = "US Counties 2017")

# his nicer looking code:
county_clean %>% 
  ggplot(aes(x = median_edu, y = per_capita_income)) +
  geom_jitter(size = .5) +
  labs(x = "Median Educational Level",
       y = "Per Capita Income",
       title = "Per Capita Income by Education Level",
       subtitle = "US Counties 2017")

# Use left_join to join the region dataframe to the bulk of the data. Glimpse the result.
county_clean = county_clean %>% 
  left_join(state_region,by = c("state" = "State")) %>%
  glimpse()

# Use geom_bar and fill to describe the relationship between Regian and median_edu. Make Region a factor first. In the call to geom_bar() set color = “white”.
county_clean = county_clean %>% 
  mutate(Region = factor(Region))

county_clean %>% 
  ggplot(aes(x = Region, fill = median_edu)) +
  geom_bar(color = "white")

# The default value of the parameter position is “stack”. Try setting position = “dodge” and “dodge2”.
county_clean %>% 
  ggplot(aes(x = Region, fill = median_edu)) +
  geom_bar(color = "white",position = "dodge") +
  ggtitle("position = 'dodge'")

county_clean %>% 
  ggplot(aes(x = Region, fill = median_edu)) +
  geom_bar(color = "white",position = "dodge2") +
  ggtitle("position = 'dodge2'")