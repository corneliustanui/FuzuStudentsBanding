## load packages
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinycssloaders)
library(shinyjs)
library(tidyverse)  # data processing packages
library(tidymodels) # model definition packages
library(parsnip)    # model definition functions
library(glmnet)     # model processing engine
library(shinyBS)    # for more info tooltip

# load UI definitions
source("./ui.R")

# load server definitions
source("./server.R")

# combine app elements
shinyApp(ui = ui, server = server)
