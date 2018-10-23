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
#                                 plot3
#===============================================================================
# Of the four types of sources indicated by the "type" variable,
# which of these four sources have seen decreases in emissions
# from 1999-2008 for Baltimore City?
# Which have seen increases in emissions from 1999-2008?
# Use the ggplot2 plotting system to make a plot answer this question.
#===============================================================================


################################################################################
# R library

# clear the objects
# ls()
# rm(list=ls())

# Load the packages
library(dplyr, warn.conflicts = FALSE)
library(ggplot2)
library(RColorBrewer)   # to check the coloar palette from the course

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
# Summarize total emissions by year & type (in tons)
emissionbyyeartype <- data %>%
    filter(fips == "24510") %>%
    group_by(year, type) %>%
    summarize(emissions = sum(Emissions))


# emissionbyyeartype


################################################################################
# create a blue palette for fun
# the function comes from the source('loadplotdata.R')

cblue <- loadplotcolor()

################################################################################
# plot

png('plot3.png',
    height = 480,
    width = 600)

emissionbyyeartype %>%
    ggplot(aes(x = factor(year), y = emissions, fill = factor(year))) +
    geom_col() +
    geom_text(aes(label = as.integer(emissions)), vjust = -0.5, size=3)+
    # scale_fill_brewer(direction = -1) +
    scale_fill_manual(values = cblue) +
    facet_wrap( ~ type, ncol = 4) +
    theme_bw() +
    theme(axis.text.x = element_text(size = 8)) +
    labs(
        x = 'Year',
        y = expression( ~ PM[2.5] ~ ' emissions (in tons)'),
        title = 'Baltimore City - ' ~ PM[2.5] ~ ' emission by Type from 1999 to 2008'
    ) +
    guides(fill=FALSE)  # hide the year legend as year was used for the FILL aes

dev.off()
