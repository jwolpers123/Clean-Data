Copy run_analysis.R into the unziped coursera Datasetfile
Execute the script to gain tidydata.txt

tidydata.txt contains the activity, the participant_nr and all variables of the originalfile which contain "mean" or "std", so that it is only the mean or the standard deviation of the values. It is sorted after participant_nr and activity.

run_analysis.R does the following:

    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement.
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names.
    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
