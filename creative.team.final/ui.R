#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
setwd('~/Desktop/creative-team-final/project_data')
df <- read.csv('Seattle_Police_Department_911_Incident_Response_2012.csv')

library(shiny)
library(plotly)
library(dplyr)

crimes <- df %>%
            group_by(Event.Clearance.SubGroup) %>%
            select(Event.Clearance.SubGroup) %>%
            distinct()

shinyUI(navbarPage('SPD 911 Incident Response Data',
                   # Create a tab panel for you map
                   tabPanel('Map',
                            # Create sidebar layout
                            sidebarLayout(
                              # Side panel for controls
                              sidebarPanel(
                                # Input to select variable to map
                                checkboxGroupInput('crimechoices', 
                                            label = 'Variable to Map', 
                                            choices = crimes$Event.Clearance.SubGroup
                                ), 
                                
                                dateRangeInput('daterange', 
                                               label = 'Range of Dates to Map', 
                                               start = '2012-01-01', 
                                               end = '2012-12-31', 
                                               min = '2012-01-01', 
                                               max = '2012-12-31'
                                )
                              ),
                              # Main panel: display plotly map
                              mainPanel(
                                leafletOutput('map')
                              )
                            )
                   ),
                   
                   tabPanel('Heat Map', 
                            # Create sidebar layout
                            sidebarLayout(
                              # Side panel for controls
                              sidebarPanel(
                                # Input to select variable to map
                                checkboxGroupInput('heatcrimechoices', 
                                                   label = 'Variable to Map', 
                                                   choices = crimes$Event.Clearance.SubGroup
                                ), 
                                
                                dateRangeInput('heatdaterange', 
                                               label = 'Range of Dates to Map', 
                                               start = '2012-01-01', 
                                               end = '2012-12-31', 
                                               min = '2012-01-01', 
                                               max = '2012-12-31'
                                )
                              ), 
                              
                              # Main panel: display plotly map
                              mainPanel(
                                leafletOutput('heatmap')
                              )
                            )
                   )
))
