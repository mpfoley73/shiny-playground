#
# This is my app from the Shiny Get Started site:
# 
#   https://shiny.posit.co/r/getstarted/shiny-basics/lesson3/
#

library(shiny)
library(bslib)

ui <- page_fluid(
  titlePanel("Basic Widgets"),
  # layout_columns defines a 12 column grid.
  layout_columns(
    col_widths = c(4, 4, 4),
    card(
      card_header("Buttons"),
      actionButton("action", "Action"),
      submitButton("Submit")
    ),
    card(
      card_header("Checkboxes"),
      checkboxInput("checkbox", "Single Choice", value = TRUE),
      checkboxGroupInput(
        "checkGroup",
        "Multiple Choice",
        choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3)
      )
    ),
    card(
      card_header("Dates"),
      dateInput("date", "Single Date", value = "2014-01-01"),
      dateRangeInput("dates", "Date Range")
    ),
    card(
      card_header("File input"),
      fileInput("file", "Select a file")
    ),
    card(
      card_header("Help text"),
      helpText("Not a true widget, but useful for",
               "accompanying other widgets.")
    ),
    card(
      card_header("Keyed inputs"),
      numericInput("num", "Input number", value = 1),
      textInput("text", label = NULL, value = "Enter text")
    ),
    card(
      card_header("Radio buttons"),
      radioButtons(
        "radio",
        "Select option",
        choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3),
        selected = 2
      )
    ),
    card(
      card_header("Select box"),
      selectInput(
        "select",
        "Select option",
        choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3),
        selected = 2
      )
    ),
    card(
      card_header("Sliders"),
      sliderInput("slider1", "Set value", min = 0, max = 100, value = 50),
      sliderInput("slider2", "Set range", min = 0, max = 100, value = c(25, 75))
    )
  )
)

server <- function(input, output) {
  
}

shinyApp(ui = ui, server = server)

