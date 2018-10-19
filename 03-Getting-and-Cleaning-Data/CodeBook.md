# Project Code Book

## R version and libraries
The script was developed with RStudio Version 1.1.456.

I used `R version 3.4.4` and the following libraries.

```r
# Load the packages
library(dplyr, warn.conflicts = FALSE)
library(readr)   # for read_table > tibble
library(tidyr)   # for separate
library(stringr)  # consolde tests only, not used
```

Here is the full list of loaded package (sorted by name) and their versions:

| Package | Version |
| --- | :---: |
| assertthat | 0.2.0 |
| assertthat | 0.2.0 | 
| base | 3.4.4 | 
| bindr | 0.1.1 | 
| bindrcpp | 0.2.2 | 
| compiler | 3.4.4 | 
| crayon | 1.3.4 | 
| datasets | 3.4.4 | 
| dplyr | 0.7.6 | 
| glue | 1.3.0 | 
| graphics | 3.4.4 | 
| grDevices | 3.4.4 | 
| hms | 0.4.2 | 
| magrittr | 1.5 | 
| methods | 3.4.4 | 
| pillar | 1.3.0 | 
| pkgconfig | 2.0.2 | 
| purrr | 0.2.5 | 
| R6 | 2.3.0 | 
| Rcpp | 0.12.19 | 
| readr | 1.1.1 | 
| rlang | 0.2.2 | 
| rstudioapi | 0.8 | 
| stats | 3.4.4 | 
| stringi | 1.2.4 | 
| stringr | 1.3.1 | 
| tibble | 1.4.2 | 
| tidyr | 0.8.1 | 
| tidyselect | 0.2.5 | 
| tools | 3.4.4 | 
| utils | 3.4.4 | 
| yaml | 2.2.0 | 


## Folder structure

:warning: If you are running the script in R Studio, the script will try to change the `current path` to the `script path`. Otherwise it will use the current path.

The script will create 3 sub folders in the current folder:
- data**zip** : contains the original datasets ZIP file
- data : contains the original extracted files
- data**rds** : contains dataset saved objects (.RDS)

## Original data download

The script downloads the original project data sets :
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
and save it as `projectfiles.zip` in the datazip folder.
If the `projectfiles.zip` file already exists, the script will **not** reload it.

In all the cases, the script unzips its content in the `data` folder.


## Project steps

All the steps are detailed in the code.

The main run_analysis.R steps are :

- Merges the training and the test sets to create one data set.
  - For the Train and Test files:
    - Read the subject_xxx.txt / X_xxx.txt / Y_xxx.txt files
    - Merged them by column
    - Appended the result to the main data set
- Extracts only the measurements on the mean and standard deviation for each measurement.
  - Only the original features containing -std() or -mean() were kept
- Uses descriptive activity names to name the activities in the data set
  - Activity Ids were replaced by their associated label (found in the activities.txt file)
- Appropriately labels the data set with descriptive variable names.
  - Replaced the t/f first letter by time or fft
  - Replaced the X/Y/Z axis by For(X/Y/Z)Axis
  - Replaced -std() and -mean() by MeanValue and StandardDeviation
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Save the final data set

The last dataset was saved using the following command:
```r
write.table(avgdata, 
            'project_dataset_step5.txt',
            row.names = FALSE)
```

To reload it:

```r
myobj <- read.table('project_dataset_step5.txt',
                    header=TRUE)
```

## Project final data set features

This following table contains the features of the final project data set (step 5). The last column contains the name of the original ones.

Only the mean and standard deviation features were kept for the project assignment.

The original features can be found in the project package or in the [original_features_info.txt](original_features_info.txt) file


