#
# This is my app from the Shiny Get Started site:
# 
#   https://shiny.posit.co/r/getstarted/shiny-basics/lesson2/
#

library(shiny)
library(bslib)

# Define UI ----
ui <- page_sidebar(
  title = "Dashboard Title",
  sidebar = sidebar("Sidebar", position = "left", title = "Sidebar Title"),
  value_box(
    title = "Value box",
    value = 100,
    showcase = bsicons::bs_icon("bar-chart"),
    theme = "teal"
  ),
  card(
    card_header(
      "Card Header"
    ),
    card_body(
      p("I guess this is a paragraph?"),
      p("And a second paragraph?")
    ),
    card_image("www/Chester6.jpg", height = "50%", width = "50%"),
    card_footer(
      "Card footer."
    )
  ),
  card(
    card_header(
      "Card Header #2"
    ),
    card_body(
      p("Paragraph 1"),
      p("Paragraph 2")
    ),
    card_footer(
      "Card footer #2."
    )
  )
)

# Define server logic ----
server <- function(input, output) {
  
}

# Run the app ----
shinyApp(ui = ui, server = server)
