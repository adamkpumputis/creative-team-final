setwd('C:/Users/Justin/Documents/info201/creative-team-final')

library(shiny)
library(leaflet)
library(dplyr)
library(plotly)

df <- read.csv('./project_data/filtered.csv')

# A list of crimes to include in the checkbox widget
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
                                            label = 'Choose what crimes to see on the map!', 
                                            choices = crimes
                                )
                              ),
                              # Main panel: display plotly map
                              mainPanel(
                                p("Click on the pins to zoom in and to view more information!"),
                                leafletOutput('map')
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
                                  observations about the dataset we're looking at!"),
                                
                                # High level overview in text here.
                                h4("Types of Crime"), 
                                p("We utilized a subset of 90,547 911 calls for 2012. We've graph these 
                                  incidents by the type of crimes below."),
                                # Going to graph 911 calls by offence/topic for 2012 seperated by crime.
                                
                                plotlyOutput("yearlyCrimeMap", width = "80%", height = "300px"),
            
                                p("Surprisingly, the top three most reported topics were Traffic-Related
                                  Calls, Suspicious Circumstances, and Disturbances."),
                                
                                p("One thing that may not surprise you is that a majority of crime is centralized
                                  downtown. You can observe this on the map. For all categories, downtown has a higher
                                  number of incidents than its surrounding areas for the year 2012 with a few exceptions."),
                                
                                p("Interesting outliers of note"),
                                
                                tags$ul(
                                  tags$li("Belltown has the most 911 calls for narcotic complaints for 2012"),
                                  tags$li("Rainier valley had the most 911 calls for drive-by shootings."),
                                  tags$li("Broadview has a large amount of prostitution cases along WA 99.")
                                ),
                                
                                plotlyOutput("monthlyNumberGraph", width = "80%", height = "300px")
                                
                              )
                            )
                   )
))