################################################################################
## Coursera :       Johns Hopkins
## Specialization : Data Science 
## Course #03 :     Getting and Cleaning Data
################################################################################
## Getting and Cleaning Data Course Project
################################################################################
#
# The purpose of this project is to demonstrate our ability to collect, 
# work with, and clean a data set. The goal is to prepare tidy data that 
# can be used for later analysis. 
#
################################################################################

 
################################################################################
# R library

# clear the objects
ls()
rm(list=ls())

# Load the packages
library(dplyr, warn.conflicts = FALSE)
library(readr)   # for read_table > tibble
library(tidyr)   # for separate
library(stringr)

# display the R version and the loaded package with their versions
print(paste("R", getRversion()))
print("-------------")
for (package_name in sort(loadedNamespaces())) {
    print(paste(package_name, packageVersion(package_name)))
}



################################################################################
# Preparing the project structure
# 
# - (current folder) sub folders
#     -> datazip : contains the ZIP file
#     -> data : contains the original extracted files
#     -> datards : contains dataset saved objects (.RDS)
#

folderzip <- 'datazip'
folderdata <- 'data'
folderdrds <- 'datards'

# ==============================================================================
# Select a working folder

# the FOLLOWING SCRIPT, use RStudio API, modify it if you just use the console
# This command set the working folder to the script folder, 
# otherwise keep current folder
# 
# folderscript <- dirname(rstudioapi::getSourceEditorContext()$path)
#
folderscript <- tryCatch(dirname(rstudioapi::getSourceEditorContext()$path),
                         error = function(e){ '.' }
)
setwd(folderscript)

# ==============================================================================
# Create the sructure

if(!dir.exists(folderzip)) dir.create(folderzip)
if(!dir.exists(folderdata)) dir.create(folderdata)
if(!dir.exists(folderdrds)) dir.create(folderdrds)

################################################################################
# Load the original files
# 
# - Load the ZIP in the datazip folder
# - Extract the files in the data folder
#

# ==============================================================================
# Load the ZIP file

urlzip <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
filezip <- file.path(folderzip, 'projectfiles.zip')

# --- IF your network is slow ----
# if the ZIP file was already loaded, we do not download it again
# if you want to download it each time, delete the original file in 
# the datazip folder
if(!file.exists(filezip)){
    download.file(url=urlzip, destfile = filezip)
}

# ==============================================================================
# Unzip the ZIP file

unzip(filezip ,exdir=folderdata)

# rename the data folder to include the ZIP 1st folder
folderdata <- file.path(folderdata, 'UCI HAR Dataset')


# ==============================================================================
# clean the unused variables
rm(list = c('filezip', 'folderzip', 'urlzip'))



################################################################################
# Question 1 :
# 
# - Merge the training and test sets to create one data set
#


# ==============================================================================
# Load the feature file
features <- read.table(file.path(folderdata, 'features.txt'))
names(features) <- c('num','feature')

# the mergeddata
mergeddata <- NULL

for(filetype in c('train', 'test')){
    
    # load the subjects
    file <- paste('subject_' ,filetype,'.txt', sep="")
    # read using the readr package to create a tibble/data table object
    subjects <- read_table(file.path(folderdata, filetype, file),
                           col_names = FALSE,
                           col_types = cols())
    names(subjects) <- c('subject')
    
    # load the data X
    file <- paste('X_' ,filetype,'.txt', sep="")
    datax <- read_table(file.path(folderdata, filetype, file),
                        col_names = FALSE,
                        col_types = cols())
    names(datax) <- features$feature
    
    # load the data Y
    file <- paste('Y_' ,filetype,'.txt', sep="")
    datay <- read_table(file.path(folderdata, filetype, file),
                        col_names = FALSE,
                        col_types = cols())
    names(datay) <- c('activityid')
    
    # bind the 3 data table by columns
    # Add them to the global data table
    mergeddata <- bind_rows(mergeddata,  bind_cols(subjects, datax, datay))

    
}

print(paste('mergeddata data table dimension : ', nrow(mergeddata), ' rows x', ncol(mergeddata), ' cols'))

