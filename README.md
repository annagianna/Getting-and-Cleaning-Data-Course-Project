# Coursera Getting and Cleaning Data: peer-graded assignment

In this repository, the following files are included, as described in the assignment:
1) The tidy data set as described below
2) The CodeBook.md that describes the variables, the data and transformations I performed to clean up the data
3) A README.md expaining how all of the scripts work and how they are connected.

# Description of each file included in this repository

1) "run_analysis.R": According to the isntructions of the assignment, the script performs the following steps:
   - Merges the training and the test sets to create one data set.
   - Extracts only the measurements on the mean and standard deviation for each measurement.
   - Uses descriptive activity names to name the activities in the data set
   - Appropriately labels the data set with descriptive variable names.
   - Creates a second, independent tidy data set with the average of each variable for each activity and each subject (tidy_data.txt)
3) "CodeBook.md": describes the data, variables and transformations peform in the process of cleaning up the data

5) "tidy_data.txt": final data set including only the acerage of each variable for each subject and activity

# About the data

The data for this assignment represent data collected from the accelerometers from the Samsung Galaxy S smartphone and are part of 
the Human Activity Recognition Using Smartphones database

# How to run the analysis

1) Download data from the link provided on the assignment webpage: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2) Unzip file
3) Run the script in this repository ("run_analysis.R")
