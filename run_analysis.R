library(dplyr)
library(rlang)

#assigning the dataframes 
setwd("C:/Users/Name IT/Documents/New folder/dataCleaning/UCI HAR Dataset")
activityLabels <- read.table('activity_labels.txt')
colnames(activityLabels)[1] = "serialNO"
colnames(activityLabels)[2] = "activityLabel"

features <- read.table('features.txt')
colnames(features)[1] = "index"
colnames(features)[2] = "featureLabel"

reqFeatures <- grep("(mean|std)\\(\\)", features[, "featureLabel"])

vals <- features[reqFeatures, "featureLabel"]
vals <- gsub('[()]', '', vals)


###############Combining Train Dataset############
train <- read.table("C:/Users/Name IT/Documents/New folder/dataCleaning/UCI HAR Dataset/train/X_train.txt")[, reqFeatures]
data.table::setnames(train, colnames(train), vals)

activitiesTrain <- read.table("C:/Users/Name IT/Documents/New folder/dataCleaning/UCI HAR Dataset/train/y_train.txt") 
colnames(activitiesTrain)[1] = "Activity"

subjectsTrain <- read.table("C:/Users/Name IT/Documents/New folder/dataCleaning/UCI HAR Dataset/train/subject_train.txt") 
colnames(subjectsTrain[1]) = "SubjectNum"

train <- cbind(subjectsTrain, activitiesTrain, train)


################Combining Test Dataset############
test <- read.table("C:/Users/Name IT/Documents/New folder/dataCleaning/UCI HAR Dataset/test/X_test.txt")[, reqFeatures]
data.table::setnames(test, colnames(test), vals)

activitiesTest <- read.table("C:/Users/Name IT/Documents/New folder/dataCleaning/UCI HAR Dataset/test/y_test.txt") 
colnames(activitiesTest)[1] = "Activity"

subjectsTest <- read.table("C:/Users/Name IT/Documents/New folder/dataCleaning/UCI HAR Dataset/test/subject_test.txt") 
colnames(subjectsTest[1]) = "SubjectNum"

test <- cbind(subjectsTest, activitiesTest, test)


############Merging###################
merged <- rbind(train, test)


###############Reshaping###############
merged[["Activity"]] <- factor(merged[, "Activity"], levels = activityLabels[["serialNO"]],
                               labels = activityLabels[["activityLabel"]])
head(merged)
merged[["SubjectNum"]] <- as.factor(merged[, "V1"])
merged <- reshape2::melt(data = merged, id = c("SubjectNum", "Activity"))
merged <- reshape2::dcast(data = merged, SubjectNum + Activity ~ variable, fun.aggregate = mean)

data.table::fwrite(x = merged, file = "tidyData.txt", quote = FALSE, row.names = FALSE)
