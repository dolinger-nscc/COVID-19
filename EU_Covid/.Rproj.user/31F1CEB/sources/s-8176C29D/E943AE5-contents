# Remove all data items ####
# Clear the environment when running the entire script from the "source" command
rm(list = ls())

#these libraries are necessary
# load from ecdc ####
library(readxl)
library(httr)

#create the URL where the dataset is stored with automatic updates every day

url <- paste("https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-",format(Sys.time(), "%Y-%m-%d"), ".xlsx", sep = "")

#download the dataset from the website to a local temporary file

GET(url, authenticate(":", ":", type="ntlm"), write_disk(tf <- tempfile(fileext = ".xlsx")))

#read the Dataset sheet into “R”

data <- read_excel(tf)

# Load Tidyverse ####
library(tidyverse)
tib <- as_tibble(data)
is_tibble(tib)

# Do any mutations needed or na's etc.
tib <- tib %>%
mutate(
    `Countries and territories` = case_when (
        GeoId == "CA"  ~ "Canada",
        TRUE  ~ `Countries and territories`
    )
  )

tib <- tib %>%
mutate(
  Pop_Data.2018 = case_when(
      GeoId == "CA" ~ "37058856",
      TRUE ~ "37058856"
  )

)


options(scipen = 999)
tib <-
tib %>%
  mutate(Countries = `Countries and territories`, Pop = Pop_Data.2018) %>%
  select(Countries, GeoId, DateRep, Cases, Deaths, Pop, Year, Month, Day) %>%
  arrange(GeoId, DateRep) 

# test area ####
tib %>%
  group_by(Countries) %>%
  summarise(n = n(), totCases = sum(Cases), totDeaths = sum(Deaths)) %>%
  arrange(desc(totCases)) %>%
  View()
