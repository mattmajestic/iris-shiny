irisServer <- function(id, rv) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    load_findings <- function() {
      data_dir <- "data"
      files <- list.files(data_dir, pattern = "\\.rds$", full.names = TRUE)
      findings <- lapply(files, readRDS)
      names(findings) <- gsub("\\.rds$", "", basename(files))
      findings
    }
    
    save_finding <- function(label, finding) {
      data_dir <- "data"
      if (!dir.exists(data_dir)) {
        dir.create(data_dir)
      }
      saveRDS(finding, file = file.path(data_dir, paste0(label, ".rds")))
      rv$data <- load_findings()
    }
    
    delete_finding <- function(label) {
      data_dir <- "data"
      file <- file.path(data_dir, paste0(label, ".rds"))
      if (file.exists(file)) {
        file.remove(file)
      }
      rv$data <- load_findings()
    }
    
    observe({
      rv$data <- load_findings()
    })
    
    observeEvent(input$save_btn, {
      if (input$label != "" && input$x_var != input$y_var) {
        finding <- list(
          species = input$species,
          x_var = input$x_var,
          y_var = input$y_var,
          label = input$label
        )
        save_finding(input$label, finding)
      }
    })
    
    observeEvent(input$load_btn, {
      if (!is.null(input$saved_labels)) {
        finding <- rv$data[[input$saved_labels]]
        updateSelectInput(session, "species", selected = finding$species)
        updateSelectInput(session, "x_var", selected = finding$x_var)
        updateSelectInput(session, "y_var", selected = finding$y_var)
        updateTextInput(session, "label", value = finding$label)
      }
    })
    
    observeEvent(input$delete_btn, {
      if (!is.null(input$saved_labels)) {
        delete_finding(input$saved_labels)
      }
    })
    
    output$saved_labels_ui <- renderUI({
      selectInput(ns("saved_labels"), "Saved Labels:", choices = names(rv$data))
    })
    
    filtered_data <- reactive({
      req(input$species, input$x_var, input$y_var)
      iris[iris$Species == input$species, ]
    })
    
    output$xy_plot <- renderPlot({
      req(input$species, input$x_var, input$y_var)
      ggplot(filtered_data(), aes_string(x = input$x_var, y = input$y_var)) +
        geom_point() +
        labs(title = paste(input$species, "-", input$x_var, "vs.", input$y_var))
    })
    
    output$corr_coeff <- renderText({
      req(input$species, input$x_var, input$y_var)
      cor_val <- cor(filtered_data()[[input$x_var]], filtered_data()[[input$y_var]])
      paste("Correlation Coefficient:", round(cor_val, 2))
    })
    
    output$loaded_label_ui <- renderUI({
      if (!is.null(input$saved_labels)) {
        finding <- rv$data[[input$saved_labels]]
        if (!is.null(finding)) {
          paste("Loaded Finding:", finding$label)
        }
      }
    })
  })
}
