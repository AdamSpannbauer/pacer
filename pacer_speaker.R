sleep_sec <- 20
source("gsheets_helpers.R")

setup_gsheets_auth()
GSHEETS <- connect_to_gsheets()
messages <- read_messages(GSHEETS)
message_count <- nrow(messages)

while (TRUE) {
  messages <- read_messages(GSHEETS)
  if (nrow(messages) > message_count) {
    new_message <- tail(messages$message, 1)

    say_this <- NULL
    if (new_message == "slower") {
      say_this <- "please slow down"
    } else if (new_message == "faster") {
      say_this <- "please speed up"
    }

    if (!is.null(say_this)) {
      cmd <- paste("say", say_this)
      system(cmd)
    }
  }

  Sys.sleep(sleep_sec)
}
