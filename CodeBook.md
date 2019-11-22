---
title: "CodeBook"
author: "Nimesh Kuinkel"
date: "11/21/2019"
output: html_document
---

# Variables

## Name	Original file	Content

train_data	
/UCI HAR Dataset/train/X_train.txt	
data in measurements, for train



train_label	
/UCI HAR Dataset/train/y_train.txt	
lable for activity in measurements, for train


train_subject	
/UCI HAR Dataset/train/subject_train.txt	
label for subject in measurements, for train


test_data	
/UCI HAR Dataset/test/X_test.txt	
data in measurements, for test

test_label	
/UCI HAR Dataset/test/y_test.txt	
lable for activity in measurements, for test


test_subject	
/UCI HAR Dataset/test/subject_test.txt	
label for subject in measurements, for test

data_name	
/UCI HAR Dataset/features.txt
names for measurement data

label_to_activity	
/UCI HAR Dataset/activity_labels.txt
link activity label to its name


## Name	Content

full_train_data	data,
label for activity and subject in one table for train

full_test_data	data, 
label for activity and subject in one table for test

full_data	
all data for test and train in one table


extract_data_with_activity_name (temp)
all data about mean and std from full_data set

group_mean_data
mean of each variable group by activity and 

final_export_set	
export version of group_mean_data with colnames fixed