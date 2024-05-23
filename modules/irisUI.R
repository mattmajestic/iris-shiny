irisUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    selectInput(ns("species"), "Select Species:", choices = unique(iris$Species)),
    selectInput(ns("x_var"), "Select X Variable:", choices = names(iris)[1:4]),
    selectInput(ns("y_var"), "Select Y Variable:", choices = names(iris)[1:4]),
    textInput(ns("label"), "Label for Findings:", ""),
    actionButton(ns("save_btn"), "Save Findings"),
    hr(),
    uiOutput(ns("saved_labels_ui")),
    actionButton(ns("load_btn"), "Load Findings"),
    actionButton(ns("delete_btn"), "Delete Selected Finding")
  )
}
