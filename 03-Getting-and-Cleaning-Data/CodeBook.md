## Original project data sets

````
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================
````


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


## Original publication & License

>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
>Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
>International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
>
>This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
>
>Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

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
