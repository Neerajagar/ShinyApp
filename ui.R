#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Interface passes the application as Input to create te histogram for the application

library(shiny)
library(plotly)

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
