## Getting and Cleaning Data Course Project

## Here are the data for the project:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## You should create one R script called run_analysis.R that does the following. 

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data setwith the average of each variable for each activity and each subject.

# load dplyr package

library(dplyr)

# set working directory

setwd("/Users/Anna/Desktop/Coursera/Getting and Cleaning Data")

# download data from URL

galaxy_zip <- download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                            destfile = "/Users/Anna/Desktop/Coursera/Getting and Cleaning Data/galaxy_data.zip")

list.files() # file is successfully downloaded in working directory

# unzip files

unzip("galaxy_data.zip", junkpaths = FALSE, exdir = "/Users/Anna/Desktop/Coursera/Getting and Cleaning Data/galaxy_data")
list.files()

# read the train and test datasets into R before merging
# first read the train dataset

train_x <- read.table("/Users/Anna/Desktop/Coursera/Getting and Cleaning Data/galaxy_data/UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("/Users/Anna/Desktop/Coursera/Getting and Cleaning Data/galaxy_data/UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("/Users/Anna/Desktop/Coursera/Getting and Cleaning Data/galaxy_data/UCI HAR Dataset/train/subject_train.txt")

# then read the test dataset

test_x <- read.table("/Users/Anna/Desktop/Coursera/Getting and Cleaning Data/galaxy_data/UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("/Users/Anna/Desktop/Coursera/Getting and Cleaning Data/galaxy_data/UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("/Users/Anna/Desktop/Coursera/Getting and Cleaning Data/galaxy_data/UCI HAR Dataset/test/subject_test.txt")

# read the list of all features

features_list <- read.table("/Users/Anna/Desktop/Coursera/Getting and Cleaning Data/galaxy_data/UCI HAR Dataset/features.txt")

# read labels linking the class labels with their activity name

activity_labels <- read.table("/Users/Anna/Desktop/Coursera/Getting and Cleaning Data/galaxy_data/UCI HAR Dataset/activity_labels.txt")

# take a look at the files

View(train_x)
View(train_y)
View(features_list)
View(activity_labels)

# define variable names in both datasets prior to merging

colnames(activity_labels) <- c("activity_id", "activity_description")
head(activity_labels)

# train set

colnames(train_x) <- features_list$V2
colnames(train_y) <- "activity_id"
colnames(train_subject) <- "subject_id"

# same for the test set

colnames(test_x) <- features_list$V2
colnames(test_y) <- "activity_id"
colnames(test_subject) <- "subject_id"

# merge datasets
# merge train dataframes

train <- cbind(train_y, train_subject, train_x)
View(train)

# merge test dataframes

test <- cbind(test_y, test_subject, test_x)
View(test)

# merge train and test together

all_data <- rbind(train, test)
View(all_data)

# extract only the measurements on the mean and std for each measurement

extract_mean_std <- grep(
  "activity_id|subject_id|mean\\(\\)|std\\(\\)",
  colnames(all_data),
  value = TRUE
)
extract_mean_std

mean_std_data <- all_data[, extract_mean_std]
View(mean_std_data)

# replace activity labels with activity names
mean_std_data_with_activity_names <- merge(mean_std_data, activity_labels, by = "activity_id", all.x = TRUE)
View(mean_std_data_with_activity_names)

mean_std_data_with_activity_names$activity_description

# Appropriately label the data set with descriptive variable names

colnames(mean_std_data_with_activity_names)
colnames(mean_std_data_with_activity_names) <- gsub("^t", "Time ", colnames(mean_std_data_with_activity_names)) # columns starting with t
colnames(mean_std_data_with_activity_names) <- gsub("^f", "Frequency ", colnames(mean_std_data_with_activity_names)) # columns starting with f

colnames(mean_std_data_with_activity_names) <- gsub("-std\\(\\)-", "Standard Deviation ", colnames(mean_std_data_with_activity_names))
colnames(mean_std_data_with_activity_names) <- gsub("-mean\\(\\)-", "Mean ", colnames(mean_std_data_with_activity_names))
colnames(mean_std_data_with_activity_names) <- gsub("?-std\\(\\)", "Standard Deviation", colnames(mean_std_data_with_activity_names))
colnames(mean_std_data_with_activity_names) <- gsub("?-mean\\(\\)", "Mean", colnames(mean_std_data_with_activity_names))


colnames(mean_std_data_with_activity_names) <- gsub("Gyro", "Gyroscope ", colnames(mean_std_data_with_activity_names))
colnames(mean_std_data_with_activity_names) <- gsub("Acc", "Accelerometer ", colnames(mean_std_data_with_activity_names))
colnames(mean_std_data_with_activity_names) <- gsub("Mag", "Magnitude ", colnames(mean_std_data_with_activity_names))
colnames(mean_std_data_with_activity_names) <- gsub("Gravity", "Gravity ", colnames(mean_std_data_with_activity_names))
colnames(mean_std_data_with_activity_names) <- gsub("Jerk", "Jerk ", colnames(mean_std_data_with_activity_names))
colnames(mean_std_data_with_activity_names) <- gsub("BodyBody", "Body", colnames(mean_std_data_with_activity_names))
colnames(mean_std_data_with_activity_names) <- gsub("Body", "Body ", colnames(mean_std_data_with_activity_names))
colnames(mean_std_data_with_activity_names) <- gsub("activity_id", "Activity ID", colnames(mean_std_data_with_activity_names))
colnames(mean_std_data_with_activity_names) <- gsub("subject_id", "Subject ID", colnames(mean_std_data_with_activity_names))
colnames(mean_std_data_with_activity_names) <- gsub("activity_description", "Activity Description", colnames(mean_std_data_with_activity_names))

# From mean_std_data_with_activity_names, create a second, independent tidy data set with the average of each variable for each activity and each subject

avg_tidy_data <- mean_std_data_with_activity_names %>% 
  group_by(`Subject ID`, `Activity Description`, `Activity ID`) %>%
  summarise_all(mean) %>%
  print

# write avg_tidy_data into a txt file

write.table(avg_tidy_data, "tidy_dataset.txt", row.names = FALSE)
list.files()
