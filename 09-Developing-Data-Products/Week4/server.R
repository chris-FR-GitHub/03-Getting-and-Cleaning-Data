#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(stats)
library(dplyr)
library(ggplot2)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    # function to get the input
    getDegree <- reactive({
        input$degree
    })
    getX <- reactive({
        if(input$formula > 0) cars$speed else cars$dist
    })
    getY <- reactive({
        if(input$formula > 0) cars$dist else cars$speed
    })
    getXLabel <- reactive({
        if(input$formula > 0) 'Speed (mph)' else 'Stopping distance (ft)'
    })
    getYLabel <- reactive({
        if(input$formula > 0) 'Stopping distance (ft)' else 'Speed (mph)'
    })
    
    #make dynamic numericInput
    # GOAL : limit the MAX to the max of the X axis (just for the FUN to create a dynamic UI)
    output$numinput <- renderUI({
        if(input$formula > 0) max=max(cars$speed) else max=max(cars$dist)
        if ( !is.null(input$numeric) && !is.na(input$numeric) ){
            if(input$numeric > max) val <- max else val <- input$numeric
        } else
        {
            val <- 25
        }
        
        numericInput("numeric", 
                     "What value do you want to use fo prediction?",
                     value = val, 
                     min = 1, 
                     max = max, 
                     step = 1)
    })
    
    output$plotandlm <- renderPlotly({
        # get all the parameters
        degree <-getDegree()
        x <-getX()
        y <- getY()
        xlabel<-getXLabel()
        ylabel<- getYLabel()
        formula <- y ~ poly(x, degree, raw = TRUE)
        
        # create a GGPLOT2 graph
        p <- ggplot(cars, aes(x, y))
        p <- p +
            geom_point(
                alpha = 0.2,
                fill = "blue",
                colour = "black",
                size = 2
            ) +
            labs(x = xlabel, y = ylabel)
        # add the polynomial lm
        p <- p + geom_smooth(
            method = "lm",
            se = FALSE,
            formula = formula,
            colour = "red"
        )
        # add the plot as a plotly plot
        ggplotly(p)
        
    })
    
    output$prediction <- renderText({
        # get the parameters
        degree <-getDegree()
        x <-getX()
        y <- getY()
        xtopredict <- input$numeric
        formula <- y ~ poly(x, degree, raw = TRUE)
        # build a moel and predict the value
        lm.fit <- lm(formula = formula)
        val <- predict(lm.fit,
                       newdata = data.frame(x = xtopredict), se.fit = FALSE)
        round(val, 1)
        
    })
  
})
