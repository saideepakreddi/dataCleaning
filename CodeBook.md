---
title: "R Notebook"
output: html_notebook
---

The Dataset
  Number of columns (variables): 67
  Number of rows: 181
Variables
  SubjectNum : It represents the number of subject in the dataset. It ranges from 1 to 30.

  Activity : It represents the activity name. There are 6 distict activites 1. WALKING 2. WALKING_UPSTAIRS 3. WALKING_DOWNSTAIRS 4. SITTING 5. STANDING 6. LAYING

  columns 3-67 : Columns 3 to 67 represent the features from fature.txt Each column represnts a unique feature along with it's data.

Cleaning
  activity_labels.txt is read first and column names are asssigned for better handling.
  Them features from features.txt file are read. from that required features (only with mean and std) are separated and a vector is made to store those values.
  Then train data is read from train folder. Two files X_train and subject_train are read separately.
  Column names are set for those tables.
  Data is combined using cbind so that columns from above 3 datasets can be appended.
  Above steps are repeated for the test dataset.
  Finally train and test data is merged using rbind.
And table is written to tidyData.txt
