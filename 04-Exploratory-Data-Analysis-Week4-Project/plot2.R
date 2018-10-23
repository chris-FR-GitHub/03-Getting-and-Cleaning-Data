################################################################################
## Coursera :       Johns Hopkins
## Specialization : Data Science
## Course #04 :     Exploratory Data Analysis
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
#                                 plot2
#===============================================================================
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.
#===============================================================================

################################################################################
# R library

# clear the objects
# ls()
# rm(list=ls())

# Load the packages
library(dplyr, warn.conflicts = FALSE)

################################################################################
# Load the RDS file
# the files must be in the current directory

# the 'loadplotdata.R' file must be in the working folder
# the 2 RDS file must also be in the current working folder
source('loadplotdata.R')

# load the data
data <- loadplotdata()

# str(data)

################################################################################
# Filter Baltimore data fips == "24510"
# Summarize total emissions by year (in tons) => max is 3274
emissionbyyear <- data %>%
    filter(fips == "24510") %>%
    group_by(year) %>%
    summarize(emissions = sum(Emissions))

# max(emissionbyyear$emissions)
# emissionbyyear

################################################################################
# plot

png('plot2.png',
    height = 480,
    width = 480)

barplot(
    height = emissionbyyear$emissions,
    names.arg = emissionbyyear$year,
    col = 'blue',
    main =
        expression('Baltimore City - Total ' ~ PM[2.5] ~ ' emission from 1999 to 2008'),
    xlab = 'Year',
    ylab = expression( ~ PM[2.5] ~ ' emissions (in tons)')
)
# box()

dev.off()