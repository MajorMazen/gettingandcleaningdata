## Objective
"run_analysis.R" performs the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

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

## Output Files
This function outputs the following files:
1. Combined_Data.txt: the clean and combined data for train and test datasets as {Activity_Code, Activity_Label, Subject_ID, Mean, Standard_Deviation}
2. Summarized_Data.txt: presents the average of the 2 variables (mean and standard deviations) for each distinct activity and subject pairs as {Activity_Code, Activity_Label, Subject_ID, AVG(Mean), AVG(Standard_Deviation)}.

## Variables
### Formal Arguments
    None
### Local Variables/Functions


| Object Name    | Class                   | Dimension  | Range (Numeric) | Usage                                                                                 |
|----------------|-------------------------|------------|-----------------|---------------------------------------------------------------------------------------|
| testSet        | Character data frame    |  2947 x 1  |        -        | Holds data in X_test.txt                                                              |
|                |                         |            |                 |                                                                                       |
| trainSet       | Character data frame    |  7352 x 1  |        -        | Holds data in X_train.txt                                                             |
|                                                                                                                                                                 |
| testSubjects   | Numeric data frame      |  2947 x 1  |      1-30       | Holds data in subject_test.txt                                                        |

| trainSubjects  | Numeric data frame      |  7352 x 1  |      1-30       | Holds data in subject_train.txt                                                       |

| testActivity   | Numeric data frame      |  2947 x 1  |       1-6       | Holds data in Y_test.txt. A character variable with the equivalent activity labels is |      |                |                         |            |                 | later added to it                                                                     |
|----------------|-------------------------|------------|-----------------|---------------------------------------------------------------------------------------|
| trainActivity  | Numeric data frame      |  7352 x 1  |       1-6       | Holds data in Y_train.txt. A character variable with the equivalent activity labels is|      |                |                         |            |                 | later added it                                                                        |
|----------------|-------------------------|------------|-----------------|---------------------------------------------------------------------------------------|
| activityLabels | Int&Char data frame     |    6 x 2   |       1-6       | Holds data in activity_labels.txt                                                     |
|----------------|-------------------------|------------|-----------------|---------------------------------------------------------------------------------------|
| Clean          | Function                |      -     |        -        | Splits a given row of testSet or trainSet, converts it to numeric and outputs a 2     |
|		 |		           |            |                 | variable vector of its mean and standard deviation                                    |
|----------------|-------------------------|------------|-----------------|---------------------------------------------------------------------------------------|
| testDescptr    | Numeric data frame      |  2947 x 2  |      [-1,1]     | Holds per row descriptors (mean and standard deviation) of the test feature sets      |
|----------------|-------------------------|------------|-----------------|---------------------------------------------------------------------------------------|
| trainDescptr   | Numeric data frame      |  7352 x 2  |      [-1,1]     | Holds per row descriptors (mean and standard deviation) of the train feature sets     |  
|----------------|-------------------------|------------|-----------------|---------------------------------------------------------------------------------------|
| testData       | Multivariate data frame |  2947 x 5  |        -        | Holds column-binded testActivity, testSubjects & testDescptr with variables of        |      |                |                         |            |                 | {Activity_Code, Activity_Label, Subject_ID, Mean, Standard_Deviation}                 |
|----------------|-------------------------|------------|-----------------|---------------------------------------------------------------------------------------|
| trainData      | Multivariate data frame |  7352 x 5  |        -        | Holds column-binded trainActivity, trainSubjects & trainDescptr with variables of     |      |                |                         |            |                 | {Activity_Code, Activity_Label, Subject_ID, Mean, Standard_Deviation}                 |     |                |                         |            |                 |                                                                                       |
|----------------|-------------------------|------------|-----------------|---------------------------------------------------------------------------------------|
| mergedData     | Multivariate data frame |  10299 x 5 |        -        | Holds row-binded and ordered trainData & testData                                     | 
|----------------|-------------------------|------------|-----------------|---------------------------------------------------------------------------------------|
| meltData       | Multivariate data frame |  20598 x 5 |        -        | Holds melted mergedData over the measure variable: Mean & Standard_Deviation          |   
|----------------|-------------------------|------------|-----------------|---------------------------------------------------------------------------------------|
| summaryData    | Multivariate data frame |  180 x 5   |        -        | Holds data summary, in which avergae of mean and standard deviation are aggregated    |      |                |                         |            |                 | across distinct activity and subject pairs. Variables are {Activity_Code,             | 
|                |                         |            |                 | Activity_Label, Subject_ID, AVG(Mean), AVG(Standard_Deviation)}                       |
|----------------|-------------------------|------------|-----------------|---------------------------------------------------------------------------------------|

## Implementation
The code works to:
1. Read all relevant data files into data frames (X_test.txt, Y_test.txt, X_train.txt, Y_train.txt, subject_test.txt, subject_train.txt, activity_labels.txt).
2. Clean (through splitting by spaces) and transform to numeric the feature sets provided by the files: X_train.txt and X_test.txt, excluding any possible NA's.
3. Creating new data frame with each feature-row substituted by its mean and standard deviation for both train and test feature sets.
4. Adding proper activity labels corresponding to the activity numbers as read by the files: Y_train.txt and Y_test.txt.
5. Properly adding variable names to all data frames before merger.
6. Merging activity codes, labels, subjects and mean and standard deviation of features through column-binding for both train and test data separately.
7. Merging all train and test data through row-binding, followed by ordering by the activity code and subject ID for a tidier data.
8. Summarizing the data, through providing the average mean and standard deviation over unique pairs of activities and subjects, done by melting and casting.
9. Writing the final output data (mergedData & summaryData) on disk.
