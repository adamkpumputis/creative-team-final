<<<<<<< HEAD:server.R
=======
# setwd('C:/Users/Justin/Documents/info201/creative-team-final')

>>>>>>> b9df0526cd12dab28f3a7ba7b34cbb55ff48bbcb:creative.team.final/server.R
library(shiny)
library(leaflet)
library(dplyr)
library(lubridate)

<<<<<<< HEAD:server.R
=======
df <- read.csv('../project_data/filtered.csv')
source('../scripts/graphScripts.R')

>>>>>>> b9df0526cd12dab28f3a7ba7b34cbb55ff48bbcb:creative.team.final/server.R
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  df <- read.csv('./project_data/filtered.csv')
  source('./scripts/graphScripts.R')

  # Creates the normal crime map from leaflet 
  output$map <- renderLeaflet({
    leaflet(df) %>%
      addTiles() %>%
      setView(lng = -122.3321, lat = 47.6062, zoom = 11) 
  })

  #Allow checkbox's input to search through data frame to find matches
   crimefilter <- reactive({
    df[df$Event.Clearance.Group %in% input$crimechoices,] 
   })
   
   # Plots the data points selected in checkboxes
   observe({
     
     #dataForPlot <- inner_join(crimefilter(),daterange(),by="X")
     
     # Replots the markers
     if(nrow(crimefilter()) == 0) {
       leafletProxy("map") %>% clearMarkerClusters()
     }
     else{
       leafletProxy("map", data = crimefilter()) %>%
         clearMarkerClusters() %>%
         addMarkers(lng = ~Longitude, lat = ~Latitude, popup = ~paste0(
           'Event Group: ', as.character(Event.Clearance.Group), "<br>", 
           'Event Description: ', as.character(Event.Clearance.Description), "<br>",
           'Date of Incident: ', as.character(Event.Clearance.Date)
         ), 
         clusterOptions = markerClusterOptions())
     }
     })
   
   # Histogram for 'About' tab
   output$yearlyCrimeMap <- renderPlotly({
        makeYearGraph(df)
   })
   
   # Bar graph for 'About' tab
   output$monthlyNumberGraph <- renderPlotly({
        makeTimeGraph(df)
   })
   
   # Pie graph for 'About' tab
   output$julyGraph <- renderPlotly({
        make_july_graph(df)
   })
   
}) 

