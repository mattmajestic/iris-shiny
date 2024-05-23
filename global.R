library(shiny)
library(datasets)
library(ggplot2)

# Load iris dataset
data(iris)

# Source all modules in the 'modules' directory
modules_path <- "modules"
modules_files <- list.files(modules_path, full.names = TRUE, pattern = "\\.R$")
lapply(modules_files, source)
