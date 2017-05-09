library(data.table)

## read in xtrain/xtest data sets. combine into single data.table
xtrain <- read.table('train/X_train.txt', header=FALSE)
xtest <- read.table('test/X_test.txt', header=FALSE)
X <- rbind(xtrain, xtest)

## repeat steps for y
ytrain <- read.table('train/Y_train.txt', header=FALSE)
ytest <- read.table('test/Y_test.txt', header=FALSE)
Y <- rbind(ytrain, ytest)

## repeat for subjects
subtrain <- read.table('train/subject_train.txt', header=FALSE)
subtest <- read.table('test/subject_test.txt', header=FALSE)
sub <- rbind(subtrain, subtest)
names(sub) <- 'subject'

## get features of the data
features <- read.table('features.txt')
features <- features$V2

## get the activities of the data, convert to lower and remove underscores
activities <- read.table('activity_labels.txt')
activities[,2] <- tolower(as.character(activities[,2]))
activities[,2] <- gsub('_', '', activities[,2])

## extract features that include only mean and standard deviation
keep <- grep('-(mean|std)\\(\\)', features)
X <- X[, keep]
names(X) <- gsub('\\(|\\)', '', tolower(features[keep]))

## add activity to y values
Y[,1] <- activities[Y[,1], 2]
names(Y) <- 'activity'

## combine data.tables into final data.table, export to 'alldata.txt'
alldata <- cbind(Y, sub, X)
write.table(alldata, 'alldata.txt', row.names=FALSE)

## create 2nd data set of means of each activity and each subject
meandata <- aggregate(alldata, by=list(activities=alldata$activity, sub=alldata$subject), FUN=mean)
meandata <- meandata[, !names(meandata) %in% c('sub', 'activity')]
write.table(meandata, 'meandata.txt', row.names=FALSE)
