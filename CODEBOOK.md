
## Instructions for Use
1. Download and unzip the files on: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
2. Start R and set your working directory to the location of the data files.
3. Source and run the function in R by typing: run_analysis()

## Files Read
The R function reads the following files as provided by the study:
1. "X_train.txt" and "X_test.txt" : which include the per line feature sets for the training and testing, respectively.
2. "Y_train.txt" and "Y_test.txt": which include the corresponding human activities for the train and test datasets, respectively.
3. "subject_train.txt" and "subject_test.txt": which list the subject no.s performing each measurement in (1).
4. "activity_labels.txt": which includes the human activity labels in order.


## Variables
### Formal Arguments
    None
### Local Variables/Functions

| Variable Name | Summary |                                                
|---------------|---------|
| features | data.frame': 561 obs. of  2 variables (feature no (1-6) and feature name) |
| testSet | numeric 'data.frame': 2947 obs. of  561 variables |
| trainSet | numeric 'data.frame': 7352 obs. of  561 variables |
| testSubjects | numeric 'data.frame':	2947 obs. of  1 variable: (Subject_ID) 1-30 |
| trainSubjects | numeric 'data.frame':	7352 obs. of  1 variable: (Subject_ID) 1-30 |
| testActivity | 'data.frame':	2947 obs. of  2 variables: (Activity_Code 1-6, Activity_Label) |
| trainActivity | 'data.frame':	7352 obs. of  2 variables: (Activity_Code 1-6, Activity_Label) |
| testData | 'data.frame':2947 obs. of  564 variables: column-binded testActivity, testSubjects & testSet |
| trainData | 'data.frame':7352 obs. of  564 variables: column-binded testActivity, testSubjects & testSet |
| mergedData | 'data.frame':	10299 obs. of  69 variables: Activity_Code, Activity_Label, Subject_ID, mean and std features |
| summaryData | 'data.frame': 180 obs. of  69 variables: Holds data summary, in which average of mean and standard deviation features are aggregated across distinct activity and subject pairs. |
