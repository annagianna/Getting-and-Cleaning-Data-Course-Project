# Code Book for Coursera Getting and Cleaning Data Course Assignment

This code book that describes the variables, the data, and any transformations or work I performed to clean up the data

# Source data for this assignment

Source: Human Activity Recognition Using Smartphones
URL provided by course assignment:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Script called run_analysis.R includes the following steps, as requested by the assignment description:

1. Merges the training and the test sets to create one data set.
- Downloads data using download.file() from the URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip into the current working directory
- Unzip the downloaded .zip file into the Working directory I had set using unzip()
- Reads the train and test data sets, including activity labels and feature vectors
- Assigns variable names to the train and test data sets using the feature vectors
- Merges the train and test datasets into one

2. Extracts only the measurements on the mean and standard deviation for each measurement.
- Creates a new dataset including only the std and mean of each measurement 

3. Uses descriptive activity names to name the activities in the data set
- using the activity levels file a column including the corresponding descriptive activity names are added to the dataset

4. Appropriately labels the data set with descriptive variable names. 
- using colnames, appropriate descriptive variable names are created in the dataset

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- using group_by, a second independent tidy data set including only the average of each veriable is created
- as a next step the new indepentent tidy data set is written into a text file called tidy_dataset.txt

# Information on the different variables in the code

- `train_x`, `train_y`, `train_subject` contain data from the downloaded train files
- `train` merges the above train data sets
- `test_x`, `test_y`, `test_subject` contain data from the downloaded test files
- `test` merges the above test data sets
- `features_list` contains the correct column names for the `train` and `test` datasets
- `activity_lables` matches activity code/id with activity description

