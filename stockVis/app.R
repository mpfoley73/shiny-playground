# Load packages ----
library(shiny)
library(bslib)
library(quantmod)

# Source helpers ----
source("helpers.R")

# User interface ----
ui <- page_sidebar(
  title = "stockVis",
  sidebar = sidebar(
    helpText(
      "Select a stock to examine.

        Information will be collected from Yahoo finance."
    ),
    textInput("symb", "Symbol", "SPY"),
    dateRangeInput(
      "dates",
      "Date range",
      start = "2013-01-01",
      end = as.character(Sys.Date())
    ),
    br(),
    br(),
    checkboxInput(
      "log",
      "Plot y axis on log scale",
      value = FALSE
    ),
    checkboxInput(
      "adjust",
      "Adjust prices for inflation",
      value = FALSE
    )
  ),
  card(
    card_header("Price over time"),
    plotOutput("plot")
  )
)

# Server logic
server <- function(input, output) {

  dataInput <- reactive({
    getSymbols(input$symb, src = "yahoo",
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })

  finalInput <- reactive({
    data <- dataInput()
    if (input$adjust) data <- adjust(data)
    return(data)
  })

  output$plot <- renderPlot({

    chartSeries(finalInput(), theme = chartTheme("white"),
                type = "line", log.scale = input$log, TA = NULL)
  })
  
  # output$plot <- renderPlot({
  # 
  #   dataInput <- getSymbols(
  #     input$symb, src = "yahoo",
  #     from = input$dates[1],
  #     to = input$dates[2],
  #     auto.assign = FALSE
  #   ) 
  #   
  #   if (input$adjust) {
  #     finalInput <- adjust(dataInput)
  #   } else {
  #     finalInput <- dataInput
  #   }
  # 
  #   chartSeries(finalInput, theme = chartTheme("white"),
  #               type = "line", log.scale = input$log, TA = NULL)
  # })

}

# Run the app
shinyApp(ui, server)
