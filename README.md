# Fuel Consumption Logger -- Vibe coded with Claude

A small R script that prompts for odometer and fuel readings, calculates fuel
consumption for the trip, and optionally appends the result to a CSV log.

## Requirements

- R with the [tidyverse](https://www.tidyverse.org/) package installed
  ```r
  install.packages("tidyverse")
  ```

## Usage

Run interactively in RStudio (source the script), or from a terminal:

```bash
Rscript log_consumption.R
```

You'll be prompted for three values:

| Prompt              | Units |
|----------------------|-------|
| Start ODO            | miles |
| End ODO              | miles |
| Fuel consumed        | litres |

## What it does

1. Converts the miles driven to kilometres (`1 mile = 1.609344 km`).
2. Calculates consumption in **L/100km**.
3. Calculates consumption in **mpg (UK/imperial gallon)**.
4. Prints a one-line summary, e.g.:
   ```
   On this trip you drove 234.0 miles (376.59 km) at a consumption of 179.69 mpg (5.92 L/100km)
   ```
5. Asks `Add this to consumption.csv? (y/n)` — only writes a row to the log
   if you answer `y`.

## Output file

If you confirm the write, a row is added to `consumption.csv` in the working
directory (created automatically on first run) with these columns:

| Column      | Description                    |
|-------------|---------------------------------|
| Start       | Start odometer reading (miles) |
| End         | End odometer reading (miles)   |
| Fuel        | Fuel used (litres)             |
| Consumption | Consumption (L/100km)          |

## Notes

- `get_input()` handles prompting whether the script is run interactively
  (RStudio) or non-interactively via `Rscript`.
- The mpg figure uses the UK/imperial gallon (4.54609 L). For US gallons,
  swap in 3.78541.
- Nothing is written to disk unless you answer `y` at the final prompt.