| Column Name | Sensor | Initial feature name |
| --- | --- | --- |
| activity |  |  |
| subject |  |  |
| timeBodyAccMeanValueForXaxis | BodyAcc | tBodyAcc-mean()-X |
| timeBodyAccMeanValueForYaxis | BodyAcc | tBodyAcc-mean()-Y |
| timeBodyAccMeanValueForZaxis | BodyAcc | tBodyAcc-mean()-Z |
| timeBodyAccStandardDeviationForXaxis | BodyAcc | tBodyAcc-std()-X |
| timeBodyAccStandardDeviationForYaxis | BodyAcc | tBodyAcc-std()-Y |
| timeBodyAccStandardDeviationForZaxis | BodyAcc | tBodyAcc-std()-Z |
| timeGravityAccMeanValueForXaxis | GravityAcc | tGravityAcc-mean()-X |
| timeGravityAccMeanValueForYaxis | GravityAcc | tGravityAcc-mean()-Y |
| timeGravityAccMeanValueForZaxis | GravityAcc | tGravityAcc-mean()-Z |
| timeGravityAccStandardDeviationForXaxis | GravityAcc | tGravityAcc-std()-X |
| timeGravityAccStandardDeviationForYaxis | GravityAcc | tGravityAcc-std()-Y |
| timeGravityAccStandardDeviationForZaxis | GravityAcc | tGravityAcc-std()-Z |
| timeBodyAccJerkMeanValueForXaxis | BodyAccJerk | tBodyAccJerk-mean()-X |
| timeBodyAccJerkMeanValueForYaxis | BodyAccJerk | tBodyAccJerk-mean()-Y |
| timeBodyAccJerkMeanValueForZaxis | BodyAccJerk | tBodyAccJerk-mean()-Z |
| timeBodyAccJerkStandardDeviationForXaxis | BodyAccJerk | tBodyAccJerk-std()-X |
| timeBodyAccJerkStandardDeviationForYaxis | BodyAccJerk | tBodyAccJerk-std()-Y |
| timeBodyAccJerkStandardDeviationForZaxis | BodyAccJerk | tBodyAccJerk-std()-Z |
| timeBodyGyroMeanValueForXaxis | BodyGyro | tBodyGyro-mean()-X |
| timeBodyGyroMeanValueForYaxis | BodyGyro | tBodyGyro-mean()-Y |
| timeBodyGyroMeanValueForZaxis | BodyGyro | tBodyGyro-mean()-Z |
| timeBodyGyroStandardDeviationForXaxis | BodyGyro | tBodyGyro-std()-X |
| timeBodyGyroStandardDeviationForYaxis | BodyGyro | tBodyGyro-std()-Y |
| timeBodyGyroStandardDeviationForZaxis | BodyGyro | tBodyGyro-std()-Z |
| timeBodyGyroJerkMeanValueForXaxis | BodyGyroJerk | tBodyGyroJerk-mean()-X |
| timeBodyGyroJerkMeanValueForYaxis | BodyGyroJerk | tBodyGyroJerk-mean()-Y |
| timeBodyGyroJerkMeanValueForZaxis | BodyGyroJerk | tBodyGyroJerk-mean()-Z |
| timeBodyGyroJerkStandardDeviationForXaxis | BodyGyroJerk | tBodyGyroJerk-std()-X |
| timeBodyGyroJerkStandardDeviationForYaxis | BodyGyroJerk | tBodyGyroJerk-std()-Y |
| timeBodyGyroJerkStandardDeviationForZaxis | BodyGyroJerk | tBodyGyroJerk-std()-Z |
| timeBodyAccMagMeanValue | BodyAccMag | tBodyAccMag-mean() |
| timeBodyAccMagStandardDeviation | BodyAccMag | tBodyAccMag-std() |
| timeGravityAccMagMeanValue | GravityAccMag | tGravityAccMag-mean() |
| timeGravityAccMagStandardDeviation | GravityAccMag | tGravityAccMag-std() |
| timeBodyAccJerkMagMeanValue | BodyAccJerkMag | tBodyAccJerkMag-mean() |
| timeBodyAccJerkMagStandardDeviation | BodyAccJerkMag | tBodyAccJerkMag-std() |
| timeBodyGyroMagMeanValue | BodyGyroMag | tBodyGyroMag-mean() |
| timeBodyGyroMagStandardDeviation | BodyGyroMag | tBodyGyroMag-std() |
| timeBodyGyroJerkMagMeanValue | BodyGyroJerkMag | tBodyGyroJerkMag-mean() |
| timeBodyGyroJerkMagStandardDeviation | BodyGyroJerkMag | tBodyGyroJerkMag-std() |
| fftBodyAccMeanValueForXaxis | BodyAcc | fBodyAcc-mean()-X |
| fftBodyAccMeanValueForYaxis | BodyAcc | fBodyAcc-mean()-Y |
| fftBodyAccMeanValueForZaxis | BodyAcc | fBodyAcc-mean()-Z |
| fftBodyAccStandardDeviationForXaxis | BodyAcc | fBodyAcc-std()-X |
| fftBodyAccStandardDeviationForYaxis | BodyAcc | fBodyAcc-std()-Y |
| fftBodyAccStandardDeviationForZaxis | BodyAcc | fBodyAcc-std()-Z |
| fftBodyAccJerkMeanValueForXaxis | BodyAccJerk | fBodyAccJerk-mean()-X |
| fftBodyAccJerkMeanValueForYaxis | BodyAccJerk | fBodyAccJerk-mean()-Y |
| fftBodyAccJerkMeanValueForZaxis | BodyAccJerk | fBodyAccJerk-mean()-Z |
| fftBodyAccJerkStandardDeviationForXaxis | BodyAccJerk | fBodyAccJerk-std()-X |
| fftBodyAccJerkStandardDeviationForYaxis | BodyAccJerk | fBodyAccJerk-std()-Y |
| fftBodyAccJerkStandardDeviationForZaxis | BodyAccJerk | fBodyAccJerk-std()-Z |
| fftBodyGyroMeanValueForXaxis | BodyGyro | fBodyGyro-mean()-X |
| fftBodyGyroMeanValueForYaxis | BodyGyro | fBodyGyro-mean()-Y |
| fftBodyGyroMeanValueForZaxis | BodyGyro | fBodyGyro-mean()-Z |
| fftBodyGyroStandardDeviationForXaxis | BodyGyro | fBodyGyro-std()-X |
| fftBodyGyroStandardDeviationForYaxis | BodyGyro | fBodyGyro-std()-Y |
| fftBodyGyroStandardDeviationForZaxis | BodyGyro | fBodyGyro-std()-Z |
| fftBodyAccMagMeanValue | BodyAccMag | fBodyAccMag-mean() |
| fftBodyAccMagStandardDeviation | BodyAccMag | fBodyAccMag-std() |
| fftBodyBodyAccJerkMagMeanValue | BodyBodyAccJerkMag | fBodyBodyAccJerkMag-mean() |
| fftBodyBodyAccJerkMagStandardDeviation | BodyBodyAccJerkMag | fBodyBodyAccJerkMag-std() |
| fftBodyBodyGyroMagMeanValue | BodyBodyGyroMag | fBodyBodyGyroMag-mean() |
| fftBodyBodyGyroMagStandardDeviation | BodyBodyGyroMag | fBodyBodyGyroMag-std() |
| fftBodyBodyGyroJerkMagMeanValue | BodyBodyGyroJerkMag | fBodyBodyGyroJerkMag-mean() |
| fftBodyBodyGyroJerkMagStandardDeviation | BodyBodyGyroJerkMag | fBodyBodyGyroJerkMag-std() |