# ==============================================================================
# clean the unused variables
rm(list = c('file', 'subjects', 'datax', 'datay', 'filetype', 'package_name'))



# [1] 7352    1
# [1] 2947    1
# [1] "mergeddata data table dimension :  10299  rows x 563  cols"


################################################################################
# Question 2 :
# 
# - Extracts only the measurements on the mean and standard deviation
#   for each measurement
# I use names containing -mean() and -std()

#names(mergeddata)

mergeddata <- mergeddata %>% 
    select(subject, 
           activityid, 
           matches("-(mean|std)[(][)]"))


print(paste('mergeddata data table dimension : ', nrow(mergeddata), ' rows x', ncol(mergeddata), ' cols'))



################################################################################
# Question 3 :
# 
# - Use descriptive Activity names to name the activities
#


# ==============================================================================
# Load the activity labels
# read the file, no header
activities <- read_table(file.path(folderdata, 'activity_labels.txt'), 
                         col_names = FALSE,
                         col_types = cols())
# rename the header
names(activities) <- c('activityid','activity')



# ==============================================================================
# Join the activities and the merged datatable
# using the dplyr inner_join
# then drop the activityid column
mergeddata <- inner_join(activities, mergeddata, by='activityid') %>% 
    select (-activityid)


# ==============================================================================
# the data is complate
# saved it to a .RDS file
# ? write_rds
write_rds(mergeddata,
          file.path(folderdrds, 'mergeddata.RDS'),
          compress=c("gz"),
          compression=9L)

# to restore
# newobj <- read_rds(file.path(folderdrds, 'mergeddata.RDS'))


# ==============================================================================
# clean the unused variables
rm(list = c('activities'))





################################################################################
# Question 4 :
# 
# - Approprately labels the data set with descriptive variable names
#

# we already set the variable name from the 'activity_labels.txt' file
# we will just modify them a little bit to test separate, ..


# ==============================================================================
# Get the column names

colnames <- as_tibble(names(mergeddata))
names(colnames) <- c('initialname')

# remone the 2 first values : 
colnames <- colnames[3:nrow(colnames),]

# ==============================================================================
# split the names by "-" to separate sensor, function, axis
# the captor, by its first letter
colnames <- colnames %>%
    separate(initialname, 
             into=c('sensor', 'computation','axis'),
             sep='-', 
             remove=FALSE,
             extra='merge',
             fill='right') %>%
    separate(sensor, 
             into=c('domain', 'sensor'),
             sep=1, 
             remove=FALSE,
             extra='merge',
             fill='right') %>%
    mutate (columnname = '') %>%
    select(columnname, domain, sensor, computation, axis, initialname)


# do some changes
colnames$axis <- ifelse( colnames$axis %in% c("X","Y","Z"), paste('For',colnames$axis,'axis',sep=''),'')
colnames$computation <- ifelse( colnames$computation == 'mean()', 'MeanValue','StandardDeviation')
colnames$domain <- ifelse( colnames$domain == 'f', 'fft','time')

# compute the new column name
colnames <- colnames %>%
    mutate(columnname = paste(domain,sensor,computation,axis,sep=''))


# reimport the new col names
names(mergeddata) <- c('activity', 'subject', colnames$columnname)

# ==============================================================================
# colnames %>% print(n = Inf)




################################################################################
# Question 5 :
# 
# - from the dataset in step 4, creates a second, independent tidy data set
#   with the average of each activity and each subject
#

avgdata <- mergeddata %>% 
    group_by(subject, activity) %>%
    summarise_all(mean)


# ==============================================================================
# the data is complate
# saved it to a .RDS file
# ? write_rds
write_rds(avgdata,
          file.path(folderdrds, 'avgdata.RDS'),
          compress=c("gz"),
          compression=9L)


# to restore
# newavgobj <- read_rds(file.path(folderdrds, 'avgdata.RDS'))

# ==============================================================================
# Save the file to post the fiole obn the coursera site
write.table(avgdata, 
            file.path(folderdrds, 'project_dataset_step5.txt'),
            row.names = FALSE)



