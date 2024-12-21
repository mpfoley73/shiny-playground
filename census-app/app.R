#
# This is my app from the Shiny Get Started site:
# 
#   https://shiny.posit.co/r/getstarted/shiny-basics/lesson4/
#   https://shiny.posit.co/r/getstarted/shiny-basics/lesson5/
#

library(shiny)
library(bslib)
library(maps)
library(mapproj)

source("helpers.R")
counties <- readRDS("data/counties.rds")

ui <- fluidPage(

    titlePanel("censusVis"),

    sidebarLayout(
        sidebarPanel(
            helpText(
              "Create demographic maps with information from the 2010 US Census."
            ),
            selectInput(
              "var",
              label = "Choose a variable to display",
              choices = list(
                "Percent White",
                "Percent Black",
                "Percent Hispanic",
                "Percent Asian"
              ),
              selected = "Percent White"
            ),
            sliderInput(
              "range",
              label = "Range of interest",
              min = 0, max = 100, value = c(0, 100)
            )
        ),

        mainPanel(
           textOutput("selected_var"),
           textOutput("selected_range"),
           card(plotOutput("map"))
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$selected_var <- renderText({
      input$var
    })
    
    output$selected_range <- renderText({
      input$range
      glue::glue("You have chosen a range from {input$range[1]} to ",
           "{input$range[2]}.")
    })
    
    output$map <- renderPlot({
      
      data <- switch(input$var,
                     "Percent White" = counties$white,
                     "Percent Black" = counties$black,
                     "Percent Hispanic" = counties$hispanic,
                     "Percent Asian" = counties$asian)
      
      color <- switch(input$var,
                     "Percent White" = "darkgreen",
                     "Percent Black" = "salmon",
                     "Percent Hispanic" = "goldenrod",
                     "Percent Asian" = "dodgerblue")
      
      title <- switch(input$var,
                      "Percent White" = "% White",
                      "Percent Black" = "% Black",
                      "Percent Hispanic" = "% Hispanic",
                      "Percent Asian" = "% Asian")

      percent_map(
        var = data, 
        color = color, 
        legend.title = title, 
        max = input$range[2], 
        min = input$range[1]
      )
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
