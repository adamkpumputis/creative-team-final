# Function to create a histogram representing the number of calls for each crime group.
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

# Function to create a bar graph showing the total number of calls in each month.
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

# Function to create a pie chart to visualize the distribution of the calls.
make_july_graph <- function(df) {
  july_df <- mutate(df, crime.month = month(Event.Clearance.Date)) %>%
             filter(crime.month == 7) %>%
             count(Event.Clearance.Group)

  july_pie_graph <- plot_ly(july_df,
                            labels = ~Event.Clearance.Group,
                            values = ~n,
                            type = 'pie',
                            showlegend = FALSE
                            ) %>%
                    layout(title = "911 Calls Topics during July, 2012",
                           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
                           )
  return(july_pie_graph)
}