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
#                                 plot5
#===============================================================================
# How have emissions from motor vehicle sources changed 
# from 1999-2008 in Baltimore City?
#===============================================================================


################################################################################
# R library

# clear the objects
# ls()
# rm(list=ls())

# Load the packages
library(dplyr, warn.conflicts = FALSE)
library(ggplot2)
library(RColorBrewer) 

################################################################################
# Load the RDS file
# the files must be in the current directory

# the 'loadplotdata.R' file must be in the working folder
# the 2 RDS file must also be in the current working folder
source('loadplotdata.R')

# load the data => we join with the reference table
data <- loadplotdata(mergewithscc = TRUE)

# str(data)

################################################################################
# Filter Baltimore 
#     data fips == "24510"
# Filter vehicle sources:
#     vehicle sources
# As for Caol, I chose to go with the category
# 
# [1] "Mobile - On-Road Diesel Heavy Duty Vehicles"
# [2] "Mobile - On-Road Diesel Light Duty Vehicles"  
# [3] "Mobile - On-Road Gasoline Heavy Duty Vehicles"
# [4] "Mobile - On-Road Gasoline Light Duty Vehicles"


# Summarize total emissions by year (in thousands of tons)
emissioncarbyyear <- data %>%
    filter(fips == "24510") %>%
    filter(grepl('Vehicle', EI.Sector, ignore.case = TRUE)) %>%
    group_by(year) %>%
    summarize(emissions = sum(Emissions) )


# emissionbyyeartype


################################################################################
# create a blue palette for fun
# the function comes from the source('loadplotdata.R')

# i choose to set the same color as the previous plot to keep the same structure
cblue <- loadplotcolor()


################################################################################
# plot

png('plot5.png',
    height = 480,
    width = 480)

emissioncarbyyear %>%
    ggplot(aes(x = factor(year), y = emissions, fill=factor(year))) +
    geom_col() +
    geom_text(aes(label = as.integer(emissions)), vjust = -0.5) + 
    scale_fill_manual(values = cblue) +
    theme_bw() +
    theme(axis.text.x = element_text(size = 8)) +
    labs(
        x = 'Year',
        y = expression( ~ PM[2.5] ~ ' emissions (in tons)'),
        title = 'Baltimore - Vehicles ' ~ PM[2.5] ~ ' emission from 1999 to 2008'
    )+
    guides(fill=FALSE)  # hide the year legend as year was used for the FILL aes

dev.off()
