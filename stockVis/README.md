# stockVis

[Lesson 6](https://shiny.posit.co/r/getstarted/shiny-basics/lesson6/) of Shiny's *Get Started* web site demonstrates how to optimize performance. The stock ticker app does not need to download price history each time the user changes a display option. Accomplish this with a _reactive expression_. Instead of making `finalInput` a variable that is loaded each time `input$symb`, `input$dates`, `input$adjust`, or `input$log` changes...

``` r
server <- function(input, output) {

  output$plot <- renderPlot({

    dataInput <- getSymbols(
      input$symb, src = "yahoo",
      from = input$dates[1],
      to = input$dates[2],
      auto.assign = FALSE
    ) 
    
    if (input$adjust) {
      finalInput <- adjust(dataInput)
    } else {
      finalInput <- dataInput
    }

    chartSeries(finalInput, theme = chartTheme("white"),
                type = "line", log.scale = input$log, TA = NULL)
  })

}
```

make it a reactive function that runs only when `input$symb`, `input$dates`, or `input$adjust` changes. In fact, make `dataInput` react only to `input$symb` and `input$dates`, and create `finalInput` that additionally reacts to `input$adjust`. 

``` r
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

}
```

Shiny re-builds object if i) an input value in the object’s `render*` function changes, or
ii) a reactive expression in the object’s `render*` function becomes obsolete. Shiny does a great job understanding which input objects trigger reloading an output object, but you can (and should) take the time create dependency layers that potentially avoid tasks that produce the same output.

