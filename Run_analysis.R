## ****** STEP 1 ******
## Makes sure that working directory is ./UCI HAR Dataset
## setwd("~/Desktop/Coursera/Assigments/Project-1/UCI HAR Dataset")

## ****** STEP 2 ******
## Read features.txt file and change variables names to more easy to understand
features <- read.table("./features.txt");
          features$V2 <- gsub("[- | \\( | \\) | ,]","", features$V2);
          features$V2 <- gsub("tBody", "TimeBody", features$V2);
          features$V2 <- gsub("Acc", "Acceleration", features$V2);
          features$V2 <- gsub("mean", "Mean", features$V2);
          features$V2 <- gsub("std", "Stdev", features$V2);
          features$V2 <- gsub("tGravity", "TimeGravity", features$V2);
          features$V2 <- gsub("fBody", "FrequencyBody", features$V2);
          features$V2 <- gsub("mFreq", "mFrequency", features$V2);
          features$V2 <- gsub("Mag", "Magnitude", features$V2);

## ****** STEP 3 ******
## Create an "Index" of variables of interest specifically, any variable that is the 
## "Mean or Standard Deviation" of the measurements
## Also a vector that contains a description of the activity levels
Index <- grep("mean|stdev", features$V2, ignore.case = TRUE)
ActivityLabels <- read.table("./activity_labels.txt");

## ****** STEP 4 ******
## Work with test data sets. 
SubjectTest <- read.table("./test/subject_test.txt");
SubjectTest$V1 <- paste("Volunteer-",SubjectTest$V1, sep="");
names(SubjectTest) <- "VolunteerID";

Ytest <- read.table("./test/y_test.txt");
names(Ytest) <- "ActivityID";

Xtest <- read.table("./test/X_test.txt");
names(Xtest) <- features$V2;
TestData <- cbind(SubjectTest, Ytest);
TestData <- cbind(TestData, subset(Xtest, select= c(Index)));

## ****** STEP 5 ******
## Work with train data sets
SubjectTrain <- read.table("./train/subject_Train.txt");
SubjectTrain$V1 <- paste("Volunteer-",SubjectTrain$V1, sep="");
names(SubjectTrain) <- "VolunteerID";

Ytrain <- read.table("./train/y_train.txt");
names(Ytrain) <- "ActivityID";

Xtrain <- read.table("./train/X_train.txt");
names(Xtrain) <- features$V2;
TrainData <- cbind(SubjectTrain, Ytrain);
TrainData <- cbind(TrainData, subset(Xtrain, select= c(Index)));

## ****** STEP 6 ******
## Create a final merged tidy data set that contains the test and train data 
## and updates the variable descriptors
FinalData <- rbind(TrainData, TestData);
FinalData$VolunteerID <- as.factor(FinalData$VolunteerID);
FinalData$ActivityID <- factor(FinalData$ActivityID, labels=ActivityLabels$V2)

## ****** STEP 7 ******
## write to a file "FinalData.txt" in the woorking directory
write.table(FinalData, file = "./FinalData.txt", sep = " ", col.names = TRUE)

## ****** STEP 8 ******
## This section of the code determines mesurement averages BY ActivityID, SubjectID
# ---- FinalData <- read.table("./FinalData.txt") ---- Optinal only needed if starting with new R enviroment
## ****** STEP 8.a ******
# Initialize control parameters that allows traversing the data.frame
MaxSubjectIndex <- length(levels(FinalData$VolunteerID));
MaxActivityIndex <- length(levels(FinalData$ActivityID));
LevelsActivityID <- levels(FinalData$ActivityID);
AverageBy <- FinalData[0, 1:88];

## ****** STEP 8.b ******
##   1- Determine average by SubjectID or Volunteer
for (i in 1:MaxSubjectIndex) {
          temp1 <- subset(FinalData, VolunteerID==paste("Volunteer-",i, sep=""), )
          temp2 <- temp1[1, 1:88];
          temp2[1,2] <- NA
          for (k in 3:88) {
                    temp2[1,k] <- mean(temp1[ ,k]);
          }
          AverageBy <- rbind(AverageBy, temp2)
}

## ****** STEP 8.c ******
##   2- Detremine average by Activity ID
for (j in 1:MaxActivityIndex) {
          temp1 <- subset(FinalData, ActivityID==LevelsActivityID[j], )
          temp2 <- temp1[1, 1:88];
          temp2[1,1] <- NA
          for (k in 3:88) {
                    temp2[1,k] <- mean(temp1[ ,k]);
          }
          AverageBy <- rbind(AverageBy, temp2)
}

## ****** STEP 8.d ******
#   3- Determine average by Activity ID and Subject ID (or Volunteer)
for (j in 1:MaxActivityIndex) {
          for (i in 1:MaxSubjectIndex) {
                    temp1 <- subset(FinalData, VolunteerID==paste("Volunteer-",i, sep="") & ActivityID==LevelsActivityID[j], )
                    temp2 <- temp1[1, 1:88];
                    for (k in 3:88) {
                              temp2[1,k] <- mean(temp1[ ,k]);
                    }
                    AverageBy <- rbind(AverageBy, temp2)
          }
}

## Code Completed

