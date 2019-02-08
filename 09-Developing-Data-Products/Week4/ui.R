#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Speed and Stopping Distances of Cars"),
  
  # Sidebar with a slider input for the polynomial degree
  #  input numeric for the value to predict
  sidebarLayout(
    sidebarPanel(
       sliderInput("degree",
                   "Choose the Polynomial degree:",
                   min = 1,
                   max = 5,
                   value = 1),
       radioButtons("formula", "Formula:",
                          c("distance ~ speed" = 1,
                            "speed ~ distance" = 0)),
       #display dynamic UI
       uiOutput("numinput")
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       h4("This is the last project of the JohnsHopkins' Coursera : 'Developing Data Products' course."),
       plotlyOutput("plotandlm"),
       h4("Predicted value:"), 
       textOutput("prediction")
    )
  )
))
