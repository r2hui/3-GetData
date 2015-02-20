setwd("C:/Users/Christina2/Documents/Data Science/3 - Get Data/Course Project/UCI HAR Dataset")

## Load all text files, including column names

features <- read.table('./features.txt')
activity_labels <- read.table('./activity_labels.txt')

X_train <- read.table('./train/X_train.txt', col.names=features$V2)
y_train <- read.table('./train/y_train.txt')
subject_train <- read.table('./train/subject_train.txt')

X_test <- read.table('./test/X_test.txt', col.names=features$V2)
y_test <- read.table('./test/y_test.txt')

subject_test <- read.table('./test/subject_test.txt')

## Add subject data to table

X_test <- cbind(X_test,subject_test)
X_train <- cbind(X_train,subject_train)

## Add activity data to table

X_test <- cbind(X_test,y_test)
X_train <- cbind(X_train,y_train)

## Add subject and activity column names

names(X_test)[562] <- "subject"
names(X_train)[562] <- "subject"
names(X_test)[563] <- "activity"
names(X_train)[563] <- "activity"

## Combine test and train sets

DS <- rbind(X_train, X_test)

## Extract only mean and standard deviation data

DataSetMeanStd <- data.frame(DS[562],DS[563],DS[201],DS[202],DS[214],
DS[215],DS[227],DS[228],DS[240],DS[241],DS[253],DS[254],DS[503],
DS[504],DS[516],DS[517],DS[529],DS[530],DS[542],DS[543])

## Add activity descriptions, instead of integer

for (i in 1:6)
{
DataSetMeanStd$activity <- gsub(i,activity_labels[i,2],DataSetMeanStd$activity)
}

## Shorten measurement descriptions, using substrRight.r function

shortlist <- lapply(colnames(DataSetMeanStd[3:20]), substrRight)
names(DataSetMeanStd)[3:20] <- shortlist

## Melt and Cast, to find average for every subject and for every activity

dataMelt <- melt.data.frame(DataSetMeanStd,id.vars=c("subject","activity"))
final <- dcast(dataMelt, subject + activity ~ colnames(DataSetMeanStd)[3:20], mean)

## Create text file for submission

write.table(final, file="final.txt", row.name=FALSE)
