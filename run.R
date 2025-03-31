library(httr)


email <- blastula::render_email("blast.Rmd")



url <- "https://api.smtp2go.com/v3/email/send"


subject = paste(month(Sys.Date(), label=TRUE, abbr = FALSE), "Utility Bill Summary")


body <- list(
  api_key = Sys.getenv("SMTP2GO_KEY"),
  to = list(Sys.getenv("EMAIL_TO")),
  sender = "Brenden <me@brendenmsmith.com>",
  cc = Sys.getenv("CC_EMAIL"),
  subject = subject,
  html_body = email$html_html
)


response <- POST(url, body = body, encode = "json")


