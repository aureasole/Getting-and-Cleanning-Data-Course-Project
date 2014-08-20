run.analysis<-function(dir){
## 1. ----------------------------------------------------------------------------------------------------------

setwd("C:/Users/Àurea/Coursera courses/Getting and cleanning data/Course Project")
activity_labels<-read.table("activity_labels.txt")
features<-read.table("features.txt")

#TEST

print("Reading test file")
setwd(dir,"test")
subject_test<-read.table("subject_test.txt")
names(subject_test)<-"subject"
y_test<-read.table("y_test.txt")
names(y_test)<-"activity"
x_test<-read.table("x_test.txt")
#we name the features ("tBoddyAcc-mean()-X" instead of 1,etc)
names(x_test)<-features[,2]

test<-cbind(subject_test, y_test, x_test)


#TRAIN

print("Reading train file")
setwd(dir,"train")
subject_train<-read.table("subject_train.txt")
names(subject_train)<-"subject"
y_train<-read.table("y_train.txt")
names(y_train)<-"activity"
x_train<-read.table("x_train.txt")
names(x_train)<-features[,2]

train<-cbind(subject_train, y_train, x_train)

#I merge the TEST and TRAIN sets. the name of the data set created is df
print("Mergint the two sets to create only one data set")
df<-rbind(test,train)


##the rows are the observations of test (from 1 to 10299 observations)
##the columns are:

##   1st->subject test : the subject who has completed the test (it could be from person 1 to person 30)
#    2nd->the labels : the exercice which has made the subject (walking, walking downstairs, etc.)
#    from 3rd to 563rd : the features (tBoddyAcc-mean()-X, tBodyAcc-mean()-Y, etc.)


##2. ----------------------------------------------------------------------------------------------------------

##My consideration in this step has been to exctract only those columns which are included "mean" or "std
##I've used the grepl function to extract only the columns whose name include the word "mean" and "std"

print("subsetting the mean and the standard deviation features")
mean<-df[,grepl("mean", names(df))]
std<-df[,grepl("std", names(df))]
df<-cbind(df[,1:2], mean,std)
#So the data set only includes subject, activity and the subsetted measuraments(mean and std ones).

##3. ----------------------------------------------------------------------------------------------------------

##I name the activities, on the 2nd column of the df ("walking" instead of 1, walking upstairs instead of 2,etc..)
#every "number" of activity is changed for the name of activity label that correspond at this number(based on activity_labels data set)

df[,2]<-activity_labels[df[,2],2]


##4. ----------------------------------------------------------------------------------------------------------

#I've previously fixed the names of every column of the df. (tBodyAcc-mean()-X instead of 1, tBodyAcc-mean()-Y instead of 2,etc)
#> names(df[,1:10])
#[1] "subject"               "activity"              "tBodyAcc-mean()-X"     "tBodyAcc-mean()-Y"    
#[5] "tBodyAcc-mean()-Z"     "tGravityAcc-mean()-X"  "tGravityAcc-mean()-Y"  "tGravityAcc-mean()-Z" 
#[9] "tBodyAccJerk-mean()-X" "tBodyAccJerk-mean()-Y"

##5. ----------------------------------------------------------------------------------------------------------

##I've used the small agregated data set of step 2 (only mean and std measuraments)

library(reshape2) 

print("Creating the tidy data set with the average of each variable for each activity and each subject")
#melting
wide.data<-melt(df, id = c("subject", "activity"))

#dcasting
cdata<-dcast(wide.data, subject+activity~variable, fun.aggregate=mean)

#saving the data into a file
cfile<-file.path(dir, clean.file)

write.table(cdata, file= cfile, row.names = FALSE, quote=FALSE)

}
