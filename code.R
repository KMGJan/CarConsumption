suppressPackageStartupMessages(
  library(tidyverse)
)

file_path <- "consumption.csv"

# Works whether you run this interactively (RStudio) or via Rscript from a terminal
get_input <- function(prompt) {
  if (interactive()) {
    readline(prompt)
  } else {
    cat(prompt)
    readLines("stdin", n = 1)
  }
}

start <- as.numeric(get_input("Start ODO (miles): "))
end <- as.numeric(get_input("End ODO (miles): "))
fuel <- as.numeric(get_input("Fuel consumed (L): "))

distance_km <- (end - start) * 1.609344
consumption <- round(fuel / distance_km * 100, 2)

new_row <- tibble(
  Start = start,
  End = end,
  Fuel = fuel,
  Consumption = consumption
)


miles_driven <- end - start
cat(sprintf(
  "On this trip you drove %.0f miles (%.2f km) at a consumption of %.2f mpg (%.2f L/100km)\n",
  miles_driven,
  distance_km,
  round(miles_driven / (consumption / 4.54609), 2),
  consumption
))

answer <- tolower(get_input("Add this to consumption.csv? (y/n): "))

if (answer == "y") {
  write_csv(new_row, file_path, append = file.exists(file_path))
  message("Row added to ", file_path)
} else {
  message("Not saved.")
}
