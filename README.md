#Getting and Cleaning Data Course Project
##README.md
Brad Dietz

###Requirements: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###Setup:

1. Download the data source and put into a folder on your local drive. You'll have a UCI HAR Dataset folder.
2. Put run_analysis.R in the parent folder of UCI HAR Dataset, then set it as your working directory using setwd() function in RStudio.
3. Run source("run_analysis.R"), then it will generate a new file tiny_data.txt in your working directory.

###Using run_analysis.R:

1. Load run_analysis.R into R Studio
2. Set your working directory using setwd() function in Rstudio
3. Run the full script

###Dependencies:

1. Automatically downloads and unzips the dataset 
2. Automatically loads R library dependencies (plyr)

###run_analysis.R process:

1. Downloads and unzips the dataset if it does not already exist in the working directory
2. Load the column labels (activity and feature info)
3. Loads the training sets, changes the column names and binds the subject and activity columns to the base training set
4. Removes unnecessary training tables
5. Loads the testing sets, changes the column names and binds the subject and activity columns to the base testing set
6. Removes unnecessary testing tables
7. Creates a full dataset by binding the rows of the testing set to the training set
8. Removes training and testing sets
9. Keep only the std, mean, subject, and activity columns
10. Label the activity column with the descriptive variable names
11. Create an independent tidy data set with the average of each variable for each activity and each subject
12. Create a text file of the averages data set

The end result is shown in the file column_averages.txt.

