# Slide deck: Patterns 2

#install.packages("plotly")
library(plotly)
library(tidyverse)
library(lubridate)
library(readr)
load("oly_airport.Rdata")

cal24 = oly_airport %>% 
  mutate(DATE = make_date(2024,mo,dy), yr = year(DATE))

summary(cal24)

# Do a plot of the standard deviation of TMAX based on cal24.
cal24 %>% 
  group_by(DATE) %>% 
  summarize(sd_TMAX = sd(TMAX)) %>% 
  ungroup() %>% 
  ggplot(aes(x = DATE, y = sd_TMAX)) +
  geom_point() +
  ggtitle("Standard Deviation of TMAX")

# Let’s look at the annual pattern for the difference between TMAX and TMIN using cal24.
cal24 %>% 
  mutate(diff = TMAX - TMIN) %>% 
  group_by(DATE) %>% 
  summarize(diff = mean(diff)) %>% 
  ungroup() %>% 
  ggplot(aes(x = DATE, y = diff)) +
  geom_point() +
  ggtitle("Difference between TMAX and TMIN")
# The difference is much larger during the warm months of the year.

# We can use plotly to make a plot interactive in two steps.
# 1. Create a ggplot object instead of just displaying the plot. You can display the plot by referencing the named object.
# 2. Use the named object in a call to ggplotly() to get an interactive graph.

# There are two possible ways to look at precipitation. We could use either the mean value of precipitation for a date, or the probability of precipitation on that date.
# Do the mean value of precipitation first. We’ll use plotly.
g1 = cal24 %>% 
  group_by(DATE) %>% 
  summarize(mean_precip = mean(PRCP)) %>% 
  ungroup() %>% 
  ggplot(aes(x = DATE, y = mean_precip)) +
  geom_point()

ggplotly(g1) # For Rpubs or other html; g1  For word
# Now when you hover over a point on the graph you get more info about that point

# Now do the probability of precipitation.
g2 = cal24 %>% 
  group_by(DATE) %>% 
  summarize(prob_precip = mean(PRCP > 0)) %>% 
  ungroup() %>% 
  ggplot(aes(x = DATE, y = prob_precip)) +
  geom_point()

ggplotly(g2)
# Observation: Based on these two graphs, there are obvious similarities between the two, but there is one notable difference. 
# The heavy rainfall of November and December does not carry over to the following January and February.

# Create a graph showing loess curves for precipitation and TMAX. Since these two variables have such different values, you will have to create z-scores to make them visually compatible. 
# Call the z-score variables n_TMAX and n_PRCP.
# z-score = (value-mean)/standard deviation
cal24 %>% 
  mutate(n_TMAX = (TMAX - mean(TMAX))/sd(TMAX),
         n_PRCP = (PRCP - mean(PRCP))/sd(PRCP)) %>% 
  ggplot(aes(x = DATE)) +
  geom_smooth(aes(y = n_TMAX), color = "red") +
  geom_smooth(aes(y = n_PRCP), color = "blue")
# The turning points in the summer are essentially the same. The peak in the precipitation curve to the right matches what we noted earlier in the graph of mean precipitation.