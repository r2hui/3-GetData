# 3-GetData
Get Data - Course Project
run_analysis.R is a function that takes data from the human activity recognition using smartphones data set.
There were 30 volunteers, labelled 1 to 30 in the "subject" column.
There were 6 activities, labelled 1 to 6 in the "activity" column.
561 measurements (not raw data) are found within the 561 columns.
There are 2 sets: test and train, with different number of observations.

Required R packages: reshape, reshape2

The first step of the script is to combine all the data, along with pertinent measurement descriptions names in the columns.

The second step is to extract a smaller subset of the data that includes only mean and standard deviation data.

The third step involves replacing integer information on activity to text descriptions. For example, 1 is WALKING, 2 is WALKING_UPSTAIRS, etc. This information is located in activity_labels.txt.

Minor cleanup of the measurement description names is made. Here the substrRight(x) function is a separate .R file to remove the last 4 characters of a text string. This improves readability.

The fourth step is to melt the data.frame. This step takes the wide format data and turns into long format. Subject and activity are ID, while the other measurement data (18 columns) are variables.

The fifth step is to recast the molten data to find the average for each activity and for each subject. 

Finally the sixth step is to write the resultant data frame to a text file.

