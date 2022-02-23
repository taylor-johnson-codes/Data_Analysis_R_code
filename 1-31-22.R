# FYI - TidyTuesday on GitHub has lots of datasets to play with

# Slide deck: The 5 Named Graphs

library(tidyverse)
library(ggplot2)
library(dplyr)

load("county.rda")
summary(county)

# Use the county dataframe. Make a scatterplot with poverty on the x-axis and pop_change on the y-axis.
ggplot(data = county, mapping = aes(x = poverty, y = pop_change)) + 
  geom_point()

# Reduce the value of alpha in geom_point() to solve the overplotting problem.
ggplot(data = county, mapping = aes(x = poverty, y = pop_change)) + geom_point(alpha = .2)

# Try using a reduced size (default = 1) instead of alpha.
ggplot(data = county, mapping = aes(x = poverty, y = pop_change)) + 
  geom_point(size = .1)

# Use geom_jitter() instead of geom_point() to solve the problem.
ggplot(data = county, mapping = aes(x = poverty, y = pop_change)) + 
  geom_jitter()

# Add a geom_smooth() layer.
ggplot(data = county, mapping = aes(x = poverty, y = pop_change)) + 
  geom_point(size = .2) + geom_smooth(color = "red")


# Download the file unrate.csv from Moodle and use the “Import Dataset” feature in the upper-right pane, Environment Tab, to get some recent unemployment rate data. Save the code in a chunk.
# In environment tab, Import Dateset, From Text (readr), Browse, select file, Import
# data/csv file came from FRED St. Louis Fed

UNRATE <- read_csv("UNRATE.csv")  # unemployment rate data
glimpse(UNRATE)

# Make a linegraph of the unemployment rate.
ggplot(data = UNRATE, 
       mapping = aes(x = DATE, y = UNRATE)) +
  geom_line()

# In the geom_line(), set linetype = “dotted”. Add a geom_point() layer.
# (Dr. Nelson's preferred line graph)
ggplot(data = UNRATE, 
       mapping = aes(x = DATE, y = UNRATE)) +
  geom_line(linetype = "dotted") +  # lines shows direction data is going
  geom_point()  # every dot represents a month


load("cdc.Rdata")
summary(cdc)

# Make a histogram of the variable weight in the cdc dataframe.
ggplot(data = cdc, mapping = aes(x = weight)) +
  geom_histogram()

# Try some different values of bins. The default is 30, so try 15 and 60.
ggplot(data = cdc, mapping = aes(x = weight)) +
  geom_histogram(bins = 15)

ggplot(data = cdc, mapping = aes(x = weight)) +
  geom_histogram(bins = 60)

# Use facetting to get separate histograms of the weights of men and women. Set nrow = 2.
ggplot(data = cdc, mapping = aes(x = weight)) +
  geom_histogram() +
  facet_wrap(~gender,nrow = 2)

# Do a side-by-side boxplot of the weights of men and women.
ggplot(data = cdc, mapping = aes(x = gender, y = weight)) +
  geom_boxplot()

# The boxplot command in ggplot2 requires an x-variable. The base R boxplot does not. If you want to use the ggplot version without an x-variable, you can supply a constant. I recommend a string containing the name of the variable.
ggplot(data = cdc, aes(x = "Weight", y = weight)) + 
  geom_boxplot()

# Create a barplot of gender in the cdc dataframe.
ggplot(data = cdc, aes(x = gender)) + geom_bar()

# The barplot geom does the counting of cases in raw data. If the counting has already been done, we use geom_col() instead.
cdc %>% 
  group_by(gender) %>% 
  summarize(count = n()) %>% 
  ggplot(aes(x = gender,y = count)) +
  geom_col()