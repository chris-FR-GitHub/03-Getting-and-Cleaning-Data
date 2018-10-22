################################################################################
## Coursera :       Johns Hopkins
## Specialization : Data Science 
## Course #04 :     Getting and Cleaning Data
################################################################################
## Week 4 : Course Project 2
## Chris-FR-Github
################################################################################
#
# The overall goal of this assignment is to explore the National Emissions 
# Inventory database and see what it say about fine particulate matter pollution
# in the United states over the 10-year period 1999-2008. 
# You may use any R package you want to support your analysis.
#
################################################################################


#===============================================================================
#                                 plot1
#===============================================================================
# Have total emissions from PM2.5 decreased in the United States from 1999 to 
# 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.
#===============================================================================

################################################################################
# R library

# clear the objects
ls()
rm(list=ls())

# Load the packages
library(dplyr, warn.conflicts = FALSE)

################################################################################
# Load the RDS file
# the files must be in the current directory

loadrdsdata <- function(){
    ## This first line will likely take a few seconds. Be patient!
    # read the RDS file and return the dataset as a tibble
    as_tibble(readRDS("summarySCC_PM25.rds"))
    # sccrds <- readRDS("Source_Classification_Code.rds")
}

data <- loadrdsdata()


################################################################################
# Summarize toal emissions by year
emissionbyyear <- data %>%
    group_by(year) %>%
    summarize(emissions = sum(Emissions) / 10^6)


################################################################################
# plot

png('plot1.png',
    height = 480,
    width=480)

barplot(height=emissionbyyear$emissions,
        names.arg=emissionbyyear$year,
        col='blue',
        main = expression('US Total '~PM[2.5]~' emission from 1999 to 2008'),
        xlab = 'Year', 
        ylab = expression(~PM[2.5]~' emissions (in millions of tons)')
)
# box()

dev.off()



