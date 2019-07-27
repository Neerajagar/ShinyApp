#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(readr)
library(shiny)
library(plotly)
library(lubridate)
library(dplyr)
library(ggplot2)


path <- paste(getwd(), sep="")

incident.file <- file.path(path, "incidents.csv")

##all_incidents <- file.path(path, "incidents.csv", header=TRUE, sep = ",")

all_incidents <- read.csv(incident.file, header=TRUE, stringsAsFactors = F)

incidents <- data.frame(all_incidents$Number,all_incidents$application,format(as.POSIXct(all_incidents$Opened,format="%Y-%m-%d"),"%Y-%m"))

names(incidents) <- c("Number","Application","Opened")

##incidents <- incidents %>% group_by(Application, Opened) %>% summarise(sr_number =count(as.numeric(Number)))

incidents <-incidents %>% count(Application, Opened)

##dim(incidents)
summary (incidents)

# Define server logic required to draw a histogram
shinyServer(function(input, output){
  
    incidents_data <- reactive({ 
      
              abc <- subset(incidents,input$application==incidents$Application) 
              return(abc) 
                          }) 
   
    output$Plot <- renderPlotly({plot_ly(incidents_data(), x =~Opened, y=~n, type = "bar")})
  
    output$incidents_table <- renderTable({incidents_data()}) 
    
})
