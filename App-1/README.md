# App-1

[Lesson 1](https://shiny.posit.co/r/getstarted/shiny-basics/lesson1/) of Shiny's *Get Started* web site uses App-1 to introduce Shiny.

Shiny apps are defined in a single script named `app.R` with three components: 

``` r
ui <- 

server <- function()

shinyApp(ui = ui, server = server)
```

Run the app from your console with a call to `runApp()`.

``` r
library(shiny)
runApp("App-1")
```

Even better, show the associated code and this README by running in "showcase mode", `runApp("App-1", display.mode = "showcase")`. I modified the example to use ggplot.
