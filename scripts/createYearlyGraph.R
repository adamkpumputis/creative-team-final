library(shiny)
library(leaflet)
library(dplyr)
library(plotly)
library(lubridate)
setwd('C:/Users/Justin/Documents/info201/creative-team-final')
df <- read.csv('project_data/filtered.csv')

makeYearGraph <- function(df) {
  yearly_crime_df <- select(df, Event.Clearance.Group) %>%
                     count(Event.Clearance.Group)
  
  yearly_crime_df <- arrange(yearly_crime_df, n)
  
  yearGraph <- plot_ly(yearly_crime_df, x = ~Event.Clearance.Group,
                                y = ~n,
                                type = 'bar') %>%
       layout(xaxis = list(title="Types of Incidents during 911 calls",
                           showticklabels = FALSE
                          ),
              yaxis = list(title="Number of 911 calls")
            )
  return(yearGraph)
}

makeTimeGraph <- function(df) {
  time_df <- mutate(df, crime.month = month(Event.Clearance.Date)) %>%
             count(crime.month)
  time_df$crime.month <- c('January', 'February', 'March', 'April',
                           'May', 'June', 'July', 'August', 'September',
                           'October', 'November', 'December')
  time_df$crime.month <- factor(time_df$crime.month, levels = time_df[["crime.month"]])                      

  time.graph <- plot_ly(time_df,
                        x = ~crime.month,
                        y = ~n,
                        type = 'bar',
                        color = I("grey"),
                        name = "Number of 911 Calls by Month"
                        ) %>% 
                 layout(title="Number of 911 Calls by Month",
                        xaxis=list(title=""),
                        yaxis=list(title="Number of 911 Calls"),
                        margin = list(b = 110)
                    )
  return(time.graph)
}
