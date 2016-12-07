#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

setwd('C:/Users/Benjamin/Documents/Info201/creative-team-final/project_data')
df <- read.csv('Seattle_Police_Department_911_Incident_Response_2012.csv')

library(shiny)
library(leaflet)
library(dplyr)

crimes <- list("Assaults" = 'ASSAULTS', 
               "Auto Thefts" = 'AUTO THEFTS', 
               "Bike" = 'BIKE', 
               "Burglary" = 'BURGLARY', 
               "Car Prowl" = 'CAR PROWL', 
               "Disturbances" = 'DISTURBANCES',
               "Drive By (No Injury)" = 'DRIVE BY (NO INJURY)', 
               "Failure to Register (Sex Offender)" = 'FAILURE TO REGISTER (SEX OFFENDER)', 
               "Homicide" = 'HOMICIDE', 
               "Lewd Conduct" = 'LEWD CONDUCT', 
               "Narcotics Complaints" = 'NARCOTICS COMPLAINTS', 
               "Nuisance, Mischief" = 'NUISANCE, MISCHIEF', 
               "Persons - Lost, Found, Missing" = 'PERSONS - LOST, FOUND, MISSING', 
               "Property Damage" = 'PROPERTY DAMAGE', 
               "Prostitution" = 'PROSTITUTION', 
               "Reckless Burning" = 'RECKLESS BURNING', 
               "Robbery" = 'ROBBERY', 
               "Shoplifting" = 'SHOPLIFTING', 
               "Trespass" = 'TRESPASS', 
               "Weapons Calls" = 'WEAPONS CALLS'
)

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
                                            choices = crimes
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
                                                   choices = crimes
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
                   ),
                   
                   tabPanel('About',
                            # Creates a sidebar layout
                            sidebarLayout(
                              # Creates a sidebar panel. Used to give a overview of project
                              sidebarPanel(
                                h1("About this project"),
                                
                                p("This project was a collaboration to analyze Seattle's
                                  911 calls during the year of 2012. Using data from the
                                  Seattle Police Department, we were able to map and infer
                                  the locations and crimes that occured the most in Seattle.
                                  Enjoy!")
                              ),
                              
                              # Creates a main panel. Contains a variety of graphs on the dataset
                              mainPanel(
                                h3("Observations"),
                                
                                p("If you're pressed for time, here are a couple high level 
                                  observations about the dataset we're looking at!")
                                
                                # High level overview in text here.
                                
                                # Going to graph 911 calls by offence/topic for 2012 seperated by year.
                                
                                # Adding image of zone map from SPD or link. Image may be too big
                                
                                # Giving graph of count of 911 calls based by zone
                                
                                # Fast and furious is the game
                              )
                            )
                   )
))