# slide deck: Twitter 2

library(plyr)
library(rtweet)
library(httpuv)

# Original Tweets. Eliminate retweets, quotes, and replies.
# Here is the code from Datacamp. Note that I had to precede count() with plyr:: because there is also a count function in dplyr, which loaded later.

# Extract 100 original tweets on "Superbowl"
tweets_org <- search_tweets("Superbowl -filter:retweets -filter:quote -filter:replies", n = 100)

# Check for presence of replies
plyr::count(tweets_org$reply_to_screen_name)

# Check for presence of quotes
plyr::count(tweets_org$is_quote)

# Check for presence of retweets
plyr::count(tweets_org$is_retweet)

# How long did it take to get 100 tweets?
tweets_org %>% 
  summarize(max(created_at) - min(created_at))

# Put this all together with tidy coding practice. Start with the query for your term.
# Drop the internal filters and follow up using is.na() for reply_to_screen_name and == FALSE for the other two.
search_tweets("Superbowl", n = 100) %>% 
  filter(is.na(reply_to_screen_name) &
           is_retweet == FALSE &
           is_quote == FALSE) %>% 
  summarize(max(created_at) - min(created_at))

# Convert this code into a function with two parameters:
# Parameter 1: term. this is a string with the search term.
# Parameter 2: ntweets. This is the number of tweets.
# The function returns the amount of time required to get this number of tweets after eliminating non-original tweets. 
# Test your function with term = “superbowl” and ntweets = 100.
time_to_get <- function(term, ntweets){
  search_tweets(term, n = ntweets) %>% 
    filter(is.na(reply_to_screen_name) &
             is_retweet == FALSE &
             is_quote == FALSE) %>% 
    summarize(max(created_at) - min(created_at))
}

time_to_get("superbowl", 100)

# Use your function to compare the tweet rates of “rstats”, “pandas”, and “ukraine”. Use 100 for ntweets.
time_to_get("rstats", 100)
time_to_get("pandas", 100)
time_to_get("ukraine", 100)

# We have a boolean expression to identify original tweets. Use this to create a variable is_org using mutate. 
# Then use mean(is_org) in a summarize step to display the fraction of original tweets in query. 
# Test your code with the superbowl and 100 tweets. Try a few different terms.

search_tweets("superbowl", n = 100) %>% 
  mutate(is_orig = is.na(reply_to_screen_name) &
           is_retweet == FALSE &
           is_quote == FALSE) %>%
  summarize(mean(is_orig))

# Make Another Function
fract_original = function(term, ntweets){
  search_tweets(term, n = ntweets) %>% 
    mutate(is_orig = is.na(reply_to_screen_name) &
             is_retweet == FALSE &
             is_quote == FALSE) %>%
    summarize(mean(is_orig))
}

fract_original("superbowl", 100)

# Use your function to determine the fraction of original tweets for several topics that interest you.
fract_original("cutedogs", 100)
time_to_get("cutedogs", 100)

fract_original("dogs", 100)
time_to_get("dogs", 100)