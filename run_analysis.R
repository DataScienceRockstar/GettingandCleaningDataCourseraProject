#Create Date: 11/21/2019
#Created By: Nimesh Kuinkel


# CourseName: Getting and Cleaning Data  
#Project Coursera John Hopkins University


#Project Description : create one R script called run_analysis.R that does the following.

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



# File Download and Unzipping the file

library(data.table)
library(reshape2)


workingdirectory <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(workingdirectory, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")


# Load activity labels and features
activityLabels <- fread(file.path(workingdirectory, "UCI HAR Dataset/activity_labels.txt")
                        , col.names = c("classLabels", "activityName"))
features <- fread(file.path(workingdirectory, "UCI HAR Dataset/features.txt")
                  , col.names = c("index", "featureNames"))
wantedFeatures <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[wantedFeatures, featureNames]
measurements <- gsub('[()]', '', measurements)


# Loading train datasets
train <- fread(file.path(workingdirectory, "UCI HAR Dataset/train/X_train.txt"))[, wantedFeatures, with = FALSE]
data.table::setnames(train, colnames(train), measurements)
trainActivities <- fread(file.path(workingdirectory, "UCI HAR Dataset/train/Y_train.txt")
                         , col.names = c("Activity"))
trainSubjects <- fread(file.path(workingdirectory, "UCI HAR Dataset/train/subject_train.txt")
                       , col.names = c("SubjectNum"))
train <- cbind(trainSubjects, trainActivities, train)


# Loading test datasets
test <- fread(file.path(workingdirectory, "UCI HAR Dataset/test/X_test.txt"))[, wantedFeatures, with = FALSE]
data.table::setnames(test, colnames(test), measurements)
testActivities <- fread(file.path(workingdirectory, "UCI HAR Dataset/test/Y_test.txt")
                        , col.names = c("Activity"))
testSubjects <- fread(file.path(workingdirectory, "UCI HAR Dataset/test/subject_test.txt")
                      , col.names = c("SubjectNum"))
test <- cbind(testSubjects, testActivities, test)

# merge datasets with rbind()
combined <- rbind(train, test)

# Conversion for classLabels to activityName
combined[["Activity"]] <- factor(combined[, Activity]
                                 , levels = activityLabels[["classLabels"]]
                                 , labels = activityLabels[["activityName"]])

combined[["SubjectNum"]] <- as.factor(combined[, SubjectNum])
combined <- reshape2::melt(data = combined, id = c("SubjectNum", "Activity"))
combined <- reshape2::dcast(data = combined, SubjectNum + Activity ~ variable, fun.aggregate = mean)


#Output TidyData text file
data.table::fwrite(x = combined, file = "tidyData.txt", quote = FALSE)
