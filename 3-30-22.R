# slide deck: Twitter 4

library(tidyverse)
library(plotly)
library(rtweet)
library(httpuv)
library(qdapRegex)
library(tm)
library(qdap)
library(wordcloud)
library(RColorBrewer)

# Today’s Task
# I want to take the code snippets in the third chapter of the Datacamp course and construct usable code to perform similar tasks easily.
# Combine all of the code beginning with the specification of a search term and the number of tweets to the point where we have termfreq and twt_corpus_final. Display the termfreq.

twts = search_tweets("Ukraine", 2000, lang = "en") %>% 
  filter(is.na(reply_to_screen_name) &
           is_retweet == FALSE &
           is_quote == FALSE)

twt_txt = twts$text

# Remove URLs from the tweet
twt_txt_url <- rm_twitter_url(twt_txt)

# Replace special characters, punctuation, & numbers with spaces
twt_txt_chrs <- gsub("[^A-Za-z]", " ", twt_txt_url)

# Convert text in "twt_gsub" dataset to a text corpus and view output
twt_corpus <- twt_txt_chrs %>% 
  VectorSource() %>% 
  Corpus() 

# Convert the corpus to lowercase
twt_corpus_lwr <- tm_map(twt_corpus, tolower) 

# Remove English stop words from the corpus and view the corpus
twt_corpus_stpwd <- tm_map(twt_corpus_lwr, removeWords, stopwords("english"))

# Remove additional spaces from the corpus
twt_corpus_final <- tm_map(twt_corpus_stpwd, stripWhitespace)

termfreq <- freq_terms(twt_corpus_final, 60)

termfreq

# Create a list of custom stopwords and produce a barplot of the 10 most common words.

# Create a vector of custom stop words
custom_stopwds <- c("ukraine", " s", "amp", "can", 't')

# Remove custom stop words and create a refined corpus
corp_refined <- tm_map(twt_corpus_final,removeWords, custom_stopwds) 

# Extract term frequencies for the top 20 words
termfreq_clean <- freq_terms(corp_refined, 20)

# Extract term frequencies for the top 10 words
termfreq_10w <- freq_terms(corp_refined, 10)

termfreq_10w

# Identify terms with more than 60 counts from the top 10 list
term60 <- subset(termfreq_10w, FREQ > 60)

# Create a bar plot using terms with more than 60 counts
ggplot(term60, aes(x = reorder(WORD, -FREQ), y = FREQ)) + 
  geom_bar(stat = "identity", fill = "red") + 
  theme(axis.text.x = element_text(angle = 15, hjust = 1))

# Create a few wordclouds.
# Create a word cloud in red with min frequency of 20
wordcloud(corp_refined, min.freq = 20, colors = "red", 
          scale = c(3, 0.5),random.order = FALSE)

# Create word cloud with 6 colors and max 50 words
wordcloud(corp_refined, max.words = 50, 
          colors = brewer.pal(6, "Dark2"), 
          scale=c(4, 1), random.order = FALSE)