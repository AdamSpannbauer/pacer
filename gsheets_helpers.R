# Not a scalable sustainable architecture...
# Just prototyping and if tool is successful then real solution
# Don't you judge me
library(googledrive)
library(googlesheets4)
library(gargle)

GSHEETS_URL <- "https://docs.google.com/spreadsheets/d/1lv3p_cJsygWuignQdnOw9fDTRvneYsk31_1wU3RmQx4/edit?usp=sharing"

setup_gsheets_auth <- function() {
  # https://stackoverflow.com/a/59910070
  options(gargle_oauth_cache = ".secrets")
  googledrive::drive_auth(cache = ".secrets", email = "spannbaueradam@gmail.com")
  googlesheets4::gs4_auth(token = googledrive::drive_token())
}


connect_to_gsheets <- function() {
  googlesheets4::gs4_get(GSHEETS_URL)
}


read_messages <- function(sheets_obj) {
  googlesheets4::read_sheet(sheets_obj)
}


send_button_press <- function(sheets_obj, class_id = "BAS475_HBB303", message = c("slower", "faster")) {
  time_stamp <- as.character(Sys.time())

  record <- data.frame(
    time_stamp = time_stamp,
    class_id = class_id,
    message = message
  )

  sheet_append(
    ss = sheets_obj,
    data = record,
    sheet = "messages"
  )
}


send_slower_press <- function(sheets_obj, class_id = "BAS475_HBB303") {
  send_button_press(sheets_obj, class_id, message = "slower")
}


send_faster_press <- function(sheets_obj, class_id = "BAS475_HBB303") {
  send_button_press(sheets_obj, class_id, message = "faster")
}
