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
#                                 plot6
#===============================================================================
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California fips == "06037".
# Which city has seen greater changes over time in motor vehicle emissions?
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
# Filter Baltimore City / Los Angeles County
#     data fips == "24510"
#          fips == "06037"
# Filter vehicle sources:
#     vehicle sources
# As for Caol, I chose to go with the category
# 
# [1] "Mobile - On-Road Diesel Heavy Duty Vehicles"
# [2] "Mobile - On-Road Diesel Light Duty Vehicles"  
# [3] "Mobile - On-Road Gasoline Heavy Duty Vehicles"
# [4] "Mobile - On-Road Gasoline Light Duty Vehicles"


# Summarize total emissions by year, city (in tons)
emissioncarbyyear <- data %>%
    filter(fips == "24510" | fips == "06037") %>%
    filter(grepl('Vehicle', EI.Sector, ignore.case = TRUE)) %>%
    group_by(year, fips) %>%
    summarize(emissions = sum(Emissions) ) %>%
    mutate(city = ifelse(fips == "24510",
                     'Baltimore city',
                     'Los Angeles county'),
           delta = 0.0) %>%
    select (-fips)

# compute delta
bal <- emissioncarbyyear[emissioncarbyyear$year==1999 & 
                             emissioncarbyyear$city == 'Baltimore city',]$emissions
los <- emissioncarbyyear[emissioncarbyyear$year==1999 & 
                             emissioncarbyyear$city == 'Los Angeles county',]$emissions

emissioncarbyyear$delta <- ifelse(emissioncarbyyear$city == 'Los Angeles county', 
                                  (emissioncarbyyear$emissions - los) / los,
                                  (emissioncarbyyear$emissions - bal)/bal)

emissioncarbyyear$delta <- paste(ifelse(emissioncarbyyear$delta >= 0, '+', ''),
      round(emissioncarbyyear$delta*100,digits=1)," %",sep="")

# emissioncarbyyear

################################################################################
# create a blue palette for fun
# the function comes from the source('loadplotdata.R')

# i choose to set the same color as the previous plot to keep the same structure
cblue <- loadplotcolor()


################################################################################
# plot

png('plot6.png',
    height = 480,
    width = 480)

emissioncarbyyear %>%
    ggplot(aes(x = factor(year), y = emissions, fill = factor(year))) +
    geom_col() +
    geom_text(aes(label = as.integer(emissions)), vjust = -2, size=3)+
    geom_text(aes(label =delta), vjust = -0.5, size=3, col="red")+
    scale_fill_manual(values = cblue) +
    facet_wrap( ~ city, ncol = 4) +
    theme_bw() +
    theme(axis.text.x = element_text(size = 8),
          plot.subtitle=element_text(size=8, hjust=0.5, face="italic", color="red")) +
    labs(
        x = 'Year',
        y = expression( ~ PM[2.5] ~ ' emissions (in tons)'),
        title = 'Baltimore cty vs Los Angeles co. - ' ~ PM[2.5] ~ ' emission from 1999 to 2008',
        subtitle ="% compared to 1999"   ) +
    guides(fill=FALSE) # hide the year legend as year was used for the FILL aes

dev.off()
