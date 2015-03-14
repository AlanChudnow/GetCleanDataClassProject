#run_analysis.r

# Background
# This file was generated for the Courera couse 
# https://class.coursera.org/getdata-012/human_grading/view/courses/973499/assessments/3/submissions
#
# The purpose of this project is to demonstrate your ability to collect, 
# work with, and clean a data set. The goal is to prepare tidy data that 
# can be used for later analysis. You will be graded by your peers on a 
# series of yes/no questions related to the project. You will be required
# to submit: 
#    1) a tidy data set as described below
    tidyFileName <- "tidyData.txt"
    

#    2) a link to a Github repository with your script for performin
#    the analysis,
    gitHubLink <- "https://github.com/AlanChudnow/GetCleanDataClassProject"
    
#    3) a code book that describes the variables, the data, 
#      and any transformations or work that you performed to clean up 
#      the data called CodeBook.md. You should also include a 
#     README.md in the repo with your scripts. This repo explains 
#    how all of the scripts work and how they are connected.  
#
#  One of the most exciting areas in all of data science right now is 
#  wearable computing - see for example  this article . Companies like 
#  Fitbit, Nike, and Jawbone Up are racing to develop the most advanced 
#  algorithms to attract new users. The data linked to from the course 
#  website represent data collected from the accelerometers from the 
#  Samsung Galaxy S smartphone. A full description is available at the 
#  site where the data was obtained: 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

#library(reshape2)
library(plyr)


#1.Merges the training and the test sets to create one data set.

# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "UCIHAR.zip"
download.file(url,zipfile)
unzip(zipfile)

ActivityLabel <- c("WALKING", "WALKING_UPSTAIRS","WALKING_DOWNSTAIRS",
                   "SITTING", "STANDING", "LAYING")

trainXFile <- "./UCI HAR Dataset/train/X_train.txt"
trainYFile <- "./UCI HAR Dataset/train/Y_train.txt"
testXFile <- "./UCI HAR Dataset/test/X_test.txt"
testYFile <- "./UCI HAR Dataset/test/Y_test.txt"

trainX <- read.table(trainXFile,header=FALSE)
trainY <- read.table(trainYFile,header=FALSE, col.names=c("Label"))
testX <- read.table(testXFile,header=FALSE)
testY <- read.table(testYFile,header=FALSE, col.names=c("Label"))

mergeTrain <- data.frame( TestTrain = rep("Train",length(trainY$Label)),
                          ActivityName = ActivityLabel[trainY$Label],
                          ActivityNo = trainY$Label,
                          trainX)

mergeTest <- data.frame( TestTrain = rep("Test",length(testY$Label)),
                          ActivityName = ActivityLabel[testY$Label],
                          ActivityNo = testY$Label,
                          testX)

mergeAll <- rbind(mergeTest, mergeTrain)


#2.Extracts only the measurements on the mean and standard deviation for each measurement. 

