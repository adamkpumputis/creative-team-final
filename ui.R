<<<<<<< HEAD:ui.R
=======
# setwd('C:/Users/Justin/Documents/info201/creative-team-final')

>>>>>>> b9df0526cd12dab28f3a7ba7b34cbb55ff48bbcb:creative.team.final/ui.R
library(shiny)
library(leaflet)
library(dplyr)
library(plotly)

<<<<<<< HEAD:ui.R
=======
df <- read.csv('../project_data/filtered.csv')

>>>>>>> b9df0526cd12dab28f3a7ba7b34cbb55ff48bbcb:creative.team.final/ui.R
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
                                  incidents by the type of crimes by alphabetical order below."),
                                # Going to graph 911 calls by offence/topic for 2012 seperated by crime.
                                
                                # Output of plot number 1
                                plotlyOutput("yearlyCrimeMap", width = "80%", height = "300px"),
                                  
                                p("Surprisingly, the top three most reported topics were Disturbances,
                                  Car Prowling, and Robbery."),
                                
                                p("One thing that may not surprise you is that a majority of crime is centralized
                                  downtown. You can observe this on the map. For all categories, downtown has a higher
                                  number of incidents than its surrounding areas for the year 2012 with a few exceptions."),
                                
                                h4("Interesting outliers of note"),
                                
                                tags$ul(
                                  tags$li("Belltown has the most 911 calls for narcotic complaints for 2012"),
                                  tags$li("Rainier valley had the most 911 calls for drive-by shootings."),
                                  tags$li("Broadview has a large amount of prostitution cases along WA 99.")
                                ),
                                
                                h4("Looking at a specific month"),
                                
                                p("Let's take a look at the number of calls made over the year seperated by months."),
                                
                                plotlyOutput("monthlyNumberGraph", width = "80%", height = "300px"),
                                
                                p("As you can see, 911 calls increased in the summer and decreased as winter set in. Let's 
                                  see what sort of crimes was committed during the month of July."),
                                
                                plotlyOutput("julyGraph", width = "80%", height = "300px"),
                                
                                p("The vast majority of 911 calls in 2012 dealth mainly with disturbances. National holidays,
                                  such as the 4th of July, may be the cause of this uptick in 911 calls. Non-violent crimes
                                  such as robbery and theft are reported than assault and other violent crimes"),
                                
                                h4("Future Research"),
                                
                                p("This data set holds a lot of information and we can use this to answer
                                  some questions in both research and for general use."),
                                
                                strong("For research, some questions that can be asked are..."),
                                
                                tags$ul(
                                  tags$li("Are lower amounts of 911 calls correlated to the crime being reported? (i.e. Prostitution,Sexual Assualt)" ),
                                  tags$li("With this data, do certain courses of action reduce the number of 911 calls in certain areas?"),
                                  tags$li("How do certain tools (911 beacons, emergency phones) affect the number of 911 calls in certain regions?")
                                ),
                                
                                strong("For general use, some questions that can be asked are..."),
                                
                                tags$ul(
                                  tags$li("What neighborhoods are safe? Which neighborhood has more of a certain crime?"),
                                  tags$li("What areas do people need to be aware of when they travel?")
                                )
                              )
                            )
                   )
))