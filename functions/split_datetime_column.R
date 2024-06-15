split_datetime_column <- function(df_name) {
  # Load necessary library
  library(dplyr)
  
  # Get the dataframe by name
  df <- get(df_name, envir = .GlobalEnv)
  
  # Function to check if a column can be converted to datetime
  is_datetime_column <- function(column) {
    # Check for the presence of non-numeric characters
    if (any(grepl("[^0-9]", column))) {
      tryCatch({
        as.POSIXct(column, format = "%m/%d/%Y %I:%M:%S %p", tz = "UTC")
        TRUE
      }, error = function(e) {
        FALSE
      })
    } else {
      FALSE
    }
  }
  
  # Find the first column that can be converted to datetime
  datetime_col <- NULL
  for (col in colnames(df)) {
    if (is_datetime_column(df[[col]])) {
      datetime_col <- col
      break
    }
  }
  
  # Ensure a datetime column was found
  if (is.null(datetime_col)) {
    stop("No column with datetime format found in dataframe ", df_name)
  }
  
  # Convert the datetime string to a POSIXct object
  df[[datetime_col]] <- as.POSIXct(df[[datetime_col]], format = "%m/%d/%Y %I:%M:%S %p", tz = "UTC")
  
  # Create separate date and time columns
  df$Date <- as.Date(df[[datetime_col]])
  df$Hour <- as.numeric(format(df[[datetime_col]], "%H"))
  df$Minute <- as.numeric(format(df[[datetime_col]], "%M"))
  df$Second <- as.numeric(format(df[[datetime_col]], "%S"))
  
  # Remove the original datetime column
  df <- df %>% select(-all_of(datetime_col))
  
  # Assign the modified dataframe back to the original name in the global environment
  assign(df_name, df, envir = .GlobalEnv)
  
  # Return the modified dataframe
  return(df)
}

# Example usage
# Assuming the dataframe 'example' has a column with the format "4/12/2016 12:00:00 AM"
