# Run_Analysis-Project
This program runs an analysis on a set of data provided then returns a tidy data set.

Place this script in the UCI HAR Dataset sub-directory of the unzipped directory getdata-projectfiles-UCI HAR Dataset provided in the assignment.

This script will access both the Test and Train subdirectories to load in raw data to R dataframes.

First x_test, y_test, and subject_test files are read into dataframes then merged so that each observation from x_test will correlate to the subject # from subject test, and an activity label from y_test.
