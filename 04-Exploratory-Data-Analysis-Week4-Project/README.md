# Coursera - Johns-Hopkins
## Data Science track - #04 Exploratory Data Analysis

web site : [Johns Hopkins University - Coursera](https://www.coursera.org/jhu)

## Course Project

This folder contains the **Course Project 2** of the 4th course of the serie.
<br/>

### Description

The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.

### Project files

This folder contains the following files:
- README.md (this file) : simple introduction
- loadplotdata.R : an helper source file, it contains 2 functions
  - `loadplotdata(mergewithscc)` : load the data and returns a tibble, 
    - if mergewithscc = FALSE (default), returns pm25
	- if mergewithscc = TRUE, returns the 2 datasets (pm25 and scc) merged
  - `loadplotcolor()` : generates a color palette of 4 'blue' (1 for each year)
- plot**X**.R : the code of each plot
- plot**X**.png : the generated plots (png format)

### Results

1) Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 

Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

![plot1.png](plot1.png)

2) Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008? 

Use the base plotting system to make a plot answering this question.

![plot2.png](plot2.png)

3) Of the four types of sources indicated by the **type** (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
Which have seen increases in emissions from 1999–2008? 
Use the ggplot2 plotting system to make a plot answer this question.

![plot3.png](plot3.png)

4) Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

![plot4.png](plot4.png)

5) How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

![plot5.png](plot5.png)

6 Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California. Which city has seen greater changes over time in motor vehicle emissions?

![plot6.png](plot6.png)
