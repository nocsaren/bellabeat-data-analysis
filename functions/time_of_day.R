
# > 22 | <= 05 : Night
# > 5  | <= 12 : Morning
# > 12 | <= 17 : Afternoon
# > 17 | <= 22 : Evening
    
time_of_day <- function(df) {
  df$time_of_day <- NA
  df$time_of_day[df$Hour > 22 | df$Hour <= 5] <- "Night"
  df$time_of_day[df$Hour > 5 & df$Hour <= 12] <- "Morning"
  df$time_of_day[df$Hour > 12 & df$Hour <= 17] <- "Afternoon"
  df$time_of_day[df$Hour > 17 & df$Hour <= 22] <- "Evening"
    return(df)
  }
  