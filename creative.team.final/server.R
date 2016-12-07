#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
#setwd('C:/Users/Benjamin/Documents/Info201/creative-team-final/project_data')
df <- read.csv('Seattle_Police_Department_911_Incident_Response_2012.csv')
library(shiny)
library(leaflet)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # Creates the normal crime map from leaflet 
  output$map <- renderLeaflet({
    leaflet(df) %>%
      addTiles() %>%
      setView(lng = -122.3321, lat = 47.6062, zoom = 11) 
  })
  
  #creates the heatmap from leaflet
  output$heatmap <- renderLeaflet({
    leaflet() %>% 
    setView(lng = -122.335167, 
              lat = 47.608013, 
              zoom = 11) %>%
    addTiles()
  })

  #Allow checkbox's input to search through data frame to find matches
   crimefilter <- reactive({
    df[df$Event.Clearance.Group %in% input$crimechoices,]
   })
   
   # Plots the data points selected in checkboxs
   observe({
     if(nrow(crimefilter())==0) {
       leafletProxy("map") %>% clearMarkerClusters()
     }
     else{
       leafletProxy("map", data=crimefilter()) %>%
         clearMarkerClusters() %>%
         addMarkers(lng= ~Longitude, lat= ~Latitude, popup = ~paste0(
           'Event Description: ',as.character(Event.Clearance.Description)),
                          clusterOptions=markerClusterOptions())
     }
     })
}) 

