# Data Cleaning
Tidy data was cleaned from UCI HAR Dataset to make it for further analysis

# Description
There's a R script which contains all the code.
The first block of the code reads activity_labels.txt file and assign column names.
The second block reads the training files X_train, y_train and subject_train.txt resp.
These 3 files are appended in the same block
Third block reads the testing files X_test, y_test and subject_test.txt resp.
These 3 files are appended in the same block
In the next block train and test data tables are combined using cbind.
Last block writes the combined data table from the third block of code to a external file.(tidyData.txt)
