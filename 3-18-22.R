# slide deck: HMD-Human Mortality Database 2
# data from: https://www.mortality.org/
# zipped data files on left, Life Tables for Male/Female/Both Sexes, register and get account to get the data file
# gives you one txt file for each country, pick USA file (data goes back to 1933)

library(tidyverse)
library(plotly)

# Load the data for USA males into the dataframe USAM. Add a variable country and set it to “USA”. 
# Change the name of qx to qxm. Select country, Year, Age and qxm.
# Make Age numeric. Eliminate any missing data.

# Note: Was given USA_CAN.Rdata file later on in code

USAM <- read_table("/Users/haroldnelson/Dropbox/HMD/lt_male/mltper_1x1/USA.mltper_1x1.txt", skip = 2) %>% 
  mutate(country = "USA") %>% 
  rename(qxm = qx) %>% 
  select(country, Year, Age, qxm) %>% 
  mutate(Age = as.numeric(Age)) %>% 
  drop_na()

# Male Infant Mortality
g1 = USAM %>% 
  filter(Age == 0) %>% 
  ggplot(aes(x = Year, y = qxm)) +
  geom_point()

ggplotly(g1)

# Male Aged Probability of Death
g2 = USAM %>% 
  filter(Age == 75) %>% 
  ggplot(aes(x = Year, y = qxm)) +
  geom_point()

ggplotly(g2)

# Load the data for USA females into the dataframe USAF. Add a variable country and set it to “USA”. 
# Change the name of qx to qxf Select country, Year, Age and qxf.
# Make Age numeric. Eliminate any missing data.

USAF <- read_table("/Users/haroldnelson/Dropbox/HMD/lt_female/fltper_1x1/USA.fltper_1x1.txt", skip = 2) %>% 
  mutate(country = "USA") %>% 
  rename(qxf = qx) %>% 
  select(country, Year, Age, qxf) %>% 
  mutate(Age = as.numeric(Age)) %>% 
  drop_na()

# Join USAM and USAF into USA
USA = USAM %>% 
  inner_join(USAF)

head(USA)

# Look at Ratio
g3 = USA %>% 
  filter(Age == 21) %>% 
  mutate(Ratio = qxm/qxf) %>% 
  ggplot(aes(x = Year, y = Ratio)) +
  geom_point()

ggplotly(g3)

# Male and Female Death Rates at Age 21
g4 = USA %>% 
  filter(Age == 21) %>% 
  ggplot((aes(x = Year))) +
  geom_point(aes(y = qxm), color = "blue") +
  geom_point(aes(y = qxf), color = "red")

ggplotly(g4)

# Do the same for Canada.
CANM <- read_table("/Users/haroldnelson/Dropbox/HMD/lt_male/mltper_1x1/CAN.mltper_1x1.txt", skip = 2) %>% 
  mutate(country = "Canada") %>% 
  rename(qxm = qx) %>% 
  select(country, Year, Age, qxm) %>% 
  mutate(Age = as.numeric(Age)) %>% 
  drop_na()

CANF <- read_table("/Users/haroldnelson/Dropbox/HMD/lt_female/fltper_1x1/CAN.fltper_1x1.txt", skip = 2) %>% 
  mutate(country = "Canada") %>% 
  rename(qxf = qx) %>% 
  select(country, Year, Age, qxf) %>% 
  mutate(Age = as.numeric(Age)) %>% 
  drop_na()

CAN = CANM %>% 
  inner_join(CANF)

head(CAN)

USA_CAN = rbind(USA, CAN)

str(USA_CAN)



load("USA_CAN.Rdata")

# qxm is the death rate for males; qxf is for females
glimpse(USA_CAN)
summary(USA_CAN)
str(USA_CAN)

# Infant Mortality USA and Canada
# Create this graph beginning in 1940.
USA_CAN %>% 
  filter(Age == 0 & Year >= 1940) %>% 
  ggplot(aes(x = Year, y = qxm, color = country)) +
  geom_point() +
  ggtitle("Male Infant Mortality - USA and Canada")

# Create a graph comparing USA and Canadian mortality at age 79.
USA_CAN %>% 
  filter(Age == 79 & Year >= 1940) %>% 
  ggplot(aes(x = Year, y = qxm, color = country)) +
  geom_point() +
  ggtitle("Age 75 Male Mortality - USA and Canada")

# Male and Female Death Rates at Age 21
g5 = USA_CAN %>% 
  filter(Age == 21) %>% 
  ggplot((aes(x = Year))) +
  geom_point(aes(y = qxm), color = "blue") +
  geom_point(aes(y = qxf), color = "red") +
  facet_wrap(~country)

ggplotly(g5)

# Ratio at Age 21 USA and Canada
g6 = USA_CAN %>% 
  filter(Age == 21) %>% 
  mutate(Ratio = qxm/qxf) %>% 
  ggplot(aes(x = Year, y = Ratio, color = country)) +
  geom_point() 

ggplotly(g6)