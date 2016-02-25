
dir("C:/Users/ndeye amy fall/Desktop/Rstudio/UCI HAR Dataset")
library(dplyr)
library(plyr)
library(tidyr)
files<-list.files("UCI HAR Dataset")
files
files[5]

##Appending the files

list.files("UCI HAR Dataset/test")
files_full<-list.files("UCI HAR Dataset",full.names = TRUE)
files_full
files_full[1]
con<-file("UCI HAR Dataset/activity_labels.txt","rt")
activity_labels<-read.table(con)
head(activity_labels)
str(activity_labels)
con2<-file("UCI HAR Dataset/features.txt","rt")
features<-read.table(con2)
head(features)
tail(features)
con4<-file("UCI HAR Dataset/features_info.txt","rt")
features_info<-readLines(con4)
head(features_info)

##Appending the files and using the SAC method(split-apply-combine) for data frames

list.files("UCI HAR Dataset/test")
list.files("UCI HAR Dataset/train")
list.files("UCI HAR Dataset/inertial Signals")
files_full_test<-list.files("UCI HAR Dataset/test",full.names = TRUE)
files_full_test
files_full_train<-list.files("UCI HAR Dataset/train",full.names = TRUE)
files_full_train
files_full_Inertial<-list.files("UCI HAR Dataset/test/Inertial Signals",full.names = TRUE)
files_full_Inertial
con1<-read.table(files_full_Inertial[1])
head(con1,10)
tail(con1)
con3<-read.table(files_full_test[2])
head(con3)
summary(files_full_Inertial)
tmp<-vector(mode = "list",length = length(files_full_Inertial))
summary(tmp)
for(i in seq_along(files_full_Inertial)){
  tmp[i]<-read.table(files_full_Inertial[i])
}
str(tmp)
output<-do.call(cbind,tmp)
str(output)
summary(files_full_test[-1])
tmp2<-vector(mode = "list",length = length(files_full_test[-1]))
summary(tmp2)
for(i in seq_along(files_full_test[-1])){
  tmp2[i]<-read.table(files_full_test[-1][i])
}
str(tmp2)
output2<-do.call(cbind,tmp2)
str(output2)
test<-merge(output,output2,all=TRUE)
str(test)
sum(is.na(test))
list.files("UCI HAR Dataset/train/Inertial Signals")
files_full_Inertial3<-list.files("UCI HAR Dataset/train/Inertial Signals",full.names = TRUE)
files_full_Inertial3
summary(files_full_Inertial3)
tmp3<-vector(mode = "list",length = length(files_full_Inertial3))
summary(tmp3)
for(i in seq_along(files_full_Inertial3[i])){
  tmp3[i]<-read.table(files_full_Inertial3[i])
}
str(tmp3)
output3<-do.call(cbind,tmp3)
str(output3)
summary(files_full_train[-1])
tmp4<-vector(mode = "list",length = length(files_full_train[-1]))
summary(tmp4)
for(i in seq_along(files_full_train[-1])){
  tmp4[i]<-read.table(files_full_train[-1][i])
}
str(tmp4)
output4<-do.call(cbind,tmp4)
str(output4)

##Merging data frames

train<-merge(output3,output4,all=TRUE)
str(train)
sum(is.na(train))
activity_test_train<-merge(test,train,all = TRUE)
str(activity_test_train)
head(activity_test_train,10)
sum(is.na(activity_test_train))
good<-complete.cases(activity_test_train)
activity_test_train<-activity_test_train[good, ]
head(activity_test_train,10)
activity<-merge(activity_labels,activity_test_train,all = TRUE)
head(activity,10)
tail(activity,10)
str(activity)
activity_and_features<-merge(activity,features,all = TRUE)
head(activity_and_features,10)
str(activity_and_features)
tail(activity_and_features,10)
activity_and_features_df<-tbl_df(activity_and_features)
head(activity_and_features_df)
tail(activity_and_features_df)
table(activity_and_features_df$V2)
library(reshape2)
dat<-melt(activity_and_features_df, id ="V2")
head(dat)
##tail(dat)
##ddply(dat, "V2", function(x) c(count = nrow(x),
##                               mean = mean(dat$value,na.rm = TRUE),
##                               sd = sd(dat$value,na.rm = TRUE)))

