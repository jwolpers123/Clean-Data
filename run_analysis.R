
########## 1) Merges the training and the test sets to create one data set.
library(dplyr)

## setwd("yourworkdirectory")

############# read column names ################

features<-read.table(file="features.txt")


########### read test data #############

xtest<-read.table(file="./test/X_test.txt")

ytest<-read.table(file="./test/y_test.txt")

subjTest<-read.table(file="./test/subject_test.txt")

test_df<-cbind(ytest, subjTest , xtest)



########## read train data ##############


xtrain<-read.table(file="./train/X_train.txt")

ytrain<-read.table(file="./train/y_train.txt")

subjTrain<-read.table(file="./train/subject_train.txt")

train_df<-cbind(ytrain,subjTrain, xtrain  )

######### combine test and train data ###############

final_df<-rbind(test_df, train_df)

######## 4) Appropriately labels the data set with descriptive variable names. 
##########  set column names ##########

names(final_df)<-( c("activity", "participant_nr",  as.character(features[,2])))

######### 3) Uses descriptive activity names to name the activities in the data set
########## set activity names ################

final_df[[1]] <- replace(final_df[[1]], final_df[[1]] == 1, "WALKING")
final_df[[1]] <- replace(final_df[[1]], final_df[[1]] == 2, 
                         "WALKING_UPSTAIRS")
final_df[[1]] <- replace(final_df[[1]], final_df[[1]] == 3, 
                         "WALKING_DOWNSTAIRS")
final_df[[1]] <- replace(final_df[[1]], final_df[[1]] == 4, "SITTING")
final_df[[1]] <- replace(final_df[[1]], final_df[[1]] == 5, "STANDING")
final_df[[1]] <- replace(final_df[[1]], final_df[[1]] == 6, "LAYING")

#################### test ##################################

###dim(final_df)

###head(names(final_df))
####### 2) Extracts only the measurements on the mean and standard deviation for each measurement. 

########### find column names with mean and std #########################  

mean_columns<-grep("mean", names(final_df)); str(mean_columns)

stDev_columns<-grep("std", names(final_df)); str(stDev_columns)

Just_MeanAndStd_Index<-c(mean_columns, stDev_columns)


############## Df with means and std #####################################

Just_MeanAndStd_Index<-t(Just_MeanAndStd_Index)

meanStd_Df<-final_df[,c(2,1,Just_MeanAndStd_Index)]; dim(meanStd_Df)

########### 5) From the data set in step 4, creates a second, 
############ independent tidy data set with the average of each variable for each activity and each subject.
############# Tidy Df ###############

#B<-3:563
#names(meanStd_Df)[3:563]<-B  ###### rename columns to avoid conflict with summarize_all function #####

tidy_df <- meanStd_Df  %>% group_by(activity, participant_nr) %>% summarize_all(funs(mean))
tidy_df <- (arrange(tidy_df, participant_nr, activity))
#names(tidy_df)<- c("activity", "participant_nr",  as.character(features[,2]))  #### reset column names

############# test ##################

### dim(tidy_df) #### tidy_df has 180 columns i.e. number of participants times number of activities   

######### write tidy data to csv
write.table(tidy_df, file = "./tidydata.txt", row.name=FALSE)