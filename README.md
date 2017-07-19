## Introduction

This code aims at reading the data supplied by UCI for Human Activity Recognition using smart phones (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. The final output of the study is a large number of 561-feature vector measurements for the different activities performed by the subjects. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

## Objective
The objective of the script file is to:
1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set.
4. Appropriately label the data set with descriptive variable names.
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable. for each activity and each subject.

## Files Included
This Repository includes:
1. run_analysis.R: script satistying the objective.
2. README.md
3. CODEBOOK.md: explains variables and steps taken to clean up and present data both as combined and summarized.

