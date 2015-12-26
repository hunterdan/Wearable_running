##### This set of functions takes an untidy data set, found in several files, 
## and creates one tidy merged data file and a tidy summary file with reasonable names
##        TO RUN FROM RSTUDIO merely open the file; go to Code / Run Region / Run All or
## source("run_analysis.R")  ;  finalize()



## function eliminates characters "()-," changed to ".NULLNULLNULL"respectively. 
## "(" changed to "." to enable identifying measurements with mean and std.
change_names <- function(names_file){
  fOrig <- read.table(names_file)
  names.O <- fOrig$V2
  names.O <- gsub("\\)","",names.O)
  
  names.O <- gsub("\\,","",names.O)
  names.O <- gsub("\\-","",names.O)
  names.O <- gsub("\\(",".",names.O)
  names.O <- tolower(names.O)
  newNames  <- data.frame(V1=1:561,V2=names.O)
  newNames
}

change_names2 <- function (table_out){
  names_n <- names(table_out)
  names.O <- sub("mean\\.","avemean",names_n)
  names.O <- sub("std\\.","avestd",names.O)
  
}
## This function reads in the data file, and extracts only measurements 
## with mean and  std columns
## then puts the modified names in for the data frame
## These are extracted from features.txt which has raw  names use change names to 
## eliminate characters "()-," 
## The column names are put in alphabetical order so mean and standard deviation
## are together

process_file <- function(file_name){
  
  ##setwd("C:/Cleaning Data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")
  named_file <- read.table(file_name)
  names_data <- change_names("features.txt")
  names_rqd_data <- names_data[grep("mean\\.", names_data$V2,ignore.case=TRUE),]
  names_rqd_data_sd <- names_data[grep("std", names_data$V2,ignore.case=TRUE),]
  names_data <- bind_rows(names_rqd_data,names_rqd_data_sd)
  named_file <- select(named_file,names_data$V1)
  names(named_file) <- names_data$V2
  named_file <- named_file[,order(colnames(named_file))]
  named_file
}

## This function tidies one data set - either train or test
##  to be called twice.returns a data table with identifying columns


get_tidy_set <- function(tr_or_te){
   
   data_name <- paste0("X_",tr_or_te,".txt")
   act_name <- paste0("y_",tr_or_te,".txt")
   sub_name <- paste0("subject_",tr_or_te,".txt")
   t_dat <- process_file(data_name)
   sub_data <- read.table(sub_name)
   act_data <- read.table(act_name)
   names(act_data ) <- c("activity")
   names(sub_data ) <- c("subjectno")
   full_t <- bind_cols( act_data,sub_data,t_dat)
   full_t
}

## This brings the key data and raw data together for train and test files
## and merges the train and test data frames into one data frame.
## first column becomes the activity itself rather than activity number (character)

get_merged_tidy <- function(){
  train_dat <- get_tidy_set("train")
  test_dat <- get_tidy_set("test")
  merged_data <- bind_rows(train_dat,test_dat)
  act_labels <- read.table("activity_labels.txt",stringsAsFactors=FALSE)
  merged_data <- mutate(merged_data,activity = act_labels[activity,]$V2)
  merged_data  
}

## This function summarizes the data to give averages for each activity and subject
## the final table is ordered in order of activity (descending), then subject number
summ_data <- function(table_in){
  tidy  <-
    table_in %>%
    group_by(activity,subjectno) %>%
    summarise_each(funs(mean)) ## %>%
    ##arrange(activity,subjectno)
  
tidy_final <- tidy[order(rev(tidy$activity),tidy$subjectno),]
tidy_final
}

## This function puts it all together, creates the tidy merged data set, writes it to file
## then creates the tidy summarized data set, writes to file, creates tidy names 
finalize <- function(){
  library(dplyr)
  merged_data <- get_merged_tidy()
  write.table(merged_data,"tidy.txt",row.names=FALSE,quote=FALSE)
  tidy <- summ_data(merged_data)
  write.table(tidy,"summarized_tidy.txt",row.names=FALSE,quote=FALSE)
  names(tidy)<- change_names2(tidy)
  View(tidy)
  tidy
}

tidy <- finalize()