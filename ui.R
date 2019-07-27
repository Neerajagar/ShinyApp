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
shinyUI (fluidPage(
  
  # Application title
  titlePanel("Application Maitenance Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectInput("application",
                   "Choose Application:",
                   choices = c("B", "C","D", "G","L", "N","P", "T", "U")),
              submitButton("Display"),
              helpText("Graph shows the total incidents raised for the application")
              ),
                   
      
    # Show a plot of the generated distribution
    mainPanel(
       h3("Incidents raised per month for the Application:"),
       plotlyOutput("Plot"),
       h3("Incidents raised:"),
       tableOutput("incidents_table")
    )
  )
)
)