sColsTitles <- "1 tBodyAcc.mean().X
2 tBodyAcc.mean.Y
3 tBodyAcc.mean.Z
4 tBodyAcc.std.X
5 tBodyAcc.std.Y
6 tBodyAcc.std.Z
41 tGravityAcc.mean.X
42 tGravityAcc.mean.Y
43 tGravityAcc.mean.Z
44 tGravityAcc.std.X
45 tGravityAcc.std.Y
46 tGravityAcc.std.Z
81 tBodyAccJerk.mean.X
82 tBodyAccJerk.mean.Y
83 tBodyAccJerk.mean.Z
84 tBodyAccJerk.std.X
85 tBodyAccJerk.std.Y
86 tBodyAccJerk.std.Z
121 tBodyGyro.mean.X
122 tBodyGyro.mean.Y
123 tBodyGyro.mean.Z
124 tBodyGyro.std.X
125 tBodyGyro.std.Y
126 tBodyGyro.std.Z
161 tBodyGyroJerk.mean.X
162 tBodyGyroJerk.mean.Y
163 tBodyGyroJerk.mean.Z
164 tBodyGyroJerk.std.X
165 tBodyGyroJerk.std.Y
166 tBodyGyroJerk.std.Z
201 tBodyAccMag.mean
202 tBodyAccMag.std
214 tGravityAccMag.mean
215 tGravityAccMag.std
240 tBodyGyroMag.mean
241 tBodyGyroMag.std
266 fBodyAcc.mean.X
267 fBodyAcc.mean.Y
268 fBodyAcc.mean.Z
269 fBodyAcc.std.X
270 fBodyAcc.std.Y
271 fBodyAcc.std.Z
345 fBodyAccJerk.mean.X
346 fBodyAccJerk.mean.Y
347 fBodyAccJerk.mean.Z
348 fBodyAccJerk.std.X
349 fBodyAccJerk.std.Y
350 fBodyAccJerk.std.Z
424 fBodyGyro.mean.X
425 fBodyGyro.mean.Y
426 fBodyGyro.mean.Z
427 fBodyGyro.std.X
428 fBodyGyro.std.Y
429 fBodyGyro.std.Z
503 fBodyAccMag.mean
504 fBodyAccMag.std
516 fBodyBodyAccJerkMag.mean
517 fBodyBodyAccJerkMag.std
529 fBodyBodyGyroMag.mean
530 fBodyBodyGyroMag.std
542 fBodyBodyGyroJerkMag.mean
543 fBodyBodyGyroJerkMag.std"


ColTitleVec <- strsplit(sColsTitles,"[ \t\r\n\f]")[[1]]
pullRows = c(1,2,3, 3+as.numeric(ColTitleVec[seq(1,length(ColTitleVec),2)]))
newNames = c("TestTrain","ActivityName","ActivityNum",
             ColTitleVec[seq(2,length(ColTitleVec),2)])

mergeMS <- mergeAll[,pullRows]


#3.Uses descriptive activity names to name the activities in the data set

# See above in Step 1.  This was done in creating

#4.Appropriately labels the data set with descriptive variable names. 


names(mergeMS)<-newNames
write.table(mergeMS,"Merged.csv",row.names=FALSE,sep=",")
write.table(mergeMS,"TidyTestAndTrain.txt",row.names=FALSE,sep=",")  

    
#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#

trainSFile <- "./UCI HAR Dataset/train/subject_train.txt"
testSFile <- "./UCI HAR Dataset/test/subject_test.txt"

trainS <- read.table(trainSFile,header=FALSE)
testS <- read.table(testSFile,header=FALSE)

mergeS <- rbind(trainS, testS)
mergeAll2 <- data.frame(subject= mergeS[,1], mergeMS)
write.table(mergeAll2,"MergedS.csv",row.names=FALSE,sep=",")

g<-list(mergeAll2$subject,mergeAll2$ActivityName)
s<-split(mergeAll2,g)
sl <- lapply(s, function(df){c(df[1,1:4], colMeans(df[,4:66]))})
u<-ldply(sl,data.frame)
write.table(u,"MeansBySubjectActivity.csv",row.names=FALSE,sep=",")
write.table(u,tidyFileName,row.names=FALSE,sep=",")



#trainXstring <- readChar(trainXFile, file.info(trainXFile)$size)
#trainXvec <- strsplit(trainXstring,"[ \t\r\n\f]")
#trainXnum <- as.numeric(trainXvec[[1]])
#trainXnum2 <- trainXnum[!is.na(trainXnum)]
#table(is.na(trainXnum))
#trainYstring <- readChar(trainYFile, file.info(trainYFile)$size)
#trainYvec <- strsplit(trainYstring,"[ \t\r\n\f]")
#mMelt <-melt(mergeAll2, id=c("subject","ActivityName"), measure.vars=ColTitleVec[seq(2,length(ColTitleVec),2)])



