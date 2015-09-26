#Getting and Cleaning Data Course Project
#Brad Dietz

filename <- "getdata_dataset.zip" 

#Download the dataset if it does not exist
if (!file.exists(filename)){ 
   fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
   download.file(fileURL, filename) 
}   

#Unzip the dataset if it does not exist
if (!file.exists("UCI HAR Dataset")) {  
   unzip(filename)  
} 

#Load Labels
features <- read.table("UCI HAR Dataset/features.txt")
column_names <- features[,2]
activity <- read.table("UCI HAR Dataset/activity_labels.txt")

#Load the training, subject, and activity sets
xtrain <- read.table("UCI HAR Dataset/train/x_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

#Rename the training columns
colnames(xtrain) <- column_names
colnames(subject_train) <- "subject"
colnames(ytrain) <- "activity"

#Bind the columns of the subject and activity data to the training data set 
xtrain <- cbind(xtrain, subject_train)
xtrain <- cbind(xtrain, ytrain)

#Remove unecessary data
rm(subject_train)
rm(ytrain)
rm(features)

#Load the testing, subject and activity sets
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

#Rename the testing columns
colnames(xtest) <- column_names
colnames(subject_test) <- "subject"
colnames(ytest) <- "activity"

#Bind the columns of the subject and activity data to the testing data set 
xtest <- cbind(xtest, subject_test)
xtest <- cbind(xtest, ytest)

#Remove unecessary data
rm(subject_test)
rm(ytest)
rm(column_names)

#Bind the rows of the training and testing data sets
full <- rbind(xtrain, xtest)

#Remove unecessary data
rm(xtest)
rm(xtrain)

#Keep only the std, mean, subject, and activity columns
full <- full[, grepl("mean\\(\\)|std\\(\\)|subject|activity", names(full))]

#Label the activity column with the descriptive variable names
full <- merge(x=full, y=activity, by.x = c("activity"), by.y = c("V1"), all.x=TRUE)
full <- full[,2:69]

colnames(full)[68] <- "activity"

#Creates an independent tidy data set with the average of each variable for each activity and each subject
library(plyr)
column_averages <- ddply(full, .(subject, activity), function(x) colMeans(x[,1:66]))

#Create a text file of the averages data set
write.table(column_averages, "column_averages.txt", row.name=FALSE)