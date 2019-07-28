#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# This App creates Histogram & a table based on the application passed as Input.
# Data for the incidents across application is uplaoded on the github
#
library(readr)
library(shiny)
library(plotly)
library(lubridate)
library(dplyr)
library(ggplot2)


##Read Source Data from GITHUB repository 

all_incidents <- read.csv("https://raw.githubusercontent.com/Neerajagar/ShinyApp/master/incidents.csv",header = TRUE,stringsAsFactors = F) 

incidents <- data.frame(all_incidents$Number,all_incidents$application,format(as.POSIXct(all_incidents$Opened,format="%Y-%m-%d"),"%Y-%m"))

names(incidents) <- c("Number","Application","Opened")

incidents <-incidents %>% count(Application, Opened)

dim(incidents)
summary (incidents)

# Define server logic required to draw a histogram
shinyServer(function(input, output){
   
   incidents_data <- reactive({ 
              a <- subset(incidents,input$application==incidents$Application) 
              return(a) 
                          }) 
   
    output$Plot <- renderPlotly({plot_ly(incidents_data(), x =~Opened, y=~n, type = "bar")})
   
     
   output$incidents_table <- renderTable({incidents_data()}) 
     
})
