#Getting and Cleaning Data Course

##Course Project

###Summary of project requirements.
One R script called run_analysis.R should be created that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Here is the data used for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

###Running the code
1. Fork this repository. You can also clone it or download it to your local drive.
2. Navigate to the folder in which this repository exists.
3. Set this folder as the working directory using setwd() in R.
4. Download the dataset into this folder and unzip to this folder. You should have a folder called `UCI HAR Datase`. You can also let the script do the downloading for you.
5. Run the `run_analysis.R` using the source() command.
6. A `tidy_data_sgs.txt` file will be generated in this folder.


###Dependencies
The R script requires plyr to run. `run_analysis.R` will help to install the library and dependencies if needed.