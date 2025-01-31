library(googlesheets4)
library(dplyr)
library(lubridate)
library(blastula)
library(jsonlite)


gs4_deauth()

# type <- "service_account"
# project_id <- Sys.getenv("PROJECT_ID")
# private_key_id <- Sys.getenv("PRIVATE_KEY_ID")
# private_key <- Sys.getenv("PRIVATE_KEY")
# client_email <- Sys.getenv("CLIENT_EMAIL")
# client_id <- Sys.getenv("CLIENT_ID")
# auth_uri <- "https://accounts.google.com/o/oauth2/auth"
# token_uri <- "https://oauth2.googleapis.com/token"
# auth_provider_x509_cert_url <-  Sys.getenv("AUTH_PROVIDER_X509_CERT_URL")
# client_x509_cert_url <- Sys.getenv("CLIENT_X509_CERT_URL")
# universe_domain <-  "googleapis.com"
#
# service_account <- list(
#   type = type,
#   project_id = project_id,
#   private_key_id = private_key_id,
#   private_key = private_key,
#   client_email = client_email,
#   client_id = client_id,
#   auth_uri = auth_uri,
#   token_uri = token_uri,
#   auth_provider_x509_cert_url= auth_provider_x509_cert_url,
#   client_x509_cert_url = client_x509_cert_url,
#   universe_domain = universe_domain
# )

#json_content <- toJSON(service_account, pretty = TRUE, auto_unbox = TRUE)



json_string <- Sys.getenv("GOOGLE_SERVICE_ACCOUNT_JSON")

# Create a temporary file to store the JSON
temp_file <- tempfile(fileext = ".json")

# Write the JSON string to the temporary file
writeLines(json_string, temp_file)

# Authenticate using the temporary file
gs4_auth(path = temp_file)

# Clean up
unlink(temp_file)



# gs4_auth(path = json_content)


data <- read_sheet("https://docs.google.com/spreadsheets/d/1Qszy3C8C794LdQF3dAU4ZzENPqeYAGeHOQn8ajDt2Qs/edit?gid=635450401#gid=635450401", sheet = 3) |>
  janitor::clean_names()

long <- data[,1:6]
sum <- data[,8:11]

notif_num <- month(Sys.Date())

h <- sum |>
  filter(month(notify) == notif_num)

monthly_breakdown <- long |>
  filter(month(due_date) == notif_num - 1)






