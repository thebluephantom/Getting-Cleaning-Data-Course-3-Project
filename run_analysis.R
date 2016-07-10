# Course Project for Data Science Course 3
# Following instructions and reading the various week's notes and cobbling together with a little lack of appreciating the full picture initially.
# Assignment vague, but worked it out. I can't see 3 to 4 hrs a week here, it's complete rubbish such statements. 
# Gerard Alexander, 10/7/2016, late in the evening.

# Unclear assignment, but appears to be to merge all TRAIN & TEST data sets into 561 + 1 + 1 into 563 variables for N + M observations for training and test.
# x are the measurements that point to Features table; the values are the foreign keys as it were.
# y are the activities that we look at activity labels and have a positional dependency; foreign keys as it were.
# subject_train represent who did the activity and have a positional dependency. We talk of Person.
# Like relational tables being denormalized into 1 row.

# STEP 0
# Manually down loaded all files and extracted to directories as the not called for to be part of script for this assignment.
# Load reference data.
# Load any packages.

# TRAIN DATA.
X_train <- read.table("C:/Users/Gerard/Desktop/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("C:/Users/Gerard/Desktop/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("C:/Users/Gerard/Desktop/UCI HAR Dataset/train/subject_train.txt")

# TEST data
X_test <- read.table("C:/Users/Gerard/Desktop/UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("C:/Users/Gerard/Desktop/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("C:/Users/Gerard/Desktop/UCI HAR Dataset/test/subject_test.txt")

# STEP 1
# Get Features and make a list of only the mean and std features that will be used for subsetting, merging.

features <- read.table("C:/Users/Gerard/Desktop/UCI HAR Dataset/features.txt", colClasses= c("character"))
# Need colclasses else error later with column names assignment.

mean_std_features_ofInterest <- grep("mean|std", tolower(features[,2]))
mean_std_features_ofInterest_Values <-  features[mean_std_features_ofInterest,2]
mean_std_features_ofInterest_Values2 <-  features[mean_std_features_ofInterest,]t
# Later if want to JOIN with this .... this one or do a subset ... 
# mmm then it states we need only cols with mean and std -> unclear if we need to remove subsequently JOINed / MERGEd data like Person as well !!!
# Decision to leave in. English at coursera open to interpretation.

# Get Activities.
activityLabels <- read.table("C:/Users/Gerard/Desktop/UCI HAR Dataset/activity_labels.txt", col.names = c("ActivityID", "ActivityName"))

# STEP 2
# MERGE as in CBIND and RBIND as it states in assignment. Which makes sense. Merge can mean many things, here it is JOIN and UNION ALL.
# Note positional dependency of cols in X dataset, that is the clue; i.e V421 corresponds to 421 entry in Features.
# CBIND TRAINING
train_data <- cbind(cbind(X_train, Y_train), subject_train)
# CBIND TEST
test_data <- cbind(cbind(X_test, Y_test), subject_test)
# RBIND ALL
all_data <- rbind(train_data, test_data)

# Assign names to cols, noting the 561 cols that have positional dependencies with features, but we want the string not the number.
all_data_col_names <- rbind(rbind(features, c(562, "ActivityID")), c(563, "Person"))[,2]
names(all_data) <- all_data_col_names
head(all_data)
# all_data may not be such a good name, as is not eventually all sensor data, initially it is though. Take second element.

#head(X_train, 1)
#head(all_data,1)

# STEP 3
# Get relevant mean and std dev columns / measures only.
# Point is, should Subject and so also be filtered out? Think not.
mean_std_data <- all_data[,grepl("mean|std|Person|ActivityID",names(all_data))] 
#dim(all_data)
#dim(mean_std_data)
#head(mean_std_data3)

# STEP 4
# 3NF Application look up the Activity Description.
# Remove the "foreign key" as it were.
mean_std_data2 <- join(mean_std_data, activityLabels, by = "ActivityID")
mean_std_data3 <- subset(mean_std_data2, select=-c(ActivityID))

# STEP 5
# Not sure what valid names really mean here. Presume () and not the t and f prefixes.
names(mean_std_data3) <- gsub('\\(|\\)', "", names(mean_std_data3), perl = TRUE)
names(mean_std_data3) <- gsub('Acc', "Acceleration", names(mean_std_data3))
names(mean_std_data3) <- gsub('Gyro', "AngularSpeed", names(mean_std_data3))
names(mean_std_data3) <- gsub('Gyrojerk', "AngularAcceleration", names(mean_std_data3))
names(mean_std_data3) <- gsub('Mag', "Magnitude", names(mean_std_data3))
names(mean_std_data3) <- gsub('Freq', "Frequency", names(mean_std_data3))

# STEP 6
# Create tidy dataset with average of each variable for each Activity and each Subject (Person)
tidy_data <- ddply(mean_std_data3, c("ActivityName", "Person"), numcolwise(mean))
write.table(tidy_data, file="tidy.txt", row.name=FALSE)
#head(tidy_data)

# FINAL COMMENTS: Whilst not difficult in hindsight in SQL, it is a lot of stuff that needs to be known in this environment. 1 hr seems ridiculous.

