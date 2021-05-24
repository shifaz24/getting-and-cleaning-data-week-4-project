trainnnn <- read.table("trainnnn.txt")
ytrainnnn <- read.table("ytrainnnn.txt")
subject_train <- read.table("subject_train.txt")


xtesttt <- read.table("xtesttt.txt")
ytestt <- read.table("ytestt.txt")
subject_test <- read.table("subject_test.txt")

featuresss <- read.table("features.txt")

activityLabelssss = read.table("activity_labels.txt")


colnames(trainnnn) <- features[,2]
colnames(ytrainnnn) <- "activityID"
colnames(subject_train) <- "subjectID"

colnames(xtesttt) <- features[,2]
colnames(ytestt) <- "activityID"
colnames(subject_test) <- "subjectID"

colnames(activityLabels) <- c("activityID", "activityType")


alltrain <- cbind(ytrainnnn, subject_train, trainnnn)
alltest <- cbind(ytestt, subject_test, xtesttt)
finaldataset <- rbind(alltrain, alltest)


colNames <- colnames(finaldataset)

meanandstd <- (grepl("activityID", colNames)
               grepl("subjectID", colNames)
               grepl("mean..", colNames)
               grepl("std...", colNames)
)


setforMeanandStd <- finaldataset[ , mean_and_std == TRUE]

setWithActivityNames <- merge(setforMeanandStd, activityLabels,
                              by = "activityID",
                              all.x = TRUE)
tidySet <- aggregate(. ~subjectID + activityID, setWithActivityNames, mean)
tidySet <- tidySet[order(tidySet$subjectID, tidySet$activityID), ]
write.table(tidySet, "tidySet.txt", row.names = FALSE)
