
MAIN LOGIC

STEP 0
Manually down loaded all files and extracted to directories as the not called for to be part of script for this assignment.
Load reference data.
Load test and training data
  - Measurements
  - Activity
  - Subject (referred to as Person)

STEP 1
Get Features required - mean and std for measurements.
Get Activitie and assign column names.  

STEP 2
MERGE as in CBIND and RBIND over test and train data.
Merge can mean many things, here it is JOIN and UNION ALL.
Note positional dependency of cols in X datasets, that is the clue; i.e V421 corresponds to 421 entry in Features.

Assign names to cols of this new dataframe. 

STEP 3
Subset the relevant mean and std dev columns / measures only where measures are concerned.
Point is, should Subject and so also be filtered out? Think not.

STEP 4 
3NF Application look up of the Activity Description. Then remove the ActivityID as we no longer need it.

STEP 5
Apply some logic via gsub returning more menaingful names.  

STEP 6
Create tidy dataset with average of each variable for each Activity and each Subject (Person).

VARIABLES

X_train, Y_train, X_test, Y_test, subject_train, subject_test contain sensor observation and related data from downloaded zip files.

features contains the measurement names that are made.

activityLabels contain the names for the Activities.

all_data holds the initial MERGEd data.

mean_std_data holds the data of interest: subject,activity and measurement / features that are those pertaining to std dev and mean.

tidy_data  is tidied up data set but showing stats for  average of each variable for each Activity and each Subject (Person).


FINAL COMMENTS

Whilst not difficult in hindsight in SQL, it is a lot of stuff that needs to be known in this environment. 1 hr seems ridiculous.

