Introduction:
=============
The goal of this homework is to prepare a “tidy data” set, from data previously collected and summarized by scientist of the “Center of Machine Learning and Intelligent Systems, which can be used for later analysis. The input data and description of the experiment and how this data was collected can be found at the following web site:

o http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

In his research paper “Tidy Data” (http://vita.had.co.nz/papers/tidy-data.pdf), Hadley Wickham states that “Tidy datasets provide a standardized way to link the structure of a dataset (its physical layout) with its semantics (its meaning)”. Author considers a dataset either messy or tidy depending on how rows, columns and tables are matched up with observations, variable and types. In a tidy data:

o Each variable forms a column

o Each observation forms a row

o Each type of observation unit forms a table.

Therefore, “tidy data” makes it easy for an analyst or a computer to extra needed variables because it provides a standard way of structuring a dataset.
An R script (run_analysis.R) was developed that performs the following:

o Changes the original variable names with descriptive variable names.

o Uses descriptive volunteer and activity names in the created dataset

o Extracts only the measurements on the mean and standard deviation for each measurement. 

o Merges the original train and test dataset to create one “tidy dataset” called “FinalData.txt”

o Creates a second dataset, called “AverageBy”, with the average for each variable for each activity.

Script (run_analysis.R) Processing Steps.
========================================
1. Download the “UCi HAR dataset”, unzip, and set your working directory to “UCI HAR dataset”. 
2. Read the “features.txt” file and modified the variable names with descriptive variable names
3. Create an index character vector that contains variables of interest, specifically all variables that are the “mean” and “standard deviation”
4. Read into R the following test datasets: “subject_test.txt”;  “y_test.txt”: & “X_test.txt”.  Modify variable names and select variables of interest.
5. Read into R the following test datasets: “subject_train.txt”;  “y_train.txt”: & “X_train.txt”.  Modify variable names and select variables of interest
6. Create final merged “tidy dataset” (“FinalData”) that contains the test dataset from step 4 and the train dataset from step 5. Update the activity variables with more descriptive names (WALKING; WALKING_UPSTAIRS; WALKING_DOWNSTAIRs; SITTING; STANDING; LAYING)
7. Save / write new dataset (“FinalData”) to a file in a home directory called: “FinalData.txt”
8. This section of the script (“run_analysis.R”) determines the averages by Activity ID and Subject or volunteer ID.
a. Initialize control indexes to traversing the data.frame and defines an empty data.frame (“AverageBy”) to save results
b. Determines average by SubjectID or Volunteers (30). Appends (rbind) results to the AverageBy data.frame
c. Determines average by Activity ID (WALKING; WALKING_UPSTAIRS; WALKING_DOWNSTAIRs; SITTING; STANDING; LAYING). Appends (rbind) results to the AverageBy data.frame.
d. Determines average by ActivityID and SubjectID (or volunteer). Appends (rbind) to the AverageBY data.frame

