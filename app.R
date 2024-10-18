## load packages
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinycssloaders)
library(shinyjs)
library(tidyverse)

## load scripts

# must be executed first
source("./mains/globals.R") 

# load engine, must be executed second
multinom_fit <- readRDS("./mains/multinomial_regression_classifier.rds")

# optional, trains the engine
source("./mains/engine.R") 

# load UI definitions
source("./ui.R")

# load server definitions
source("./server.R")

# combine app elements
shinyApp(ui = ui, server = server)
