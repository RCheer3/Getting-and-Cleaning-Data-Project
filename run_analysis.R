
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile = "./Dataset.zip") 

#first load in the table that tells you what is in each column
features = read.table("Dataset/UCI HAR Dataset/features.txt")
summary(features)


#next load in the training data
XTrain = read.table("Dataset/UCI HAR Dataset/train/X_train.txt")
YTrain = read.table("Dataset/UCI HAR Dataset/train/Y_train.txt")
subjectTrain = read.table("Dataset/UCI HAR Dataset/train/Subject_train.txt")

#after loading in the training data, I updated the headers so that we know what is in each column
for(i in 1:length(XTrain))
{names(XTrain)[i] = as.character(features[i,2])}

#from there we can filter to only look at the columns with mean or standard deviation
meanSD = grep('mean()|std()', names(XTrain))
Train = XTrain[meanSD]

#after we have filtered to that level, we can add the activity and subject to the table
Train$activity= YTrain[,1]
Train$subject = subjectTrain[,1]


#basically the same thing is done with the Test tables as was done to the Train tables
XTest = read.table("Dataset/UCI HAR Dataset/test/X_test.txt")
YTest = read.table("Dataset/UCI HAR Dataset/test/Y_test.txt")
subjectTest = read.table("Dataset/UCI HAR Dataset/test/Subject_test.txt")

for(i in 1:length(XTest))
{names(XTest)[i] = as.character(features[i,2])}
Test = XTest[meanSD]

Test$activity = YTest[,1]
Test$subject = subjectTest[,1]

#after loading in the data and filtering to only look at the columns with mean/sd we combine the two datasets

combine = rbind(Test,Train)
dim(combine)

library(reshape2)
#now we load in the activity labels so we know what each activityXTest = read.table("Getting and Cleaning Data/Dataset/UCI HAR Dataset/test/X_test.txt")
activityLabels = read.table("Dataset/UCI HAR Dataset/activity_Labels.txt")
summary(activityLabels)
activityLabels[,2]= gsub('_',' ',activityLabels[,2])


combine$activity = factor(combine$activity,levels = activityLabels[,1], labels = activityLabels[,2])

#now we create step 5) where we have the mean of each column grouped by subject and activity (30 subjectsx6 activities= 180 rows)
combineMelt = melt(combine,id=c("activity","subject"))
MeanbyActivitySubject = dcast(combineMelt,subject+activity~variable,mean)



#this basically just takes the final table and prints it to a file called tidydata.txt
write.table(MeanbyActivitySubject,file = "tidydata.txt",append = FALSE)



