#Project for Getting and Cleaning Data - Code Book

##Tidy data - output
The tidy data set that is output from the script containing one row per subject (equal to one person) and one activity (e.g walking) with the mean/average of all measurement that in the raw data contain "mean" or "std" somewhere in their variable names.

##Variable names
subject - int, values [1:30], the person that this particular measurement(s) was done on
activity - chr, values ["laying", "sitting", "standing", "walking", "walking_downstairs", "walking_upstairs"
variable  num,  3-180 are different "movement detections" by the accelerometer in the mobile. Detailed description can be found in the description of the original data set found here, https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 


