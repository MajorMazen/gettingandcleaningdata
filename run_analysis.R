#Start by setting the working directory from the command window to where your files are located
#This function:
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement (not for each feature!)
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis <- function(){
 
  #Read all data
  #Read test and train data sets
  testSet <- read.table("./UCI HAR Dataset/test/X_test.txt", sep= "\n", header= F, stringsAsFactors = F)
  trainSet <- read.table("./UCI HAR Dataset/train/X_train.txt", sep= "\n", header= F, stringsAsFactors = F)
    
  # Read subject data and activity for test and train data sets
  testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep= " ", header= F, colClasses = "numeric")
  testActivity <- read.table("./UCI HAR Dataset/test/y_test.txt", sep= " ", header= F, colClasses = "numeric")
  trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep= " ", header= F, colClasses = "numeric")
  trainActivity <- read.table("./UCI HAR Dataset/train/y_train.txt", sep= " ", header= F, colClasses = "numeric")  
    
  #Read activity labels 
  activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep= " ", header= F, stringsAsFactors = F)
 
  
  #--------------------------------------------------------------------------------------------
  #Define cleaning function with mean and std descriptors for each line (measurement) of the test and train sets
  clean <- function(x){ 
    x= strsplit(x, " "); x= as.numeric(unlist(x)); x= x[!is.na(x)]; c(mean= mean(x), std= sd(x))} 
  
  #Clean test set
  n <- nrow(testSet)
  testDescptr <- data.frame(Mean= vector("numeric", n), Standard_Deviation= vector("numeric", n))
  for (i in 1:n){testDescptr[i,]= clean(testSet[i,1])}
  
  #Clean train set
  n <- nrow(trainSet)
  trainDescptr <- data.frame(Mean= vector("numeric", n), Standard_Deviation= vector("numeric", n))
  for (i in 1:n){trainDescptr[i,]= clean(trainSet[i,1])}

  #--------------------------------------------------------------------------------------------
  #Cleanup
  rm(testSet, trainSet)
  
  #--------------------------------------------------------------------------------------------
  #Add activity labels to test and train activity code numbers
  testActivity$Activity_Label= activityLabels[testActivity[,1],2]
  trainActivity$Activity_Label= activityLabels[trainActivity[,1],2]
  
  #--------------------------------------------------------------------------------------------
  #Add proper variable (column) names 
  colnames(testSubjects) <- "Subject_ID"
  colnames(testActivity)[1] <- "Activity_Code"
  colnames(trainSubjects) <- "Subject_ID"
  colnames(trainActivity)[1] <-  "Activity_Code"

  #--------------------------------------------------------------------------------------------
  #Merge all train and test data
  #function merge isn't necessary (same columns and no measurments are cross-referenced in both sets even for 
  #repeated subject and activity)
  testData= cbind(testActivity, testSubjects, testDescptr)
  trainData= cbind(trainActivity, trainSubjects, trainDescptr)
  mergedData= rbind(trainData, testData)
  
  #--------------------------------------------------------------------------------------------
  #Arrange datasets based on activity and subject (not necessary)
  mergedData <- mergedData[order(mergedData$Activity_Code, mergedData$Subject_ID),]
    
  #--------------------------------------------------------------------------------------------
  #Cleanup
  rm(testData, testSubjects, testActivity, testDescptr)
  rm(trainData, trainSubjects, trainActivity, trainDescptr)
 
  #--------------------------------------------------------------------------------------------
  #Summarize the data: compute average of the 2 variables (mean and std) 
  #over unique combinations of subject & activity
  
  # 1. Reshape data data first and define the variable as mean and std
  library(reshape2)
  meltData <- melt(mergedData, id= c("Subject_ID", "Activity_Code", "Activity_Label"), 
                   measure.vars = c("Mean", "Standard_Deviation"))
  # 2. Project distinct pairs of ids against (vs) average of the 2 variables 
  summaryData <- dcast(meltData, Activity_Code + Activity_Label + Subject_ID ~ variable, mean)
  colnames(summaryData)[4:5] <- c("AVG(Mean)", "AVG(Standard_Deviation)")
  
  #--------------------------------------------------------------------------------------------
  #write both data tables
  write.table(mergedData, "Combined_Ordered_Data.txt", sep = ',', row.names = FALSE)
  write.table(summaryData, "Summarized_Data.txt", sep = ',', row.names = FALSE)
}

