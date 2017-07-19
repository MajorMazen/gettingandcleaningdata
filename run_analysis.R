#Start by setting the working directory from the command window to where your files are located
#This function:
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement (not for each feature!)
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis <- function(){
 
  #Read all data
  #Read features
  features = read.table("UCI HAR Dataset/features.txt")
  
  #Read activity labels 
  activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = F)
  
  #Read test and train data sets
  testSet <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features[,2])
  trainSet <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features[,2])
    
  # Read subject data for test and train data sets
  testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "Subject_ID", colClasses = "numeric")
  trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "Subject_ID", colClasses = "numeric")
  
  # Read test activity
  testActivity <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "Activity_Code", colClasses = "numeric")
  # Add activity Label
   testActivity$Activity_Label= activityLabels[testActivity[,1],2]
  
  # Read train activity
   trainActivity <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "Activity_Code", colClasses = "numeric")  
  # Add activity Label
  trainActivity$Activity_Label= activityLabels[trainActivity[,1],2]
  
  #--------------------------------------------------------------------------------------------
  #Merge all train and test data
  testData= cbind(testActivity, testSubjects, testSet)
  trainData= cbind(trainActivity, trainSubjects, trainSet)
  mergedData= rbind(trainData, testData)
  
  #--------------------------------------------------------------------------------------------
  #Cleanup
  rm(testData, testSubjects, testActivity, testSet)
  rm(trainData, trainSubjects, trainActivity, trainSet)
 
  #--------------------------------------------------------------------------------------------
  #Choose features with mean and std
  library(dplyr); library(plyr)
  mergedData <-  mergedData[, grepl("Activity_Code|Activity_Label|Subject_ID|(mean|std)\\.", names(mergedData))]

  
  #--------------------------------------------------------------------------------------------
  #Summarize the data: compute average of the measurements 
  #over unique combinations of subject & activity
  summaryData = ddply(mergedData,c("Activity_Code", "Activity_Label", "Subject_ID"),numcolwise(mean))
  
  
  #--------------------------------------------------------------------------------------------
  #write both data tables
  write.table(summaryData, "Summarized_Data.txt", sep = ',', row.names = FALSE)
  
  return(summaryData)
}

