# Source the global.R file which loads modules dynamically
source("global.R")

# Source the UI and server files
source("ui.R")
source("server.R")

# Run the Shiny app
shinyApp(ui = ui, server = server)
