#loads the column names (or the list of all features)
column_names <- read.table("features.txt", header=FALSE, sep="")
reference_list <- as.character(column_names[,2])
column_names <- c("subject_number", "activity_label", as.character(column_names[,2]))

#loads in data from x_test file
x_test <- read.table("test/X_test.txt", header=FALSE, sep="", colClasses="numeric")
#reads in a column(variable) which identifies the activity category each observation belongs to
y_test <- read.table("test/Y_test.txt", header=FALSE, sep="")
#reads in a column(variable) which identifies the subject that each observation belongs to
subject_test <- read.table("test/subject_test.txt", header=FALSE, sep="")
#binds all of these data sets together to make one table
x_test <- cbind(subject_test, y_test, x_test)
#labels the table's columns(variables)
colnames(x_test) <- column_names

#loads in data from x_train file
x_train <- read.table("train/x_train.txt", header=FALSE, sep="", colClasses="numeric")
#reads in a column(variable) which identifies the activity category each observation belongs to
y_train <- read.table("train/Y_train.txt", header=FALSE, sep="")
#reads in a column(variable) which identifies the subject that each observation belongs to
subject_train <- read.table("train/subject_train.txt", header=FALSE, sep="")
#binds all of these data sets together to make one table
x_train <- cbind(subject_train,y_train,x_train)
#labels the table's columns(variables)
colnames(x_train) <- column_names

#binds both previous tables to put all data into one data table
data <- rbind(x_test, x_train)

#This part subsets the "data" table so only columns with std or mean in the name remain
filterlist <- c("subject_number", "activity_label", as.character(column_names[grep("mean|std",column_names)]))
data <- data[filterlist]

#initializes tidy data data frame and column names for this tidy data
tidy_data <- data.frame()
tidy_column_names <- c("Subject","Activity","Feature","Mean")
#This vector is used to parse extraneous data from tables later
remove <-  c(-1,-2)
#creates activity columns to identify activity each observation belongs to
tidy_activity_label1 <- rep("Walking", length(filterlist))
tidy_activity_label2 <- rep("Walking_Upstairs", length(filterlist))
tidy_activity_label3 <- rep("Walking_Downstairs", length(filterlist))
tidy_activity_label4 <- rep("Sitting", length(filterlist))
tidy_activity_label5 <- rep("Standing", length(filterlist))
tidy_activity_label6 <- rep("Laying", length(filterlist))
#This loop produces tidy data for each subject in the test
for(n in 1:30)
{
    #creates a subject label column to identify the subject each observation belongs to
    tidy_subject <- rep(n, length(filterlist))
    
    #following blocks find the means of each feature with respect to subject number and activity
    tidyrow <- colMeans(subset(data, subject_number==n & activity_label == 1))
    tidy_table1 <- rbind(tidy_subject, tidy_activity_label1, filterlist, tidyrow)
    #transpose
    tidy_table1 <- t(tidy_table1)
    #parse extraneous data
    tidy_table1 <- tidy_table1[remove,]
    
    tidyrow <- colMeans(subset(data, subject_number==n & activity_label == 2))
    tidy_table2 <- rbind(tidy_subject, tidy_activity_label2, filterlist, tidyrow)
    #transpose
    tidy_table2 <- t(tidy_table2)
    #parse extraneous data
    tidy_table2 <- tidy_table2[remove,]
    
    tidyrow <- colMeans(subset(data, subject_number==n & activity_label == 3))
    tidy_table3 <- rbind(tidy_subject, tidy_activity_label3, filterlist, tidyrow)
    #transpose
    tidy_table3 <- t(tidy_table3)
    #parse extraneous data
    tidy_table3 <- tidy_table3[remove,]
    
    tidyrow <- colMeans(subset(data, subject_number==n & activity_label == 4))
    tidy_table4 <- rbind(tidy_subject, tidy_activity_label4, filterlist, tidyrow)
    #transpose
    tidy_table4 <- t(tidy_table4)
    #parse extraneous data
    tidy_table4 <- tidy_table4[remove,]
    
    tidyrow <- colMeans(subset(data, subject_number==n & activity_label == 5))
    tidy_table5 <- rbind(tidy_subject, tidy_activity_label5, filterlist, tidyrow)
    #transpose
    tidy_table5 <- t(tidy_table5)
    #parse extraneous data
    tidy_table5 <- tidy_table5[remove,]
    
    tidyrow <- colMeans(subset(data, subject_number==n & activity_label == 6))
    tidy_table6 <- rbind(tidy_subject, tidy_activity_label6, filterlist, tidyrow)
    #transpose
    tidy_table6 <- t(tidy_table6)
    #parse extraneous data
    tidy_table6 <- tidy_table6[remove,]
    
    #insures all column names for tables generated above are the same
    #to prevent row bind issues
    colnames(tidy_table1) <- NULL
    colnames(tidy_table2) <- NULL
    colnames(tidy_table3) <- NULL
    colnames(tidy_table4) <- NULL
    colnames(tidy_table5) <- NULL
    colnames(tidy_table6) <- NULL
    
    #Binds all data for current subject to tidy data table
    tidy_data <- rbind(tidy_data, tidy_table1,tidy_table2,tidy_table3,tidy_table4,tidy_table5,tidy_table6)
}

#writes tidy data to output file
colnames(tidy_data) <- tidy_column_names
write.table(tidy_data, file="tidy_data.txt", row.names=FALSE, sep=",")

