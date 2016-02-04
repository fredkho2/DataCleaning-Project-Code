
################################################################################
## File: run_analysis.R                                                       ##
################################################################################

################################################################################
## Parameter definition section                                               ##
################################################################################

library(plyr)
library(reshape2)
library(dplyr)
library(utils)
library(data.table)

raw.data.url <- paste0("https://d396qusza40orc.cloudfront.net/getdata%2F","projectfiles%2FUCI%20HAR%20Dataset.zip")
raw.data.file <- "UCI_HAR_Dataset.zip"

i=1

if (!file.exists(raw.data.file)) {download.file(raw.data.url, destfile=raw.data.file)}


#Naming the datasets that we will use
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE,sep = "")
features <- read.table("UCI HAR Dataset/features.txt",header = FALSE,sep = "")
train_X_Activities <- read.table("UCI HAR Dataset/train/X_train.txt",header = FALSE,sep = "")
train_Y_Activities <- read.table("UCI HAR Dataset/train/Y_train.txt",header = FALSE,sep = "")
test_X_Activities <- read.table("UCI HAR Dataset/test/X_test.txt",header = FALSE,sep = "")
test_Y_Activities <- read.table("UCI HAR Dataset/test/Y_test.txt",header = FALSE,sep = "")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt",header = FALSE,sep = "")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt",header = FALSE,sep = "")


# Check if loaded training and test dataframes have same number of cols
if (ncol(testSubjects)==ncol(trainSubjects) & ncol(train_X_Activities)==ncol(test_X_Activities) & ncol(test_Y_Activities)==ncol(train_Y_Activities)){
    print("Dimensions of the various datasets are coherent")  
  } else {print("Dimensions of the various datasets are NOT Coherent") & stop() }


# Assignment Instruction 1: Merge test and training data for each type of file
X_Activities <- rbind(train_X_Activities,test_X_Activities)
Y_activities <- rbind(train_Y_Activities, test_Y_Activities)
Subjects <- rbind(trainSubjects,testSubjects)


# Assignment Instruction 3 & 4: Name the activities in the data set & appropriately label the data set
# We will voluntarily keep the name duplicates in features as no instruction was given for those
levels(features$V2) <- gsub("-","_",levels(features$V2))
levels(features$V2) <- gsub("\\(","",levels(features$V2))
levels(features$V2) <- gsub(")","",levels(features$V2))

colnames(X_Activities)<- c(transpose(features[2]))
colnames(Subjects) <- c("Subjects")


# Naming Y Activities
for (i in 1:10299){
  if (Y_activities[i,1]=="1") {Y_activities[i,2] <- "WALKING"}
  if (Y_activities[i,1]=="2") {Y_activities[i,2] <- "WALKING_UPSTAIRS"}
  if (Y_activities[i,1]=="3") {Y_activities[i,2] <- "WALKING_DOWNSTAIRS"}
  if (Y_activities[i,1]=="4") {Y_activities[i,2] <- "SITTING"}
  if (Y_activities[i,1]=="5") {Y_activities[i,2] <- "STANDING"}
  if (Y_activities[i,1]=="6") {Y_activities[i,2] <- "LAYING"}
  }

colnames(Y_activities)<- c("Number","Activities")
X_Activities_named_subje_acti<- cbind(Subjects,Activities = Y_activities$Activities,X_Activities)


# Assignment Instruction 2: Extracts only the measurements on the mean and standard deviation for each measurement
X_Activities_named_subje_acti_sd_mean<-X_Activities_named_subje_acti[grep("(mean|std)", names(X_Activities_named_subje_acti))]


# Assignment Instruction 5: From Step 4, independent tidy data set with  avg of each variable for each activity and each subject
Average_Table<-ddply(X_Activities_named_subje_acti,.(Subjects,Activities),function(x) colMeans(x[,3:79]))
