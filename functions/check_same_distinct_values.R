# Load purrr package
library(purrr)

# Function to check if two data frames have the same distinct Id values
check_same_distinct_values <- function(df1, df2) {
  unique_values_df1 <- unique(df1$Id)
  unique_values_df2 <- unique(df2$Id)
  
  return(all(sort(unique_values_df1) == sort(unique_values_df2)))
}
