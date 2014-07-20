################################################################################
## 1 - Merge the training and the test sets to create one data set.
## 2 - Extract only the measurements on the mean and standard deviation for each 
## measurement.
## 3 - Use descriptive activity names to name the actual activities ("values" of
## the variables)
## 4 - Label the dataset with descriptive variable names.
## 5 - Create a second, independent tidy data set with the average of each 
## variable for each activity and each subject.
## 
## To make the read in of data faster, step number 2 will actually be performed 
## first, then step number 3 (including reading the data) for the "train" data 
## set and "test" data set, finally step 1, merging the data 
## respectively.
################################################################################

## Load libraries
require(stringr)
require(plyr)

## Read in the zipped data, unzip and define the directory for the data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
unzip("./data/Dataset.zip", exdir="./data")
dirname <- "./data/UCI HAR Dataset/"

## Read in the activity label, create "translation" table for activity
filename <- paste(dirname,"activity_labels.txt", sep="")
activityLabels <- read.table(filename,header=FALSE,stringsAsFactors=FALSE)
colnames(activityLabels) <- c("label","activity")

## Read in the features, create table for "features" in a similar fashion
filename <- paste(dirname,"features.txt", sep="")
features <- read.table(filename,header=FALSE)
colnames(features) <- c("index","feature")

###################################
## Step 2 - extract relevant data
###################################

## selecting features have "mean" and "std" in them, both features ending with 
## "mean()" or "std()" and features with "mean" or "std" in the feature name.
## Reasong being that all "means" or "standard deviations" should be included, 
## regardless of how they were calculated before we got the raw data.
 
colMeans <- which(grepl("mean",features[,2]))
colStd <- which(grepl("std",features[,2]))
colAll <- sort(c(colMeans,colStd))
colNames <- as.character(features[colAll,2])

###################################################################
## Step 3 and 4 (including reading the data) for data set "train"
###################################################################

## Read in the subject vector and activity (label) vector from the training set
filename <- paste(dirname,"train/subject_train.txt", sep="")
subject <- read.table(filename, header=FALSE, stringsAsFactor=FALSE)
filename <- paste(dirname,"train/y_train.txt", sep="")
activity <- read.table(filename, header=FALSE, stringsAsFactor=FALSE)
colnames(activity) <- "label"

## Add a sequence number, to be able to sort and keep structure to enable  
## merging of data with messing up 
activity$sequenceNumber <- 1:dim(activity)[1]
activity <- activity[,c(2,1)]

## Add in the descriptive labels
labeledActivity <- merge(activity,activityLabels,by="label",sort=FALSE)

## Re-sort (on sequenceNumber) so the data has the same sequence as before, 
## to enable merging with "actual" data
labeledActivity <- labeledActivity[order(labeledActivity[,2]),]

## Read in the main test data, extract relevant columns to dataRelevant
filename <- paste(dirname,"train/X_train.txt", sep="")
trainData <- read.table(filename)
dataRelevantTrain <- trainData[,colAll]

## Adding subject and activity vectors to dataRelevant
dataRelevantTrain[,80] <- subject
dataRelevantTrain[,81] <- labeledActivity[,3]
dataRelevantTrain <- dataRelevantTrain[,c(80,81,1:79)]
colnames(dataRelevantTrain) <- c("subject","activity",colNames)    

##################################################################
## Step 3 and 4 (including reading the data) for data set "test"
##################################################################

## Read in the subject vector and activity (label) vector from the test set
filename <- paste(dirname,"test/subject_test.txt", sep="")
subject <- read.table(filename, header=FALSE, stringsAsFactor=FALSE)
filename <- paste(dirname,"test/y_test.txt", sep="")
activity <- read.table(filename, header=FALSE, stringsAsFactor=FALSE)
colnames(activity) <- "label"

## Add a sequence number, to be able to sort and keep structure to enable  
## merging of data with messing up 
activity$sequenceNumber <- 1:dim(activity)[1]
activity <- activity[,c(2,1)]

## Add in the descriptive labels
labeledActivity <- merge(activity,activityLabels,by="label",sort=FALSE)

## Re-sort (on sequenceNumber) so the data has the same sequence as before, 
## to enable merging with "actual" data
labeledActivity <- labeledActivity[order(labeledActivity[,2]),]

## Read in the main test data, extract relevant columns to dataRelevant
filename <- paste(dirname,"test/X_test.txt", sep="")
testData <- read.table(filename)
dataRelevantTest <- testData[,colAll]

## Adding subject and activity vectors to dataRelevant
dataRelevantTest[,80] <- subject
dataRelevantTest[,81] <- labeledActivity[,3]
dataRelevantTest <- dataRelevantTest[,c(80,81,1:79)]
colnames(dataRelevantTest) <- c("subject","activity",colNames)    

#######################################
## Step 1 - Merging the two data sets
#######################################

dataRelevant <- NULL
dataRelevant <- rbind(dataRelevantTrain, dataRelevantTest)

##############################################################################
## Part 5 - Create a second, tidy dataset with the average of each variable, 
## for each activity and each subject
##############################################################################

## Calculate mean/average per subject and activity
dataRelevantMean <- ddply(dataRelevant, c("subject", "activity"),numcolwise(mean))

## Create new column names indicating these are calculated means (append "avg" to all existing names)
colNamesTidy <- paste(colNames,"-average", sep="")

## Name the columns
colnames(dataRelevantMean) <- c("subject","activity",colNamesTidy)

## write the data to a tab separated file called "tidy_data.tsv"
write.csv2(tidy_data, file="tidy_data.csv", quote=FALSE)
