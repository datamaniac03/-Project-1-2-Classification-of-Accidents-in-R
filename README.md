# Academic Project-1&2-Classification-of-Accidents-in-R

This is a part of a consulting project given by Tata Steel to Industrial Engineering Dept. IIT Kharagpur to analyse the huge textual data related to the accidents that occured or did not occur in the past 4 years. 
There are two types of input text csv files, 

1. Description of event where accident actually occured. 
2. Description of event where accident could have happened, but was missed due to precautions.

The desciption tells us about the environmental factors responsible for the hazard and the target human.

All of the coding work is fulfilled using R programming language. the code is rather simple with the use of available libraries to handle the textual data.


PS. this is the first ever project related to data analytics. So, I had no prior experience in this task beforehand.

#  Task Summary

1. Input the data files and make the text corpus.
2. Implement prediction models to forecast the chances of accidents to happen for testing dataset (description).
3. Further predict the class (or category) of accident (eg. Slip/Fall/ Fire Explosion/ Leakage etc.)


#  Process Flow

1. the data files are read and coverted to Text Corpus using TM library in R.
2. after the creation of Term Document Matrix with mormalized TF-IDF, the data features with less frequency are removed to reduce the sparcity of data.
3. Applied the following Machine Learning Models for the classification process of accidents and non accidents.
i. KNN
ii. Random Forest.
iii. SVM.
iv. Maximum Entropy.

4.  Next the results were concluded using the Confusion Matrix, with which we get the accuracy, precision, recall and F score. Moreover ROC is also built in each case.

#  Honest Flaw in the Approach

Since, I was a newbie at that time, I didn't know anything about Word2Vec or ngram. etc topics or parameter tuning of classifiers, the accuracy was not high. 
