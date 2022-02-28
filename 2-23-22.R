# Slide deck: Patterns in Olympia Weather 1

library(tidyverse)
library(lubridate)
library(readr)
load("oly_airport.Rdata")

# This little presentation looks at patterns in the weather for the Olympia area. It is based on data from the Olympia Airport beginning in 1941. About a dozen observations were removed because one or more variables had missing values.
# Look at the data and see what we have.
str(oly_airport)
summary(oly_airport)

# To summarize the annual pattern, we need to put all of the data into a single year. You could think of this as making a prediction for an arbitrary future year. We need to do this so we can have a date variable that doesn’t contain different years. 
# We’ll use 2024 since it’s a leap year. We’ll call this new dataframe cal24. Use make_date() from the lubridate package. Run summary() on cal24 to verify that you succeeded.
cal24 = oly_airport %>% 
  mutate(DATE = make_date(2024,mo,dy), yr = year(DATE))

summary(cal24)

# Create a scatterplot showing all of the values of TMAX for each value of DATE. Set size and alpha to .1 in the call to geom_point() to deal with the overplotting.
cal24 %>% 
  ggplot(aes(x = DATE, y = TMAX)) +
  geom_point(size = .1, alpha = .1) +
  # Add geom_smooth() 
  geom_smooth(color = "red")

# Which takes longer, the rise or the fall? It seems to take longer going up.

# Add a geom_point() with red points to show calendar 2021. Create a dataframe cal21 by filtering for yr = 2021. Use make_date() to change the yr to 2024. 
# Add a second geom_point() with this dataframe as the data argument. Set the size parameter to .5 in the second geom_point().

cal21 = oly_airport %>% 
  filter(yr == 2021) %>% 
  mutate(DATE = make_date(2024,mo,dy))

str(cal21)

cal24 %>% 
  ggplot(aes(x = DATE, y = TMAX)) +
  geom_point(size = .2, alpha = .2) +
  geom_point(data = cal21,aes(x = DATE, y = TMAX), color = "red",size=.5)  # shows the hot summer 2021 outliers in red

# For each value of DATE compute a mean of TMAX and display the results in a graph.
cal24 %>% 
  group_by(DATE) %>% 
  summarize(MTMAX = mean(TMAX)) %>% 
  ggplot(aes(x = DATE,y = MTMAX)) +
  geom_point(size = .5)

# Do a density plot of the mean values of TMAX.
cal24 %>% 
  group_by(DATE) %>% 
  summarize(MTMAX = mean(TMAX)) %>% 
  ggplot(aes(x = MTMAX)) +
  geom_density(adjust = .2)

# Create a scatterplot showing all of the values of TMIN for each value of DATE. Set size and alpha to .1 in the call to geom_point() to deal with the overplotting.
cal24 %>% 
  ggplot(aes(x = DATE, y = TMIN)) +
  geom_point(size = .1, alpha = .1) +
  # Add geom_smooth() 
  geom_smooth(color = "red")
# shows there's a wider range of possible tenps in winter than in summer

# Add a geom_point() with red points to show calendar 2021. Create a dataframe cal21 by filtering for yr = 2021. Use make_date() to change the yr to 2024. 
# Add a second geom_point() with this dataframe as the data argument. Set the size parameter to .5 in the second geom_point().
cal21 = oly_airport %>% 
  filter(yr == 2021) %>% 
  mutate(DATE = make_date(2024,mo,dy))

cal24 %>% 
  ggplot(aes(x = DATE, y = TMIN)) +
  geom_point(size = .2, alpha = .2) +
  geom_point(data = cal21,aes(x = DATE, y = TMIN), color = "red",size=.5)

# For each value of DATE compute a mean of TMIN and display the results in a graph.
cal24 %>% 
  group_by(DATE) %>% 
  summarize(MTMIN = mean(TMIN)) %>% 
  ggplot(aes(x = DATE,y = MTMIN)) +
  geom_point(size = .5)

# Do a density plot of the mean values of TMIN.
cal24 %>% 
  group_by(DATE) %>% 
  summarize(MTMIN = mean(TMIN)) %>% 
  ggplot(aes(x = MTMIN)) +
  geom_density(adjust = .2)