## load packages
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinycssloaders)
library(shinyjs)
library(tidyverse)

# load UI definitions
source("./ui.R")

# load server definitions
source("./server.R")

# combine app elements
shinyApp(ui = ui, server = server)
