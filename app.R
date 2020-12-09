#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(tidyverse)

data = read.csv("sample.csv", stringsAsFactors = TRUE)
stations <- data[match(unique(data$end.station.id), data$end.station.id),]

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    headerPanel(" NYC CitiBike Locations"),
    # Show a plot of the generated distribution
    mainPanel(
        h3(textOutput("Map of Station Locations in 2019")),
        leafletOutput("mymap")
        
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    points <- eventReactive(input$recalc, {
        cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
    }, ignoreNULL = FALSE)
    
    output$mymap <- renderLeaflet({
        leaflet(stations) %>%
            addTiles() %>%
            addMarkers(~end.station.longitude, ~end.station.latitude,labelOptions = labelOptions(noHide = F),clusterOptions = markerClusterOptions(),popup = paste0("<br/><b> Station: </b>", stations$end.station.name
            ))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
