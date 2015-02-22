==================================================================
Cousera Specialization - Johns Hopkins University - Data Science - Getting and Cleaning Data Course Project

Ignacio de Andrés (i.deandres@live.com)

CodeBook
==================================================================

This file includes all neccesary information regarding the source of the data used to perform the analysis, as well as describes any transformations or work performed to clean up the data.


Base Data
=================================================================
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
---------------------------------------------------------------------------------------------------------------------------------

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
--------------------------------------------------------------------------------------------------------------------------------

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 


Transformations:
==================================================================

- Each set (training and test) was built and merged after putting together:
	a)  the subject_file (identification of the person/subject who performed the activity during the measurement),
	b)  the Y_file (identification of the activity performed by a subject during the measurement), and
	c)  the X_file (measurements), 
  in this same order.

- The activities codes (Y_file, column #2 in the merged dataset) were substituted by the activity definitions as listed in the file "activity.labels.txt" for clarification.

- All measurements different from means and standard deviations were deleted from the dataset, creating a reduced dataset ("FinalDataset")

- In order to facilitate the interpretation of the measurements, the column names were modified by substituting the abbreviations by full words and separating each piece of information (time or frequency measure, gyrometer or accelerometer measure, and so on) by "_".

- A simplified datafile with just the the average of each variable for each activity and each subject was creared from "FinalDataset", called "tidy_dataset.txt", and is available in this repo.

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
