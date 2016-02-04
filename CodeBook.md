################################################################################
## File: run_analysis.R                                                       ##
################################################################################

## The libraries used for the project are listed below

library(plyr)
library(reshape2)
library(dplyr)
library(utils)
library(data.table)

## We will now define all variables used for the project below:

raw.data.url is the URL address from which the data can be downloaded 
raw.data.file is the name of the file


#Naming the datasets that we will use

activityLabels: This represents the activity label file 
features: This represents the features file 
train_X_Activities: Contains the X activities of the training set  
train_Y_Activities: Contains the Y activities of the training set
test_X_Activities: Contains the Y activities of the test set
test_Y_Activities: Contains the Y activities of the test set
testSubjects:  Contains the subjects of the test set
trainSubjects: Contains the subjects of the training set


# Assignment Instruction 1: Merge test and training data for each type of file
X_Activities: Merged test and training data for the X activities
Y_activities: Merged test and training data for the Y activities
Subjects: Merged test and training data for the subjects

# Assignment Instruction 2: Extracts only the measurements on the mean and standard deviation for each measurement
X_Activities_named_subje_acti: This represents the X actvities of the subjects
X_Activities_named_subje_acti_sd_mean: This is similar to the previous document except that it extracts the standard deviation as well as the mean


# Assignment Instruction 5: From Step 4, independent tidy data set with  avg of each variable for each activity and each subject
Average_Table: The final table that needs to be submitted is called Average_Table
