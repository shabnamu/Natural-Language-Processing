#Import essential libraries
library(syuzhet)
library(tm)
library(wordcloud)
library(stringr)

#import dataset
data = read.csv("twitter.csv", header = FALSE)
dim(data)
View(data)
table(data$V1)
table(data$V4)

summary(data)

data_new = dplyr::select(data,1,5,6)
summary(data_new)

colnames(data_new) = c("label","username","tweet")
str(data_new)

#data cleaning
data_new$label = ifelse(data_new$label == 4,1,0)
table(data_new$label)

data_new$label = factor(data_new$label)
summary(data_new)

data_new_1 = data_new[sample(nrow(data_new),5000),]
dim(data_new_1)
table(data_new_1$label)

tweet = data_new_1$tweet
tweet = tolower(tweet)
tweet <- gsub("rt", "", tweet)
tweet <- gsub("@\\w+", "", tweet)
tweet <- gsub("[[:punct:]]", "", tweet)
tweet <- gsub("http\\w+", "", tweet)
tweet <- gsub("[ |\t]{2,}", "", tweet)
tweet <- gsub("^ ", "", tweet)
tweet <- gsub(" $", "", tweet)

#create corpus
tweet_corpus <- Corpus(VectorSource(tweet))
tweet_corpus <- tm_map(tweet_corpus, function(x)removeWords(x,stopwords()))

wordcloud(tweet_corpus,min.freq = 10,colors=brewer.pal(8, "Dark2"),random.color = TRUE,max.words = 500)

mysentiment<-get_nrc_sentiment((tweet))
mysentiment

tweet_sentiment<-data.frame(colSums(mysentiment[,]))
View(tweet_sentiment)
names(tweet_sentiment) = "Count"
tweet_sentiment<-cbind("sentiment"=rownames(tweet_sentiment),tweet_sentiment)
rownames(tweet_sentiment)<-NULL

ggplot(data=tweet_sentiment,aes(x=sentiment,y=Count))+
  geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("Counts")+ggtitle("Sentiments Vs Count of Tweets")

