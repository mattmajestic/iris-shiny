library(shiny)
library(shinythemes)

shinyUI(fluidPage(
  shinythemes::themeSelector(),
  theme = shinytheme("cosmo"),
  tags$head(
    tags$script(src = "custom.js")
  ),
  titlePanel("Iris Dataset Exploration"),
  sidebarLayout(
    sidebarPanel(
      irisUI("iris"),
      uiOutput("iris-saved_labels_ui"),
      uiOutput("iris-loaded_label_ui"),
      actionButton("alert_btn", "Show JavaScript Alert")
    ),
    mainPanel(
      plotOutput("iris-xy_plot"),
      textOutput("iris-corr_coeff")
    )
  )
))
