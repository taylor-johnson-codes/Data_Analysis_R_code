# Slide deck: Fertility 1
# data retrieved from https://wonder.cdc.gov/natality.html
# video on how to retrieve: https://www.youtube.com/watch?v=Oiw7bm4GjvQ

library(tidyverse)
library(plotly)
library(dplyr)

# birth data by state from 2003 through 2006
by_state_year_0306 <- read_delim("Natality, 2003-2006.txt", delim = "\t", escape_double = FALSE, trim_ws = TRUE)

glimpse(by_state_year_0306)

# birth data by state from 2007 through 2020
by_state_year_0720 <- read_delim("Natality, 2007-2020.txt", delim = "\t", escape_double = FALSE, trim_ws = TRUE)

glimpse(by_state_year_0720)

# Combine the two data frames into by_state_0320 using rbind().
by_state_0320 = rbind(by_state_year_0306,by_state_year_0720)

glimpse(by_state_0320)

# Edit the dataframe using dplyr. It should have the following variables:
# State
# Year
# Age (Contents of Age Code)
# Fpop (Renamed and made numeric using as.numeric())
# Births (made numeric using as.numeric())
# Rate (made numeric using as.numeric()). Divide by 1000 to get rates per person.
# Eliminate the District of Columbia.
# Drop rows with missing data.
# Use summary() to check your work.

by_state_0320 = by_state_0320 %>% 
  filter(State != "District of Columbia") %>% 
  select("State", "Year", Age = "Age of Mother 9 Code", Fpop = "Female Population", "Births", Rate = "Fertility Rate") %>%
  mutate(Fpop = as.numeric(Fpop),
         Births = as.numeric(Births),
         Rate = as.numeric(Rate)/1000) %>% 
  drop_na()

summary(by_state_0320)

# Lets’ look at the time-series of Rate for the state of Washington. Map color to Age. Use plotly.
g = by_state_0320 %>% 
  filter(State == "Washington") %>% 
  ggplot(aes(x = Year, y = Rate, color = Age)) +
  geom_point()

ggplotly(g)

# Compare the states Connecticut, Washington, and Utah for birth rates in the 25-29 group. Map color to State and use plotly.
g1 = by_state_0320 %>% 
  filter(State %in% c("Connecticut", "Washington", "Utah") & Age == "25-29") %>% 
  ggplot(aes(x = Year, y = Rate, color = State)) +
  geom_point() 

ggplotly(g1)