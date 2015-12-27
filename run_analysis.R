setwd("D:/my/coursera/getdata035_project")

rm(list=ls())

#1. Checks for package and install it if it doesn't exist
if (!require('plyr',character.only = TRUE)){
  install.packages('plyr',dep=TRUE)
}

library('plyr')


#2. Checks for data and creates one if it doesn't exist
if (!file.exists("./UCI HAR Dataset")) {
  fileLoc <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  dlfile="UCI_HAR_data.zip"
  message("Downloading data")
  download.file(fileLoc, destfile=dlfile)
  unzip(dlfile,exdir = ".")
}


#3. Reading the extracted data in the directory
#a. Reading the activity labels and features
activity.lab <- read.table("UCI HAR Dataset/activity_labels.txt")
features.list <- read.table("UCI HAR Dataset/features.txt")
features.name <- t(features.list[,2])

#b. Reading the test set
testset <- read.table("UCI HAR Dataset/test/X_test.txt")
testset.lab <- read.table("UCI HAR Dataset/test/y_test.txt")

#c. Reading the training set
trset <- read.table("UCI HAR Dataset/train/X_train.txt")
trset.lab <- read.table("UCI HAR Dataset/train/y_train.txt")

#d. Reading the subject list
testsubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
trsubject <- read.table("UCI HAR Dataset/train/subject_train.txt")

#e. Creating the label dataset for the activities
dataset.lab <- rbind(testset.lab,trset.lab)
dataset.lab[,2] = activity.lab[dataset.lab[,1],2]

#4. Extracting the std and mean measurements
extract_list <- grep('std|mean',features.name)

#a. Combine the dataset before extraction
dataset.activity <- rbind(testset,trset)
extdataset.activity <- dataset.activity[,extract_list]

#b. Applying the column names to the extracted dataset
extfeatures.name <- features.name[,extract_list]
clean.extfeatures.name<- sapply(extfeatures.name,function(x){sub("[(][])]","",x)})
colnames(extdataset.activity) <- clean.extfeatures.name



#5. Merging into the dataset
dataset.subject <- rbind(testsubject,trsubject)
ext.dataset <- cbind(dataset.subject,dataset.lab,extdataset.activity)
colnames(ext.dataset)[1:3] <- c('Subject','Activity.ID','Activity.Type')


#6. Prepare a tidy dataset.
#Uses the ddply function from plyr to find the mean of each activity type for each subject.
tidy.data <- ddply(ext.dataset, .(Subject,Activity.ID,Activity.Type),function(ext.dataset){colMeans(ext.dataset[,4:82]) })
write.table(tidy.data,'tidy_data_sgs.txt',row.name=FALSE)
