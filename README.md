#Project for Getting and Cleaning Data - Read Me

##Related files
The files uploaded to Github are
* ReadMe.md (this file). This file explain related files, instructions how to use the script and what it will do, general description of the raw data.
* run_analysis.R. The actual script. It can be downloaded and run from RStudio. The raw data files will be downloaded, the data will be "cleaned" and an excel-file with (tidy) data will be written.
* CodeBook.md. Explains the variables and data files in more detail.
* Tidy_data.txt. The output from run_analysis.R. The output from the script is a csv-file though, this file is a simple copy-n-paste from the csv into text format. 

##The raw data
The raw data contain measurements from what is called "wearable computing", where companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data can be found here, https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and a full description of how the data was collected can be found here, http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

##The script
The script will
* Prepare the data set by selecting the relevant columns (columns containing "mean" or "std")
* Read in relevant columns (based on above) from two files with raw data, "test" and "training" data set.
* Merge the two (read in) data sets.
* Apply relevant names for the different activities (walking etc) as well as applying easy to understand variable names
* Create a second, independent tidy data set with the average of each variable for each activity and each subject

