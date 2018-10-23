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
#                                 loadplotdata helper
#===============================================================================
# This file contains the loadplotdata function
# the script file should be in the working folder
#===============================================================================

################################################################################
# R library


################################################################################
#                               loadplotdata
################################################################################
# Load the RDS file
# the files must be in the current directory

loadplotdata <- function(mergewithscc = FALSE) {
    require(dplyr)
    
    # load the Source_Classification_Code.rds dataset
    # we want to extract the exact levels of the SCC column
    # sccrds <- readRDS("Source_Classification_Code.rds")
    sccrds <- as_tibble(readRDS("Source_Classification_Code.rds"))
    SCClev <- levels(sccrds$SCC) 
    
    
    ## This first line will likely take a few seconds. Be patient!
    # read the RDS file and return the dataset as a tibble
    # factor : fips, SCC, Pollutant and type
    # year ????
    pm25 <- as_tibble(readRDS("summarySCC_PM25.rds")) %>%
        mutate(
            fips = factor(fips),
            SCC = factor(SCC,
                         levels = SCClev),
            Pollutant = factor(Pollutant),
            type = factor(type,
                          levels = c(
                              "NON-ROAD",
                              "NONPOINT",
                              "ON-ROAD",
                              "POINT"
                          ))
        )
    
    # merge with the sccrds dataset if required
    if (mergewithscc) {
        pm25 <- left_join(pm25, sccrds, by = "SCC")
    }
    
    # return
    pm25
    
}

# data <- loadplotdata()
# data <- loadplotdata(mergewithscc = TRUE)



################################################################################
#                               loadplotcolor
################################################################################
# Create a 4 blue palette : 1 for each year

loadplotcolor <- function(mergewithscc = FALSE) {
    require(RColorBrewer)
    
    pblue <- colorRampPalette(c("lightblue","darkblue"))
    pblue(4)   # 1 color for each year
}

# loadplotcolor()
# > loadplotcolor()
# [1] "#ADD8E6" "#7390C7" "#3948A9" "#00008B"
