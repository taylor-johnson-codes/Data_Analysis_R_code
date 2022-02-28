# Slide deck: Questions About Weather

library(tidyverse)
library(lubridate)
load("oly_airport.Rdata")

# Are we experiencing a drought during the months of May through August?
# I did it by looking at a time-series of z-scores instead of raw data. If I saw recent numbers below -3, I’d know something was going on.
# I also did a histogram of the raw data.
rain_5_8 = oly_airport %>% 
  select(DATE,PRCP) %>% 
  mutate(mo = month(DATE),
         yr = year(DATE) )%>% 
  filter(mo >= 5 & mo <= 8) %>% 
  group_by(yr) %>% 
  summarize(rain = sum(PRCP)) %>% 
  ungroup() %>% 
  mutate(mrain = mean(rain),
         sdrain  = sd(rain),
         z_score = (rain - mean(rain))/sdrain) 

head(rain_5_8)

rain_5_8 %>% 
  ggplot(aes(x = yr, y = z_score)) +
  geom_point() +
  geom_line(size = .1) 

# The lowest z-score was actually in 2018, but it was only -2, no indication of drought. The two most recent years, 20 and 21, have z-scores near zero.
# Here’s the histogram.
rain_5_8 %>% 
  ggplot(aes(x = rain)) +
  geom_histogram( )

# How many perfect days do we get in a year? The suggestion was that a perfect day would have a maximum temperature of 75 and would have no rain.
# Here is some code to get the counts of perfect days in a year.
oly_airport %>% 
  filter(TMAX == 75 & PRCP == 0) %>% 
  group_by(yr) %>% 
  summarize(count = n()) %>% 
  filter(count > 0) %>% 
  ungroup() %>% 
  ggplot(aes(x = factor(count))) + 
  geom_bar()
# The most common year count is six. There have been years with only one.

# I got curious about which months have perfect days. I suspect they happen mostly in July and August.
oly_airport %>% 
  filter(TMAX == 75 & PRCP == 0) %>% 
  ggplot(aes(x = mo)) + 
  geom_bar()
# August has more perfect days than any other month, with July coming in as a close second. June and September are very similar.