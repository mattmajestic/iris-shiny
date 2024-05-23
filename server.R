library(shiny)

shinyServer(function(input, output, session) {
  rv <- reactiveValues(data = list())
  irisServer("iris", rv)
})
