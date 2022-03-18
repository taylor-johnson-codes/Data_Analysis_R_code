# slide deck: HMD-Human Mortality Database 2

library(tidyverse)
library(plotly)


# SEE SLIDES 1-17 LEADING UP TO THIS DATASET


load("USA_CAN.Rdata")

# qxm is the death rate for males; qxf is for females
glimpse(USA_CAN)
summary(USA_CAN)
str(USA_CAN)

# Infant Mortality USA and Canada
# Create this graph beginning in 1940.
USA_CAN %>% 
  filter(Age == 0 & Year > 1940) %>% 
  ggplot(aes(x = Year, y = qxm, color = country)) +
  geom_point() +
  ggtitle("Male Infant Mortality - USA and Canada")

# Create a graph comparing USA and Canadian mortality at age 79.
USA_CAN %>% 
  filter(Age == 79 & Year > 1940) %>% 
  ggplot(aes(x = Year, y = qxm, color = country)) +
  geom_point() +
  ggtitle("Age 75 Male Mortality - USA and Canada")

# Male and Female Death Rates at Age 21
g1 = USA_CAN %>% 
  filter(Age == 21) %>% 
  ggplot((aes(x = Year))) +
  geom_point(aes(y = qxm), color = "blue") +
  geom_point(aes(y = qxf), color = "red") +
  facet_wrap(~country)

ggplotly(g1)

# Ratio at Age 21 USA and Canada
g2 = USA_CAN %>% 
  filter(Age == 21) %>% 
  mutate(Ratio = qxm/qxf) %>% 
  ggplot(aes(x = Year, y = Ratio, color = country)) +
  geom_point() 

ggplotly(g2)