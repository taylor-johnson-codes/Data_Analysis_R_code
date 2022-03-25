# slide deck: HMD-Human Mortality Database 1
# data from: https://www.mortality.org/
# zipped data files on left, Life Tables for Male/Female/Both Sexes, register and get account to get the data file
# gives you one txt file for each country, pick USA file (data goes back to 1933)

library(tidyverse)
library(plotly)

# Load the data for USA males. Add a variable country and set it to “USA”.
# Select country, Year, Age and qx (probability of dying within the following year).
# Make Age numeric. Eliminate any missing data.

USA <- read_table("~/Dropbox/HMD/lt_male/mltper_1x1/USA.mltper_1x1.txt", skip = 2) %>% 
  mutate(country = "USA") %>% 
  select(country, Year, Age, qx) %>% 
  mutate(Age = as.numeric(Age)) %>% 
  drop_na()

# Do the same for Canada.
CAN <- read_table("~/Dropbox/HMD/lt_male/mltper_1x1/CAN.mltper_1x1.txt", skip = 2) %>% 
  mutate(country = "Canada") %>% 
  select(country, Year, Age, qx) %>% 
  mutate(Age = as.numeric(Age)) %>% 
  drop_na()

# Combine the two dataframes into USA_CAN using rbind().
USA_CAN = rbind(USA, CAN)

# Infant Mortality USA and Canada
# Create this graph beginning in 1940.
USA_CAN %>% 
  filter(Age == 0 & Year > 1940) %>% 
  ggplot(aes(x = Year, y = qx, color = country)) +
  geom_point() +
  ggtitle("Male Infant Mortality - USA and Canada")

# Create a graph comparing USA and Canadian mortality at age 79.
USA_CAN %>% 
  filter(Age == 79 & Year > 1940) %>% 
  ggplot(aes(x = Year, y = qx, color = country)) +
  geom_point() +
  ggtitle("Age 75 Male Mortality - USA and Canada")