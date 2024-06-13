load_csv_files <- function(folder_path) {
  # Load the tidyverse package
  library(tidyverse)
  
  # Get a list of all CSV files in the folder
  csv_files <- list.files(path = folder_path, pattern = "*.csv", full.names = TRUE)
  
  # Create an empty list to store names of tibbles
  tibble_names <- c()
  
  # Loop through each CSV file
  for (file in csv_files) {
    # Extract file name without extension
    file_name <- tools::file_path_sans_ext(basename(file))
    
    # Read the CSV file into a tibble
    tibble <- read_csv(file, show_col_types = FALSE)
    
    # Assign the tibble to a variable named by the file name
    assign(file_name, tibble, envir = .GlobalEnv)
    
    # Add the tibble name to the list
    tibble_names <- c(tibble_names, file_name)
    cat("File", file, "loaded.", "\n")
  }
  
  # Return the list of tibble names
  return(tibble_names)
}