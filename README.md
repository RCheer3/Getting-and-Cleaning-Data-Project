The following describes the steps in run_analysis.R

The dataset was downloaded from the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

After downloading the following steps were taken:
1) load in features and training data
2) append proper column names onto training dataset and take only columns with mean and sd
3) load in test data set
4) append proper column names onto test dataset and take only columns with mean and sd
5) combine the test and training datasets
6) load in activity labels dataset and apply proper activity labels on the combined dataset
7) Take the mean of each of the remaining columns grouped by subject and activity
8) Write the results to a file (tidydata.txt)

