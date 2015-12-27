# Download and process UCI HAR Dataset, producing a tidy dataset with the mean
#  of all -mean() and -std() variables, and the codebook with all column names.

## Load the neccesary libraries
library(data.table)
library(dplyr)

#Download the data and decompress the zip file

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "proj.zip", method = "curl")
unzip("proj.zip")

#Record the date

dateDownloaded <- date()
dateDownloaded
# Rename the directory for easier coding process
file.rename("UCI HAR Dataset", "UCI_HAR_Dataset")

# Read the feature names into the features object
features <- read.table("UCI_HAR_Dataset/features.txt")

# Read the x train and test data files into a data frame with the names from feature
xTrain <- read.table("UCI_HAR_Dataset/train/X_train.txt", header = FALSE, col.names = features$V2)
xTest <- read.table("UCI_HAR_Dataset/test/X_test.txt", header = FALSE, col.names = features$V2)

# Join the two objects

x <- rbind(xTrain, xTest)

# Use data.table for performance

x <- data.table(x)

# Select everything with std and mean, but not meanFreq
x1 <- select(x, matches("\\.std|\\.mean"))
x2 <- select(x1, -matches("meanFreq"))

# 
# Read the train and test from subject and the y data
subjectTrain <- data.table(read.table("UCI_HAR_Dataset/train/subject_train.txt",
                           header = FALSE, col.names = c("Subject")))
subjectTest <- data.table(read.table("UCI_HAR_Dataset/test/subject_test.txt",
                           header = FALSE, col.names = c("Subject")))
yTrain <- data.table(read.table("UCI_HAR_Dataset/train/y_train.txt",
                           header = FALSE, col.names = c("Activity")))
yTest <- data.table(read.table("UCI_HAR_Dataset/test/y_test.txt",
                           header = FALSE, col.names = c("Activity")))

# Join the subject and y data with the x data and write the table of tidy data.
subject <- rbind(subjectTrain, subjectTest)
y <- rbind(yTrain, yTest)
data <- cbind(x2, subject, y)
d1 <- group_by(data, Activity, Subject) %>% summarise_each(funs(mean))
write.table(d1, file="tidyData.txt")
