# Run_Analysis-Project
This program runs an analysis on a set of data provided then returns a tidy data set.

Place this script in the UCI HAR Dataset sub-directory of the unzipped directory getdata-projectfiles-UCI HAR Dataset provided in the assignment.

The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.  This script will access both the Test and Train subdirectories to load in raw data to R dataframes.

x_test, y_test, and subject_test files are read into dataframes then merged so that each observation from x_test will correlate to the subject # from subject_train, and an activity label from y_test.

x_train, y_train, and subject_train files are read into dataframes then merged so that each observation from x_train will correlate to the subject # from subject_train, and an activity label from y_train.

Each of these dataframes are then merged into one large dataframe for analysis.
An empty dataframe called tidy_data is initialized to store tidy data from analysis, and activity label columns are created for labeling purposes in later steps.

Next, a for loop cycles through all subject labels(for subjects 1-30). For each subject and each activity, the mean value of all features that are measurements of mean or standard deviation is returned then added into the the tidy_data dataframe.

Lastly descriptive column names are added to the tidy_data dataframe, and the data is written to the file "tidy_data.txt"
