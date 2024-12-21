# census-app

[Lesson 4](https://shiny.posit.co/r/getstarted/shiny-basics/lesson4/) and [5](https://shiny.posit.co/r/getstarted/shiny-basics/lesson5/) of Shiny's *Get Started* web site connects widgets to reactive objects.

Reactive output is generated in the server function. Objects are reactive if the code that builds it calls a widget value.

Lesson 4 lists eight output functions producing text, images, plots, tables, etc. Add the function to the main panel with an output id (e.g., `plotOutput(outputId = "distPlot")`). Then in the `server()` function, define the behavior of the object (e.g., `output$distPlot <- renderPlot({})`). Each reactive object should have a corresponding `output$` definition in `server()`. Functions like `renderPlot()` are reactive, and they execute the code in braces whenever inputs change.

Lesson 5 shows you where to place your app code. The shinyApp function runs when you launch your app. `server()` runs when a user visits your app. The R expressions inside `render*` functions run when the user changes a widget value. Source scripts, load libraries, and read data sets at the _beginning_ of `app.R`, outside the server function. Define user specific objects inside server function, but outside of any render* calls.
