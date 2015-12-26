---
title: "WearableExercise"
author: "Dan Hunter"
date: "Thursday, December 24, 2015"
return(output): html_document
---
# "Wearable Devices Exercise Data summarized"
## untidy set
   These data consist of :
   *  X_train.txt, X_test.txt the raw data with no headers and no identification features
   * y_train.txt, y_test.txt the identification activity number data corresponding to the raw data - rows correspond e.g. X_train.txt has same number of rows as y_train.txt
   * subject_train.txt, subject_test.txt the identification subject number data corresponding to the raw data 
   * features.txt - the names of all the variables in the X_ files - 561 , these names are unsuitable because they contain "(),.-"
   * features_info.txt describes the variables in the data sets
   * activity_labels - gives the activity names corresponding to the activity numbers (6 of them)
   
## This set of functions takes an untidy data set, found in several files, 
  and creates one tidy merged data file and a tidy summary file with reasonable names
        TO RUN FROM RSTUDIO merely go to   
             Code / Run Region / Run All **or**  
             source("run_analysis.R")  (;  tidy<- finalize())



### 1. function change_names
 * input parameter:  name of original names file (always features.txt in this case) 
 *  eliminates characters "()-," changed to ".NULLNULLNULL"respectively. 
 "(" changed to "." to enable identifying measurements with mean and std.


### 2. The process_file  function
 * input parameter: the name of the data file with the original data
  reads in the data file, and extracts only measurements with mean and  std columns
 * then puts the modified names in for the data frame
 * These are extracted from features.txt which has raw  names use change names to 
 eliminate characters "()-," 
 * The column names are put in alphabetical order so mean and standard deviation
 are together
 * return(output): a data set with the proper descriptive names containing only mean,std data  (66 attributes)


### 2. The get_tidy_set function
* input parameter: a string - either "train"  or "test"  
*  tidies one data set - either train or test  
*  to be called twice.  
*   return(output):  a tidy data table with identifying columns for either train or test (66 columns)




### 3.  The get_merged_tidy function
   * no parameters:- processes the tidy train data table and the tidy test data table
  *  brings the key data and raw data together for  train and test files
 * and merges the train and test data frames into one data frame.
 * first column becomes the activity itself rather than activity number (character)
 *  return(output): a tidy data set containing train and test data and proper names
               (68 columns)


### 4. The summ_data function 
 * input parameter: the merged_data set
 * summarizes the data to give averages for each activity and subject,    the final table is ordered in order of activity (descending), then subject number    .  
 * return(output):  a tidy summmarized data set (180 X 68)


### 5. The finalize  function 
 * no parameter
 * puts it all together, creates the tidy merged data set
 * writes it to file,  then creates the tidy summarized data set, writes to file      creates tidy names   
 * return(output): the summarized tidy set


