install.packages("tm")
install.packages("stringr")  #to perform string operations
install.packages("wordcloud") #use to plot cloud with most frequent word - represent TF -term frequency


library(tm)
library(wordcloud)
library(stringr)

# aa<-readLines("MrModi_Speech_IndependenceDay_20171.txt")
# aa

text<-paste(readLines("MrModi_Speech_IndependenceDay_20171.txt"),collapse = " ")  #remove space and keep adding lines
text

#change to lower case as R is case sensitive
text<-tolower(text)
text

#remove stopwords
print(stopwords())

text2<-removeWords(text,stopwords())
text2

#to remove specific words
# text2<-removeWords(text,"word"))

# split document based on spaces - this will give words
bag_of_word1<-str_split(text2," ")
bag_of_word1

str(bag_of_word1)
# List of 1           - output in form of list
# $ : chr [1:5627] "" "dear" "fellow" "citizens," ...

#to build word cloud we need to unlist the bag_of_word1

bag_of_word1<-unlist(bag_of_word1)
str(bag_of_word1)


wordcloud(bag_of_word1,min.freq = 10)

#same on demonitisation speech - 
text1<-paste(readLines("Modi_Speech_Demonitisation.txt"),collapse = " ")  #remove space and keep adding lines
text1

text1<-tolower(text1)

text3<-removeWords(text1,stopwords())
text3
text4<-removeWords(text3,"will")


bag_of_word2<-str_split(text4," ")
bag_of_word2

str(bag_of_word2)
bag_of_word2<-unlist(bag_of_word2)
str(bag_of_word2)


wordcloud(bag_of_word2,min.freq = 5)
