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


### Names of the features in the resulting files

These signals were used to estimate variables of the feature vector for each pattern:
‘-XYZ’ is used to denote 3-axial signals in the X, Y and Z directions. They total 33 measurements including the 3 dimensions - the X,Y, and Z axes.

| Features  | Description |
| --------- | ----------- |
| tbodyacc-XYZ | Time for acceleration of body  |
| tgravityacc-XYZ  | Time of acceleration of gravity |
| tbodyaccjerk-XYZ | Time of body acceleration jerk  |
| tbodygyro-XYZ | Body gyroscope measurement |
| tbodygyrojerk-XYZ | Jerk signal of body |
| tbodyaccmag | Magnitude of body |
| tgravityaccmag  | Gravity acceleration magnitude  |
| tbodyaccjerkmag | Magnitude of body acceleration jerk |
| tbodygyromag  | Magnitude of body gyroscope measurement |
| tbodygyrojerkmag  | Magnitude of body body gyroscope jerk measurement |
| fbodyacc-XYZ  | Frequency of body acceleration  |
| fbodyaccjerk-XYZ  | Frequency of body accerlation jerk  |
| fbodygyro-XYZ | Frequency of body gyroscope measurement |
| fbodyaccmag | Frequency of body acceleration magnitude  |
| fbodybodyaccjerkmag |  Frequency of body acceleration jerk magnitude  |
| fbodybodygyromag  | Frequency of magnitude of body gyroscope measurement  |
| fbodybodygyrojerkmag  | Frequency of magnitude of body gyroscope jerk measurement |
| activity (activities on meandata) | The activity performed |
| subject | Subject ID  |

The set of variables that were estimated from these signals are:
- mean(): Mean value
- std(): Standard deviation

