# Slide deck: Fertility 1
# data retrieved from https://wonder.cdc.gov/natality.html
#      steps to retrieve: click 2003-2006 link; in 3 drop-downs select state, age of mother 9, year; check fertility rate; click in box to select all states; 
#      click in box to select all years; uncheck show totals; check export results; send
# video on how to retrieve: https://www.youtube.com/watch?v=Oiw7bm4GjvQ
# two other sites for fertility data: https://www.populationpyramid.net/ and https://data.worldbank.org/indicator/SP.DYN.TFRT.IN 

library(tidyverse)
library(plotly)

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


# Slide deck: Fertility 2

# Make a graph showing the total number of births per year.
g1 = by_state_0320 %>% 
  group_by(Year) %>% 
  summarise(Total_births = sum(Births)) %>% 
  ggplot(aes(x = Year, y = Total_births)) +
  geom_point() +
  ggtitle("Total Births by Year")

ggplotly(g1)

# It is somewhat surprising that the total number of births in the US has declined. Has the number of women been declining in this time period
# Redo the previous dataframe and include the total number of women. Also compute the ratio of births to women. Print this dataframe so we can see all three variables.
births_by_year = by_state_0320 %>% 
  group_by (Year) %>% 
  summarize(total_births = sum(Births),total_women = sum(Fpop)) %>%
  mutate(ratio = total_births/total_women)

births_by_year

# The total fertility rate is the number of births for a woman during her lifetime. The rate data we have is the number of births per woman per year while she is in one of the 5-year age groups. 
# How do we use the rate information to construct the TFR. Do this for the State of Washington. Plot the time-series using plotly.
g2 = by_state_0320 %>% 
  filter(State == "Washington") %>% 
  group_by(Year) %>% 
  summarize(TFR = sum(Rate) * 5) %>% 
  ungroup %>% 
  ggplot(aes(x = Year, y = TFR)) +
  geom_point()

ggplotly(g2)

# Repeat the exercise for all states. Again, use plotly so we will be able to identify states. In the aes(), add “group = State”. Also draw a red horizontal line at 2.1.
g3 = by_state_0320 %>% 
  group_by(State, Year) %>% 
  summarize(TFR = sum(Rate) * 5) %>% 
  ungroup() %>% 
  ggplot(aes(x = Year, y = TFR, group = State)) +
  geom_point(size = .2) +
  geom_hline(aes(yintercept = 2.1), color = "red")  

ggplotly(g3)
# shows states above and below the 2.1 line
# need 2.0 babies to stabilize the population (one to replace man, one to replace woman)
# need 2.1 to account for death of babies and/or death of women

# Create a graph showing the TFR for the US as a whole. We can’t use the rate data directly. 
# We need to compute the total numbers of births and total numbers of women for each age group and year. Then compute the TFR by adding the calculated rates and multiplying by 5.
g4 = by_state_0320 %>% 
  group_by(Year, Age) %>% 
  summarize(Births = sum(Births), Fpop = sum(Fpop)) %>%
  mutate(Rate = Births/Fpop) %>% 
  summarize(TFR = sum(Rate) * 5) %>% 
  ungroup() %>% 
  ggplot(aes(x = Year, y = TFR)) +
  geom_point() +
  geom_hline(aes(yintercept = 2.1), color = "red")

ggplotly(g4)
# US fell below the replacement rate in 2008