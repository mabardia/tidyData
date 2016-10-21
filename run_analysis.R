
#########################
#
#    Thanks COURSERA
#
#########################


#Load required packag // cargar los paquetes requeridos
library(dplyr)

# Set your filePath // definir tu carpeta de trabajo
filesPath <- "C:/Users/Operaciones/Documents/UCI HAR Dataset"


# Read subject files // leer archivos de voluntarios
subject_train <- tbl_df(read.table(file.path(filesPath, "train", "subject_train.txt")))
subject_test  <- tbl_df(read.table(file.path(filesPath, "test" , "subject_test.txt" )))

# Read activity files // leer archivos de actividad
y_train <- tbl_df(read.table(file.path(filesPath, "train", "Y_train.txt")))
y_test  <- tbl_df(read.table(file.path(filesPath, "test" , "Y_test.txt" )))

# Read data files. // leer archivos de datos
X_train <- tbl_df(read.table(file.path(filesPath, "train", "X_train.txt" )))
X_test  <- tbl_df(read.table(file.path(filesPath, "test" , "X_test.txt" )))

# add column name for subject files // nombrar las columnas de archivos de voluntarios
names(subject_train) <- "subjectID" 
names(subject_test) <- "subjectID"
# add column names for measurement files // nombrar las columnas de archivos de mediciones
featureNames <-  tbl_df(read.table(file.path(filesPath, "", "features.txt"))) 
names(X_train) <- featureNames$V2 
names(X_test) <- featureNames$V2 


# add column name for label files  // nombrar las columnas de archivos de etiquetas
names(y_train) <- "activity" 
names(y_test) <- "activity" 

# combine files into one dataset // combinar archivos para dormar tabla
train <- cbind(subject_train, y_train, X_train) 
test <- cbind(subject_test, y_test, X_test) 
combined <- rbind(train, test) 


# determine which columns contain "mean()" or "std()" 
meanstdcols <- grepl("mean\\(\\)", names(combined)) | grepl("std\\(\\)", names(combined))


# ensure that we also keep the subjectID and activity columns 
meanstdcols[1:2] <- TRUE 

# remove unnecessary columns 
combined <- combined[, meanstdcols] 

# convert the activity column from integer to factor 
combined$activity <- factor(combined$activity, labels=c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))

## Create the file with our combined data
write.table(combined, "MarianoTidyData.txt", row.name=FALSE)




