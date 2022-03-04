# Slide deck: Fertility 3

library(tidyverse)
library(plotly)
load("race_region_0320.Rdata")  # fertility rates by race and region of US
glimpse(race_region_0320)
head(race_region_0320)

# Region = `Census Region Code` - I think this is US regions NE, MW, SO, WE
# Race = `Mother's Bridged Race`
# Age = `Age of Mother 9 Code`
# Fpop = `Female Population`
# Rate = `Fertility Rate`
# AmInd = American Indian or Alaska Native
# API = Asian or Pacific Islander
# Black = Black or African American

# Plot the yearly Rate for age group 25-29 in a grid by Race and Region.
race_region_0320 %>% 
  filter(Age == "25-29") %>% 
  ggplot(aes(x = Year, y = Rate)) +
  geom_point() +
  facet_grid(Race~Region) +
  ggtitle("TS Plot of Rate for 25-29 by Race and Region")

# Flip the Grid
race_region_0320 %>% 
  filter(Age == "25-29") %>% 
  ggplot(aes(x = Year, y = Rate)) +
  geom_point() +
  facet_grid(Region~Race) +
  ggtitle("TS Plot of Rate for 25-29 by Race and Region")

# Create a plot showing the TFR for the whole country by Race.
g1 = race_region_0320 %>% 
  group_by(Year, Race, Age) %>% 
  summarize(Births = sum(Births),
            Fpop = sum(Fpop)) %>% 
  mutate(Rate = Births/Fpop)%>% 
  summarize(TFR = sum(Rate) * 5) %>% 
  ungroup() %>% 
  ggplot(aes(x = Year, y = TFR, color = Race)) +
  geom_point() + 
  ggtitle("National TFR by Year and Race")

ggplotly(g1)

# Create a plot showing the TFR by Race and Region. Use plotly.
g2 = race_region_0320 %>% 
  group_by(Year, Region, Race, Age) %>% 
  summarize(Births = sum(Births),
            Fpop = sum(Fpop)) %>% 
  mutate(Rate = Births/Fpop)%>% 
  summarize(TFR = sum(Rate) * 5) %>% 
  ungroup() %>% 
  ggplot(aes(x = Year, y = TFR, color = Race)) +
  geom_point() +
  facet_grid(Race~Region) + 
  ggtitle("Regional TFR by Year and Race")

ggplotly(g2)

# Can we trust this data? The numerators come from birth certificates. The denominators come from the census.
# Is it possible that some women report themselves as native americans on the census and report themselves as some other race when they give birth?
# This is a constant problem with statistical analysis of data involving race.

# https://www.cnn.com/2021/08/19/us/census-native-americans-rise-population/index.html#:~:text=In%202020%2C%20the%20number%20of,according%20to%20the%20Census%20Bureau.
# this article suggests the census counters didn't do a good job