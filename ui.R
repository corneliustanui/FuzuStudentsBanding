# packages
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinycssloaders)
library(shinyjs)
library(tidyverse)

source("./globals.R")

# Define UI
ui <- fluidPage(
  
  # Application title
  titlePanel(title = div(icon("graduation-cap"), 
                         strong("Fuzu Students Banding"), 
                         style = "font-family: Cursive; font-size:24.5px")),
  
  sidebarLayout(
    
    # Sidebar with a slider input
    sidebarPanel = sidebarPanel(
      width = 3,
      style = "background-color:#B4CCDE",
      
      h4(style = "text-align:center", strong("WELCOME!")),
      
      p(style = "text-align:center",
        "Are you a university student in Kenya, and would you like to know where you lie in terms of banding for the award of Governmnet support towards your tuition and stay in school?", 
        strong("Fuzu Students Banding"), "does exacty that! Enter the details below and click", 
        strong("Allocate Band")),
      
      hr(style = "border-top: 1px solid #000000;"),
      
      textInput(inputId = "first_name", 
                label = "Enter your first name.", 
                value = "", 
                width = NULL, 
                placeholder = "Enter first name"),
      
      textInput(inputId = "last_name", 
                label = "Enter your last name.", 
                value = "", 
                width = NULL, 
                placeholder = "Enter last name"),
      
      selectInput(inputId = "sex",
                  label = "What is your sex?", 
                  choices = choices_sex,
                  selected = NULL),
      
      selectInput(inputId = "geographical_location", 
                  label = "Select your home county.", 
                  choices = choices_counties,
                  selected = NULL),
      
      textInput(inputId = "university", 
                label = "Which college/university have you been invited to?", 
                value = "", 
                width = NULL, 
                placeholder = "Leave blank if none"),
      
      numericInput(inputId = "gross_monthly_family_income", 
                   label = "What is your monthly gross family income (KES)?", 
                   min = 0,
                   value = 0),
      
      radioButtons(inputId = "orphan_vulnerable_child", 
                   label = "Are you an Orphan or a Vulnerable Child (OVC)?",
                   choices = choices_yes_no,
                   selected = NULL,
                   inline = TRUE),
      
      radioButtons(inputId = "living_with_disability",
                   label = "Are you a Person Living with Disability (PLWD)?", 
                   choices = choices_yes_no,
                   selected = NULL,
                   inline = TRUE),
      
      numericInput(inputId = "number_of_dependents", 
                   label = "How many dependents are in your household?", 
                   min = 0,
                   value = 0),
      
      sliderInput(inputId = "poverty_probability_index", 
                  label = "On a scale of 1 to 100, what do you believe is your household poverty index? The smaller the value, the less likely it is that you are from a humble background.", 
                  value = 50,
                  min = 0,
                  max = 100,
                  step = 5),
      
      numericInput(inputId = "ProgramCostsKES", 
                   label = "What is the terminal total cost of the program you seek to pursue?", 
                   min = 0,
                   value = 0)

    ),
    
    # main page
    mainPanel = mainPanel(
      width = 9,
      
      tabsetPanel(
        tabPanel(strong("Citations"),
                 
                 fluidPage(
                   column(width = 6,
                          
                          "table"),
                   
                   column(width = 6,
                          
                          "graph")
                 )
                 
        ),
        
        
        tabPanel(strong("Data")))
      
    )
  )
)