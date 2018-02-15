
# Read feature dataset
# activity labels
label.test  <- read.table("Y_test.txt" , header = FALSE)
label.train <- read.table("Y_train.txt", header = FALSE)
# feature set
feature.test <- read.table("X_test.txt", header = FALSE)
feature.train <- read.table("X_train.txt", header = FALSE)

# Read subject dataset
subject.test  <- read.table("subject_test.txt", header = FALSE)
subject.train <- read.table("subject_train.txt", header = FALSE)

# Read activity labels
activitylabels <- read.table("activity_labels.txt", header = FALSE)
# Read feature labels
featurelabels <- read.table("features.txt", head=FALSE)
# Read Subject labels

# show portions of the data
head(label.test, n=3)
head(label.train, n=3)
head(feature.train, n=3)
head(feature.test, n=3)
head(subject.train, n=3)
head(subject.test, n=3)
head(activitylabels, n=3)
head(featurelabels, n=3)

# verify length of datasets
length(label.train$V1)
length(feature.train$V1)
length(subject.train$V1)
length(feature.test$V1)
length(label.test$V1)
length(subject.test$V1)

# merge train and test datasets
label = rbind(label.train, label.test)
subject = rbind(subject.train, subject.test)
feature = rbind(feature.train, feature.test)

# verify merge dataset lengths
length(label$V1)
length(feature$V1)

# convert the activity labels to factors
label$V1=factor(x = label$V1, levels = as.integer(activitylabels$V1), label=activitylabels$V2)

# set column names
names(feature) <- featurelabels$V2
names(subject) <- c("subject")
names(label) <- c("activity")

# get target columnnames (mean and standard deviation)
columnnames<-c(as.character(featurelabels$V2[grep("mean\\(\\)|std\\(\\)", featurelabels$V2)]))
featuresubset<-subset(feature,select=columnnames)

# compose tidy dataset
tidy1 <- cbind(label, subject, featuresubset)

# group tidy1 by activity, subject
temp <- group_by(tidy1, activity, subject)
# compute the average of all variables except index columns
tidy2 <- summarise_all(temp, mean)

# write dataset
write.table(tidy1, file = "tidy1.txt", row.name = FALSE)
write.table(tidy2, file = "tidy2.txt", row.name = FALSE)
