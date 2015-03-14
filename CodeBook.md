The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project.

This project includes:

(1) a tidy data set as described below
    tidyFileName <- "tidyData.txt"
    
(2) a link to a Github repository with your script for performing

    gitHubLink <- "https://github.com/AlanChudnow/GetCleanDataClassProject"
    The script is called run_analysis.R

(3) a code book that describes the variables, the data,  and any transformations or work that you performed to clean up the data called CodeBook.md.  This file

(4) README.md

BACKGROUND

One of the most exciting areas in all of data science right now is wearable computing - see for example  this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

PROCESSING APPROACH

See run_analysis.R for more details

  (A) Read the zip file from the URL above
  (B) unzip
  (C) Read the following files using the table.read()
        trainXFile <- "./UCI HAR Dataset/train/X_train.txt"
        testXFile <- "./UCI HAR Dataset/test/X_test.txt"
        trainYFile <- "./UCI HAR Dataset/train/Y_train.txt"
        testYFile <- "./UCI HAR Dataset/test/Y_test.txt"
        trainSFile <- "./UCI HAR Dataset/train/subject_train.txt"
        testSFile <- "./UCI HAR Dataset/test/subject_test.txt"
        
        Note: The "X" files have 561 columns that describe specific 
        sensor data and processed data.  The names of each of these 
        fields are described in the file "AC Updated Features.txt"
        
        Note: THe "Y" Files have a 1 column with a number 1 to 6.
        The number indicates a particular activity that was measured
        "WALKING", "WALKING_UPSTAIRS",
        "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"
        
        Note: The "Z" files have 1 column with a number that corresponds
        to a particular subject (volunteer) that performed the activity
        
    

 (D) Merge the Data files as follows
 
     The script merges these miles as follows
     
     FileName <- TidyTestAndTrain.txt 
     
     Description: Merging of the test and training data sets.  
     Format:  CSV file.
     
     Columns: 
         TestTrain - A string "Test" or "Train" give the provinance 
            of the data in terms of the source data sets
     
        ActivityName - A string gives the type of the activity
     
        ActivityNo - Gives the number of the activity 
            as defined in "Y" files
     
        Additional Columns
            The next 561 fields are defined in the file attached files. 
            They have label names are slightly different that the names 
            the attached docs in that "-", "(", and ")" are replaced 
            with "." to meet R restrictions on label names
            
            For information about these fileds see the files
                 feature_info.txt
                 AC Updated Features.txt
                - Background.txt
                
                
             Algorithm notes
            1. This basically binds X,Y data across training & test
            2. Fields are selected that correspond only to mean/var mesures

     
(E) A second data set was created that provides the mean for each numeric data column across each subject and activity type.

     The script merges the data as follows
     
     FileName <- TidyData.txt 
     
     Description: Merging of the test and training data sets.  
     Format:  CSV file.
     
     Columns: 
        .id - A string merging the subject and Activity Name
        
        .subject - A number corresponding to the subject of the test
        
        TestTrain - Ignore
     
        ActivityName - A string gives the type of the activity
     
        ActivityNo - Gives the number of the activity 
            as defined in "Y" files
     
        Additional Columns
            The next 561 fields are defined in the file attached files. 
            They have label names are slightly different that the names 
            the attached docs in that "-", "(", and ")" are replaced 
            with "." to meet R restrictions on label names
            
            These files give the mean of all data sets that 
            correspond to the particular id
            
            For example:  the first row (1.LAYING) provides the mean 
            of all measurements for subject 1 during the activity of layin
            
            For information about these fileds see the files
                 feature_info.txt
                 AC Updated Features.txt
                - Background.txt
                
        Algorithm notes
            1. This basically binds Subject,X,Y data across training & test
            2. Fields are selected that correspond only to mean/var mesures
            3. The data is split by (subject x activity name)
            4. The numberical columns for each split are averaged (mean)
            5. The data is put back together and saved to the file
            
                
     








