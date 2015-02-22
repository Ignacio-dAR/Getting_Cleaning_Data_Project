#The purpose of this exercise is to create a tidy dataset from
# different pieces of information gathered in different files.

# In our case, we want to build a database with all the different subjects that
# participated in a experiment conducted by 
#Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto and Xavier Parra.
# regarding human activity recognision usgin smartphones.

#there are many different files in the author's dataset, but we will require 6,
# divided in 2 groups: "training" and "test".
# These files include:
#     a) the actual data collected by the smartphones (we label them "data")
#     b) the exercises performed while collecting the data (we label them "Labels")
#     c) the person/subject performing the exercise (we label them "Subjects")

# ------------------------------------------------------------------------------------------------
# 1) Merge the training and data set to create 1 dataset with all the data.

setwd("C:/testR/CleanData_Project/UCI HAR Dataset")

activity<-read.table("activity_labels.txt",header=FALSE)

testData<-read.table("test/X_test.txt",header=FALSE,sep="",na.strings="NA")
trainData<-read.table("train/X_train.txt",header=FALSE,sep="",na.strings="NA")
TotalData<-rbind(testData,trainData)
features<-read.table("features.txt",header=FALSE)
names(TotalData)<-features$V2


testLabels<-read.table("test/Y_test.txt",header=FALSE,na.strings="NA")
trainLabels<-read.table("train/Y_train.txt", header=FALSE,na.strings="NA")
TotalLabels<-rbind(testLabels,trainLabels)
names(TotalLabels)<-c("Activity")


testSubjects<-read.table("test/subject_test.txt", header=FALSE,na.strings="NA")
trainSubjects<-read.table("train/subject_train.txt", header=FALSE,na.strings="NA")
TotalSubjects<-rbind(testSubjects,trainSubjects)
names(TotalSubjects)<-c("Subject")

#Before start merging data, we will substitute the values in Labels by the actual exercises "activity_labels.txt" file.

TotalLabels[,1]<-activity[TotalLabels[,1],2]

# once we loaded all the data and merge the test and training sets of each group, 
# we will put both of them together using rbind.
# Thinking about the most suitable order to merge the data within each dataset,
# it seemed to me that (subject - label - data) was the better option, so

FullDataset<-cbind(TotalSubjects,TotalLabels,TotalData)

# Now, in order to save space, we can proceed eliminating the intermediate results:

rm(testLabels,trainLabels,testData,trainData,TotalData,testSubjects,trainSubjects)

# ------------------------------------------------------------------------------------------------
# 2) The next step is to keep only the mean and standard deviation measurements.

# In order to do this, we use the features file to filter only the desired measurements names measurements.
# And use that selection as "column filter" in the dataset.

ColumnsCriteria<-features$V2[grep("mean\\(\\)|std\\(\\)",features$V2)]
columnNames<-c("Subject","Activity", as.character(ColumnsCriteria))
FinalDataset<-subset(FullDataset,select=columnNames)


#-------------------------------------------------------------------------------------------------
# 3) & 4) Now we adapt the names to make them clearer, based upon the instructions on the README file.
# We already included the activity definitions on the variable "Activity", so this section will only
# require the substitution of prefixes,sufixes and abrreviations for the actual terms 
# as well as taking care of all the "-" symbols:
#
# "time" instead of "t"
# "frequency" instead of "f"
# "Body" instead of "BodyBody" (detected using "tail(TotalVariableNames,20))
# "Accelerometer" instead of "Acc"
# "Gyroscope" instead of "Gyro"
# "Mean" instead of "-mean"
# "StDev" instead of "-std"
# erase all "-()"


names(FinalDataset)<-gsub("^t","time_",names(FinalDataset))
names(FinalDataset)<-gsub("^f","frequency_",names(FinalDataset))
names(FinalDataset)<-gsub("BodyBody","Body",names(FinalDataset))
names(FinalDataset)<-gsub("Acc","Accelerometer_",names(FinalDataset))
names(FinalDataset)<-gsub("Gyro","Gyroscope_",names(FinalDataset))
names(FinalDataset)<-gsub("-mean","Mean_",names(FinalDataset))
names(FinalDataset)<-gsub("-std","StDev_",names(FinalDataset))
names(FinalDataset)<-gsub("[-()]","",names(FinalDataset))

#-------------------------------------------------------------------------------------------------
# 5) Finally, from this dataset we extract a new one with the average of each variable for each activity and each subject.

library(plyr)
AvgDataset<-aggregate(.~Subject+Activity,FinalDataset,mean)
AvgDataset$Activity<-factor(AvgDataset$Activity,levels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
AvgDataset<-arrange(AvgDataset,desc(Activity),Subject)

write.table(AvgDataset, file="tidy_dataset.txt",row.names=FALSE,col.names=TRUE)

