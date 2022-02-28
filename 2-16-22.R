# Slide deck: Olympia Weather Factoids

library(tidyverse)
library(lubridate)
load("oly_airport.Rdata")  # olympia airport weather from data May 13, 1941 to Feb 15, 2022

# Look at today’s weather in the weather channel. What are TMAX, TMIN, and the probability of rain. 
# How do these values compare with the historical data for this day and month?

# As I write these notes it is February 15, 2022. From the weather channel, TMIN = 39, TMAX = 49, and 
# the probability of rain is 3%. Start with summary(). Just use PRCP, TMAX, and TMIN.
feb15 = oly_airport %>% 
  filter(dy == 15 & mo == 2) %>% 
  select(PRCP,TMAX,TMIN)

summary(feb15)
# We can see that TMAX is right on the mean and median. However, TMIN is about six degrees above the central values. 

# To compare the probability of rain, we need to do another computation to see the historical value. Do this.
mean(feb15$PRCP > 0)
# So 72.5% of the time there is measurable precipitation on February 15. Our current value of 3% is very low.

# How do you think the weather one month in the future will be. How will it compare with today? Start with a summary().
mar15 = oly_airport %>% 
  filter(dy == 15 & mo == 3) %>% 
  select(PRCP,TMAX,TMIN) 

summary(mar15)

mean(mar15$PRCP > 0)

# Here’s what I see:
# The probability of rain has fallen by about 8%.
# The mean of TMAX has increased by about 4 degrees.
# The mean of TMIN has increased by about 1 degree.

# On what days has the maximum daily temperature exceeded 100 degrees? How many? When?
oly_airport %>% 
  filter(TMAX > 100) %>% 
  arrange(DATE) %>% 
  select(DATE,TMAX)
# shows the date and temp for 13 days since 1941 where the temp was over 100

# Repeat the exercise above for days with a TMIN below zero.
oly_airport %>% 
  filter(TMIN < 0) %>% 
  arrange(DATE) %>% 
  select(DATE,TMIN)
# shows the date and temp for 12 days since 1941 where the temp was under 0

# What were the ten heaviest days of rainfall in Olympia. Sort them by date.
oly_airport %>% 
  arrange(PRCP) %>% 
  tail(10) %>% 
  arrange(DATE) %>% 
  select(DATE, PRCP)

# How frequently do we see a minimum temperature below 32 combined with rain in January.
oly_airport %>% 
  filter(mo == 1) %>% 
  mutate(bad = TMIN < 32 & PRCP > 0) %>% 
  summarise(mean(bad))  # 0.169 (16.9%)

# Repeat for February
oly_airport %>% 
  filter(mo == 2) %>% 
  mutate(bad = TMIN < 32 & PRCP > 0) %>% 
  summarise(mean(bad))  # 0.146 (14.6%)

# Repeat for March
oly_airport %>% 
  filter(mo == 3) %>% 
  mutate(bad = TMIN < 32 & PRCP > 0) %>% 
  summarise(mean(bad))  # 0.115 (11.5%)

# Which days of the year have the highest probability of rain? List them in order of probability.
oly_airport %>% 
  group_by(mo, dy) %>% 
  summarize(p_rain = mean(PRCP > 0)) %>% 
  ungroup() %>% 
  arrange(p_rain) %>% 
  tail(10)
# `summarize()` has grouped output by 'mo'. You can override using the `.groups` argument.