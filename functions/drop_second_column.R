# Function to drop the "Second" column from a dataframe
drop_second_column <- function(df_name) {
  df <- get(df_name)
  if ("Second" %in% colnames(df)) {
    df <- df[ , !(colnames(df) %in% "Second")]
  }
  assign(df_name, df, envir = .GlobalEnv)
}