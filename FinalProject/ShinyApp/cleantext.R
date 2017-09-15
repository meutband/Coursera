
suppressPackageStartupMessages(c(library(magrittr),library(data.table),library(RWeka),
                                 library(tm),library(RSQLite)))

# Import the txt files
twitter <- samplefile('/Users/meutband/Desktop/Coursera/DataScienceSpecialization/10Capstone/data/en_US/en_US.twitter.txt', .013)
blogs <- samplefile('/Users/meutband/Desktop/Coursera/DataScienceSpecialization/10Capstone/data/en_US/en_US.blogs.txt', .013)
news <- samplefile('/Users/meutband/Desktop/Coursera/DataScienceSpecialization/10Capstone/data/en_US/en_US.news.txt', .013)

# Create corpus of the documents; remove whitespace, stopwords, punctuation, numbers.
getCorpus <- function(v) {
  corpus <- VCorpus(VectorSource(v))
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, content_transformer(tolower))
  corpus <- tm_map(corpus, removeWords, stopwords("english"))
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, removeNumbers)
  corpus 
}  

# Add spaces before and after punctuation, remove repeat spaces, and split the strings
tokenize <- function(v) {
  gsub("([^ ])([.?!&])", "\\1 \\2 ", v)   %>%
    gsub(pattern=" +", replacement=" ")     %>%
    strsplit(split=" ") %>%
    unlist
}

# Takes tm TermDocumentMatrix and processes into frequency data.table
tdmToFreq <- function(tdm) {
  freq <- sort(row_sums(tdm, na.rm=TRUE), decreasing=TRUE)
  word <- names(freq)
  data.table(word=word, freq=freq)
}

# Add to n-gram data.table pre (before word) and cur (word itself)
processGram <- function(dt) {
  dt[, c("pre", "cur"):=list(unlist(strsplit(word, "[ ]+?[a-z]+$")), 
                             unlist(strsplit(word, "^([a-z]+[ ])+"))[2]), by=word]
}

bulk_insert <- function(sql, key_counts)
{
  dbBegin(db)
  dbGetPreparedQuery(db, sql, bind.data = key_counts)
  dbCommit(db)
}

BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
TrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
QuadgramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))

twit <- getCorpus(twitter)
blog <- getCorpus(blogs)
new <- getCorpus(news)

tdm_2 <- TermDocumentMatrix(c(twit, blog, new), control = list(tokenize = BigramTokenizer)) 
tdm_3 <- TermDocumentMatrix(c(twit, blog, new), control = list(tokenize = TrigramTokenizer))
tdm_4 <- TermDocumentMatrix(c(twit, blog, new), control = list(tokenize = QuadgramTokenizer))

db <- dbConnect(SQLite(), dbname="alldata.db")
dbSendQuery(conn=db, 
            "CREATE TABLE NGram 
            (pre TEXT, 
            word TEXT,
            freq INTEGER, 
            n INTEGER)")

# Get word frequencies
freq_4 <- tdmToFreq(tdm_4)
freq_3 <- tdmToFreq(tdm_3)
freq_2 <- tdmToFreq(tdm_2)

# Process with pre and current word
processGram(freq_4)
processGram(freq_3)
processGram(freq_2)

# Insert into SQLite database
bulk_insert("INSERT INTO NGram VALUES ($pre, $cur, $freq, 4)", freq_4)
bulk_insert("INSERT INTO NGram VALUES ($pre, $cur, $freq, 3)", freq_3)
bulk_insert("INSERT INTO NGram VALUES ($pre, $cur, $freq, 2)", freq_2)

dbDisconnect(db)