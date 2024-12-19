#
# This is App-1 from the Shiny Get Started site:
# 
#   https://shiny.posit.co/r/getstarted/shiny-basics/lesson1/
#   

library(shiny)
library(bslib)
library(tidyverse)

# Define UI for app that draws a histogram ----
ui <- page_sidebar(
  # App title ----
  title = "My First Shiny App",
  # Sidebar panel for inputs ----
  sidebar = sidebar(
    # Input: Slider for the number of bins ----
    sliderInput(
      inputId = "bins",
      label = "Number of bins:",
      min = 1,
      max = 50,
      value = 30
    )
  ),
  # Output: Histogram ----
  plotOutput(outputId = "distPlot")
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({
    
    faithful |>
      ggplot(aes(x = waiting)) +
      geom_histogram(bins = input$bins, fill = "#007bc2", color = "white") +
      labs(
        x = "Waiting time to next eruption (in mins)",
        title = "My Histogram of waiting times"
      ) +
      theme_minimal() +
      theme(plot.title = element_text(size = 18, color = "dodgerblue4"))

  })
  
}

shinyApp(ui = ui, server = server)
