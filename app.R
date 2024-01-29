library(shiny)

source("gsheets_helpers.R")

if (dir.exists(".secrets")) {
  setup_gsheets_auth()
  GSHEETS <- connect_to_gsheets()
}

ui <- fluidPage(
  tags$link(
    rel = "stylesheet",
    type = "text/css",
    href = "style.css"
  ),
  div(
    id = "buttons-container",
    actionButton("faster_btn", "Faster 🐇"),
    actionButton("slower_btn", "Slower 🐢"),
    textInput("class", "Class code", value = "BAS475", placeholder = "BAS475"),
    textInput("room", "Class room", value = "HBB303", placeholder = "HBB303")
  )
)

server <- function(input, output, session) {
  class_id <- reactive({
    req(input$class, input$room)

    class_code <- toupper(gsub("[^0-9a-zA-Z]", "", input$class))
    class_room <- toupper(gsub("[^0-9a-zA-Z]", "", input$room))

    paste0(class_code, "_", class_room)
  })

  observeEvent(input$faster_btn, {
    req(class_id())

    send_faster_press(GSHEETS, class_id())
  })

  observeEvent(input$slower_btn, {
    req(class_id())

    send_slower_press(GSHEETS, class_id())
  })
}

shinyApp(ui, server)
