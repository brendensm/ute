library(googlesheets4)
library(dplyr)
library(lubridate)
library(blastula)
library(jsonlite)

# Load the service account JSON from an environment variable

service_account <- Sys.getenv("GOOGLE_SERVICE_ACCOUNT_JSON")


json_path <- tempfile(fileext = ".json")
writeLines(service_account, json_path)


# Authenticate using the service account key
gs4_auth(path = json_path)


data <- read_sheet("https://docs.google.com/spreadsheets/d/1Qszy3C8C794LdQF3dAU4ZzENPqeYAGeHOQn8ajDt2Qs/edit?gid=635450401#gid=635450401", sheet = 2) |>
  janitor::clean_names()

long <- data[,1:6]
sum <- data[,13:16]

notif_num <- month(Sys.Date())

h <- sum |>
  filter(month(notify_16) == notif_num)

monthly_breakdown <- long |>
  filter(month(due_date) == notif_num - 1)
