# Project:     Fuzu Students Banding
# Author:      Cornelius Tanui (kiplimocornelius@gmail.com)
# Data source: Simulation
# Database:    N/A
# File name:   app.R
# Purpose      App Definition
# Date:        30 Nov 2024
# Version:     1

## load packages
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinycssloaders)
library(shinyjs)
library(tidyverse)  # data processing packages
library(tidymodels) # model definition packages
library(parsnip)    # model definition functions
library(workflows)  # model definition functions
library(glmnet)     # model processing engine

options(shiny.error = function() traceback())

# load UI definitions
source("ui.R")

# load server definitions
source("server.R")

# combine app elements
shinyApp(ui = ui, server = server)
