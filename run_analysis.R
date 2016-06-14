library("dplyr")

feature_names <- read.table("features.txt")
activity_label <- read.table("activity_labels.txt")

#merge x_test with kolom names i feature_names
test_x_data <- read.table("./test/X_test.txt", col.names = feature_names[,2])

#Mapping activity value (1:6) to name activity
test_y_data <- read.table("./test/Y_test.txt", col.names = "activity")
test_y_datas <- as.factor(test_y_data$activity)
test_y_datas <- data.frame("activity" = revalue(test_y_datas, c("1" = "WALKING","2" = "WALKING_UPSTAIRS", "3" = "WALKING_DOWNSTAIRS", "4" = "SITTING", "5" = "STANDING", "6" = "LAYING")))

#merge, subject, activity and variable
test_subject_data <- read.table("./test/subject_test.txt", col.names = "subject")
test_data <- cbind(test_subject_data,test_y_datas, test_x_data)

#merge x_train with kolom names i feature_names
train_x_data <- read.table("./train/X_train.txt", col.names = feature_names[,2])

#Mapping activity value (1:6) to name activity
train_y_data <- read.table("./train/Y_train.txt", col.names = "activity")
train_y_datas <- as.factor(train_y_data$activity)
train_y_datas <- data.frame("activity" = revalue(train_y_datas, c("1" = "WALKING","2" = "WALKING_UPSTAIRS", "3" = "WALKING_DOWNSTAIRS", "4" = "SITTING", "5" = "STANDING", "6" = "LAYING")))

#merge, subject, activity and variable
train_subject_data <- read.table("./train/subject_train.txt", col.names = "subject")
train_data <- cbind(train_subject_data,train_y_datas,train_x_data)

#merge to raw_data
raw_data <- rbind(test_data, train_data)
raw_data$subject <- as.factor(raw_data$subject)


process_data <- tbl_df(raw_data)
process_data <- group_by(process_data, subject, activity)
tidy_data <- summarise_each(process_data, funs(mean))
                                             
write.table(tidy_data, file = 'tidy.txt', col.names = TRUE, sep = ",", row.names = FALSE )