## Code Book

### run_analysis.R

library(data.table) was used for analysis.

1) The train and test data sets where uploaded for x, y, and subject data. The train and tests were then combined (using rbind) to create a data.table for x, y, and subjects.

2) The features of the data were uploaded into a data.table, only keeping the data column (V2). The activities values were uploaded and converted to character,lowercase, and the underscore was removed from the values.

3) Features were extracted for only mean and standard deviation, the x data.table was subsetted and named for those features. 

#### alldata.txt

4) The x, y, and subjects were combined (using cbind) to a single data.table. The export of the data.table is here https://github.com/meutband/datasciencecoursera/blob/master/GettingandCleaningData/alldata.txt

#### meandata.txt

5) The alldata data.table was aggregated to the mean by acitivities and subjects. The export of the aggregated table is here https://github.com/meutband/datasciencecoursera/blob/master/GettingandCleaningData/meandata.txt


### columns is the resulting files

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix ‘t’ to denote time) were captured at a constant rate of 50 Hz. and the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) – both using a low pass Butterworth filter.

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

A Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the ‘f’ to indicate frequency domain signals).

Description of abbreviations of measurements
- leading t or f is based on time or frequency measurements.
- Body = related to body movement.
- Gravity = acceleration of gravity
- Acc = accelerometer measurement
- Gyro = gyroscopic measurements
- Jerk = sudden movement acceleration
- Mag = magnitude of movement
- mean and SD are calculated for each subject for each activity for each mean and SD measurements.
- The units given are g’s for the accelerometer and rad/sec for the gyro and g/sec and rad/sec/sec for the corresponding jerks.

These signals were used to estimate variables of the feature vector for each pattern:
‘-XYZ’ is used to denote 3-axial signals in the X, Y and Z directions. They total 33 measurements including the 3 dimensions - the X,Y, and Z axes.
| Features  | Description |
| --------- | ----------- |
|tBodyAcc-XYZ | Mean time for acceleration of body  |
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are:
- mean(): Mean value
- std(): Standard deviation

