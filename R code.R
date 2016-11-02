setwd("C:/Users/Vishal Lakha/Desktop/project")
library(httr)
set_config(use_proxy(url="10.3.100.207", port=8080))
library(tm)
library(class)
library(e1071)
library(wordcloud)
library(ggplot2)
library(ROCR)
require(graphics)
library(cluster)
library(fpc) 
library(factoextra)
library(caret)
library(pracma)
library(gmodels)
library(ROCR)
library(FSelector)
library(cvTools)
# install.packages("devtools")
# library(devtools)
# install_github("kassambara/factoextra")



#Pre-processing
library(tm)
reviews <- read.csv ("data for matrix.csv", stringsAsFactors=FALSE, header = F)
review_source <- VectorSource(reviews)
corpus <- Corpus(review_source)
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus=tm_map(corpus, function(x) removeWords(x, stopwords("english")))
corpus=tm_map(corpus, function(x) removeWords(x, stopwords("en")))
corpus=tm_map(corpus, function(x) removeWords(x, stopwords("SMART")))
corpus=tm_map(corpus, function(x) removeWords(x, stopwords("german")))
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, stemDocument, language="english")
#TF-IDF score
dtm = DocumentTermMatrix(corpus,control=list(bounds = list(global = c(18,Inf)), weighting = function(x) weightTfIdf(x, normalize = TRUE)))
dtm_matrix <- as.matrix(dtm)

#Frequency Matrix
frequency <- colSums(dtm_matrix)
frequency <- sort(frequency, decreasing=TRUE)
head(frequency)

#KNN CLASSIFICATION (K=5)
train<-dtm_matrix[1:4960,]
test<-dtm_matrix[4961:6611,]
prevdata<-read.csv("training classified.csv",header= F)$V1
prediction<-knn(train,test,cl=prevdata,k=5)
actual<-read.csv("testing classified.csv",header= F)$V1

prednew<-as.vector(prediction)
actnew<-as.vector(actual)


library(tm)
library(RTextTools)
dim(dtm_matrix)

container <- create_container(dtm_matrix, prevdata, trainSize=1:4960,testSize=4961:6611, virgin=T)

SVM <- train_model(container,"SVM")
MAXENT <- train_model(container,"MAXENT", l1_regularizer = 1,le_regularizer=1, use_sgd = T)
RF<-train_model(container,"RF")


SVM_CLASSIFY <- classify_model(container, SVM)
MAXENT_CLASSIFY <- classify_model(container, MAXENT)
RF_CLASSIFY <- classify_model(container, RF)

prednew1<-SVM_CLASSIFY$SVM_LABEL
prednew2<-MAXENT_CLASSIFY$MAXENTROPY_LABEL
prednew3<-RF_CLASSIFY$FORESTS_LABEL

cm<-confusionMatrix(prednew,actnew)
cm1<-confusionMatrix(prednew1,actnew)
cm2<-confusionMatrix(prednew2,actnew)
cm3<-confusionMatrix(prednew3,actnew)


library(pROC)
paste("auc knn",auc(as.ordered(actual),as.ordered(prediction)))
paste("auc svm",auc(as.ordered(actual),as.ordered(prednew1)))
paste("auc maxent",auc(as.ordered(actual),as.ordered(prednew2)))
paste("auc rf",auc(as.ordered(actual),as.ordered(prednew3)))

plot.roc(as.ordered(actual),as.ordered(prediction))

