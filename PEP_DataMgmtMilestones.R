# Create milestones figure for PEP data management
# S. Koslovsky, December 2024

# Based on code from this website: https://benalexkeen.com/creating-a-timeline-graphic-using-r-and-ggplot2/
# And then this one: https://stackoverflow.com/questions/44265512/creating-a-timeline-in-r
# And this one: https://stackoverflow.com/questions/78446732/how-to-assign-colors-to-variables-using-gg-vistime


# Load libraries
library(ggplot2)
library(forcats)
library(tidyverse)

library(vistime)


# Create table of milestones (ordered by group, end date within each year grouping)
default_end <- 2026
df <- data.frame(start = 2017, end = default_end, milestone = "PEP Data Management Plan developed", status = "On-going", group = "Admin")
df <- rbind(df, c(2017, default_end, "PEP PostgreSQL DB created", "On-going", "Admin"))
df <- rbind(df, c(2017, 2018, "Coastal Pv data renovation", "Completed", "Harbor seals"))
df <- rbind(df, c(2017, 2020, "ChESS data innovation", "Completed", "Ice seals"))

df <- rbind(df, c(2018, 2019, "LAN reorganization", "Completed", "Admin"))
df <- rbind(df, c(2018, 2019, "Coastal Pv counting innovation", "Completed", "Harbor seals"))
df <- rbind(df, c(2018, 2019, "Capture data renovation", "Completed", "Tag/sample/measure"))

df <- rbind(df, c(2019, 2021, "Glacial Pv data innovation", "Completed", "Harbor seals"))
df <- rbind(df, c(2019, 2020, "BOSS data renovation", "Completed", "Ice seals"))
df <- rbind(df, c(2019, 2022, "Kotz/Deadhorse ice seal data innovation", "Completed", "Ice seals"))
df <- rbind(df, c(2019, 2023, "Ice seal annotation data innovation", "Completed", "Ice seals"))
df <- rbind(df, c(2019, 2025, "KAMERA development and data innovation", "On-going", "Ice seals"))
df <- rbind(df, c(2019, 2022, "Telemetry data innovation", "Completed", "Tag/sample/measure"))

df <- rbind(df, c(2020, 2021, "Glacial Pv migration to KAMERA", "Completed", "Harbor seals"))
df <- rbind(df, c(2020, 2023, "Species misclassification data innovation", "Completed", "Ice seals"))

df <- rbind(df, c(2021, 2022, "Inventory data renovation", "Completed", "Admin"))
df <- rbind(df, c(2021, 2022, "PEP Google Drive organization", "Completed", "Admin"))
df <- rbind(df, c(2021, 2024, "PEP Dashboard innovation", "Completed", "Admin"))
df <- rbind(df, c(2022, 2025, "Glacial Pv counting renovation", "On-going", "Harbor seals"))
df <- rbind(df, c(2021, 2022, "Annotation life cycle innovation", "Completed", "Ice seals"))
df <- rbind(df, c(2021, 2023, "JoBSS data innovation", "Completed", "Ice seals"))
df <- rbind(df, c(2021, 2024, "Body condition data innovation", "Completed", "Tag/sample/measure"))

df <- rbind(df, c(2022, 2023, "pepGeodatabase innovation", "Completed", "Admin"))
df <- rbind(df, c(2022, default_end, "pepDataConnect innovation", "On-going", "Admin"))

df <- rbind(df, c(2023, default_end, "Increased focus on documentation", "On-going", "Admin"))
df <- rbind(df, c(2023, 2023, "Coastal Pv counting renovation", "Completed", "Harbor seals"))
df <- rbind(df, c(2023, 2025, "Abundance Shiny app", "On-going", "Harbor seals"))
df <- rbind(df, c(2023, 2024, "Capture sample results renovation", "Completed", "Tag/sample/measure"))

df <- rbind(df, c(2024, 2026, "At sea Shiny app", "On-going", "Admin"))
df <- rbind(df, c(2024, 2025, "2024 survey data management", "On-going", "Ice seals"))
df <- rbind(df, c(2024, default_end, "Body condition renovation for new drone data", "Planned", "Tag/sample/measure"))

df <- rbind(df, c(2025, 2025, "PEP Data Days", "Now", "Admin"))
df <- rbind(df, c(2025, 2025, "Shiny apps live", "Planned", "Admin"))
df <- rbind(df, c(2025, default_end, "2025 survey data management", "Planned", "Ice seals"))
df <- rbind(df, c(2025, default_end, "Telemetry data renovation", "Planned", "Tag/sample/measure"))

df <- df %>%
  mutate(start_date = ymd(sprintf('%04d%02d%02d', as.integer(start), 1, 1)),
         end_date = ymd(sprintf('%04d%02d%02d', as.integer(end), 12, 31))) %>%
  mutate(status_colors = ifelse(status == "On-going", "cadetblue3",
                                ifelse(status == "Completed", "chartreuse3",
                                       ifelse(status == "Planned", "darkorange3", 
                                              ifelse(status == "Now", "deeppink2", "darkgrey")))))

fig <- gg_vistime(df, col.event = "milestone", col.group = "group", col.start = "start_date", col.end = "end_date",
                  linewidth = 8, optimize_y = FALSE, col.color = "status_colors") +
    labs(title = "PEP Data Management Milestones",
         x = "Year",
         y = "Milestone") 

print(fig)
