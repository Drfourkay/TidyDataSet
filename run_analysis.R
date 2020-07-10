### 1. Output Steps - Creation of the data set of training and test
#This code reads the training data tables - xtrain / ytrain, subject train
xtrdt = read.table(file.path(pathdata, "train", "X_train.txt"),header = FALSE)
ytrdt = read.table(file.path(pathdata, "train", "y_train.txt"),header = FALSE)
subtrdt = read.table(file.path(pathdata, "train", "subject_train.txt"),header = FALSE)
#######
#This code reads the test data tables
xtestdt = read.table(file.path(pathdata, "test", "X_test.txt"),header = FALSE)
ytestdt = read.table(file.path(pathdata, "test", "y_test.txt"),header = FALSE)
subtestdt = read.table(file.path(pathdata, "test", "subject_test.txt"),header = FALSE)
#This code reads the features data
featdt = read.table(file.path(pathdata, "features.txt"),header = FALSE)
#This code reads the activity labels data
actlabels = read.table(file.path(pathdata, "activity_labels.txt"),header = FALSE)
#######
#This code creates sanity and Column Values to the Training Data
colnames(xtrdt) = features[,2]
colnames(ytrdt) = "actId"
colnames(subtrdt) = "subId"
#This code creates sanity and column values to the Test data
colnames(xtestdt) = features[,2]
colnames(ytestdt) = "actId"
colnames(subtestdt) = "subId"
#This code confirms sanity check for the activity labels value
colnames(actlabels) <- c('actId','actType')
#######
#The following code merges the training and test data 
mgrtrdt = cbind(ytrdt, subtrdt, xtrdt)
mgrtestdt = cbind(ytestdt, subtestdt, xtestdt)
#This code creates the main data table
trntest1 = rbind(mgrtrdt, mgrtestdt)
#######
# This code reads all the values that are available
colNames = colnames(trntest1)
#To get a subset of all the mean and standards and the correspondongin activityID and subjectID 
xbarnsd = (grepl("actId" , colNames) | grepl("subId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))
#Creating a subset to get the required dataset
xbarnsddt <- trntest1[ , mean_and_std == TRUE]
#######
dtwithactnames = merge(xbarnsddt, actlabels, by='actId', all.x=TRUE)
#######
# This code crates tidy data set 
tidydt <- aggregate(. ~subId + actId, dtwithactnames, mean)
tidydt <- tidydt[order(tidydt$subId, tidydt$actId),]
#for Saving the data 
write.table(tidydt, "tidydt.txt", row.name=FALSE)
