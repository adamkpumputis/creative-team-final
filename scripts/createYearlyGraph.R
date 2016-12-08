makeYearGraph <- function(df) {
  yearly_crime_df <- select(df, Event.Clearance.Group) %>%
                     count(Event.Clearance.Group) 
  
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

