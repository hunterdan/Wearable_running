---
title: "CODEBOOK"
author: "Dan Hunter"
date: "Saturday, December 26, 2015"
output: html_document
---

## CODEBOOK for run_analysis.R convert untidy data to tidy summarized data 
  * MEASURED DATA ON MOVEMENT OR EXERCISE FOR WEARaBLE DEVICES e.g. distance walked

 1.  * The original data is found in [X_train.txt (data 561 attributes,7352 rows), y_train.txt (activity number  only - related to X_train.txt), subject_train.txt (subject number  only - related to X_train.txt)] and the same 3 files for test e.g. X_test.txt (561 columns,2947 rows).
     * The names for the 561 attributes are found in features.txt
  
 2. * The X_train.txt is read into a temporary table say temp_data.
    * The names are converted to proper names i.e. no special characters, all lower case 
    * A subset of the names consisting of only those measurements with mean and standard deviation is extracted -> names_rqd (length 66)
    * the train_data  table is created from the subset of the data from the names_rqd columns, the associated names are attached, and the columns are sorted in alphabetical order
    * The columns from y_train.txt, subject_train.txt and train_data are bound together in one data table   train_dat (a tidy data set)
    * The same is done for the y_test.txt, subject_test.txt and X_test.txt files ,
    read X_test.txt into say test.data, and bind columns with subset of names
    into a tidy data set test_dat
    * The train_dat and test_dat tables are merged into a tidy data set 
    merged_data and this table is written to a file with activity names instead of numbers (from activity_labels.txt)
    
 3. * The data from the merged_data table is summarized to give a table containing 
 mean of all variables for each activity and each subject (180 rows and 68 columns)
    * data is sorted by activity name (descending) and subject number.
    * The names are changed to reflect this data - mean becomes avemean and 
    std becomes avestd
    * The final summarized tidy set is written to a file summarized_tidy.txt
    

Original data:
      A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


This is repeated from features_info.txt:

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.


