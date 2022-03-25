## Code done in RStudio during Data Analysis class

### 1-10-22
- Some basic R code
- load("county.rda"), summary(), str()
- library(dplyr), glimpse()

### 1-12-22
- Experimenting with a R Markdown file

### 1-19-22
- Overview of some things we'll learn in this course
- load("cdc.Rdata"), str(), summary()
- Add new variables/columns to the dataset, table()
- Look for/remove anomalies from the dataset
- library(ggplot2) for box plot, scatter plot, linear model lm()
- library(dplyr) for piping %>%
- head(), tail()

### 1-21-22
- All about factors
- Create a simple dataframe with vectors, turn one of the vector columns into a factor
- Rename vector values, sort them in a different order, levels(), labels()
- Create a smaller data frame from the existing larger data frame
- table(), as.numeric(), as.character()

### 1-24-22
- All about logical values
- Counts and proportions with a vector of numerical values
- Dealing with NA values, is.na()
- Truth tables
- Using vectors instead of for-loops
- Replicate function rep()

### 1-26-22
- All about functions
- Create your own functions
- Random number generator rnorm(), range(), quantile()

### 1-31-22
- Packages tidyverse/ggplot2/dplyr
- load("county.rda"), read_csv("UNRATE.csv"), load("cdc.Rdata")
- scatter plot, geom_jitter, line graph, histogram, box plot, bar plot

### 2-2-22
- Packages tidyverse/dplyr
- load("cdc.Rdata"), load("county.rda")
- Remove a column with select(-col_name)
- head(), tail(), table(), group_by(), summarize(), ungroup(), is.na(), drop_na(), save(variable_name, file = "file_name.Rdata") 

### 2-7-22
- Packages tidyverse/ggplot2
- load("county_clean.Rdata"), read_csv("state_region.csv")
- scatter plot, geom_smooth, geom_jitter, labs() for axis labels, left_join(), bar plot

### 2-9-22
- Packages tidyverse/ggplot2
- load("county_clean.Rdata"), read_csv("state_region.csv")
- left_join, scatter plot, geom_jitter, geom_count, Cleveland style visual, bar plot, coord_flip(), group_by(), summarize(), ungroup(), geom_col, histogram, scale_x_log10

### 2-11-22
- Packages tidyverse/ggplot2
- load("county_clean.Rdata"), read_csv("state_region.csv")
- left_join, histogram, geom_histogram(aes(y = ..density..)), geom_density(), geom_rug(), facet_wrap()

### 2-14-22
- Packages tidyverse/readr/lubridate/ggplot2
- Examines Olympia weather
- Import csv file and change a column name at the same time: read_csv("file_name.csv", col_types = cols(DATE = col_character()))
- as.Date(), is.na(), drop_na(), a couple plots
- year(), month() and day() to create factor variables yr, mo, and dy with mutate()
- save(variable_name, file = "file_name.Rdata") 

### 2-16-22, 2-18-22, 2-23-22, 2-25-22
- Packages tidyverse/lubridate/plotly
- load("oly_airport.Rdata")
- Uses dplyr/ggplot2/plotly functions to examine the data

### 2-28-22
- Packages tidyverse/plotly
- Examines fertility data in the US; uses read_delim() to get data from txt file; uses rbind() to combine two txt files
- Manipulates the dataframe variables to show what we want
- Uses dplyr/ggplot2/plotly functions to examine the data

### 3-4-22
- Packages tidyverse/plotly
- load("race_region_0320.Rdata") - fertility rates by race and region of US
- Uses dplyr/ggplot2/plotly functions to examine the data

### 3-14-22
- Packages tidyverse/plotly
- load("Gender.Rdata") - male vs female birth rates
- Uses dplyr/ggplot2 functions to examine the data
- Includes pivot_wider() to create new columns, rename() and mutate() to clean up the dataframe

### 3-16-22
- Packages tidyverse/plotly
- read_table() for Human Mortality dataset
- Cleans up data and makes two scatterplots

### 3-18-22
- Packages tidyverse/plotly
- load("USA_CAN.Rdata") for Human Mortality dataset
- Scatterplots

### 3-23-22
- Packages tidyverse/rtweet/httpuv
- Includes search_tweets(), get_timeline(), lookup_users(), table(), sort(), create table with tidyverse code

### 3-25-22
- Packages 
- 