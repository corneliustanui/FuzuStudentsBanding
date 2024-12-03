# Project:     Fuzu Students Banding
# Author:      Cornelius Tanui (kiplimocornelius@gmail.com)
# Data source: Simulation
# Database:    N/A
# File name:   ui.R
# Purpose      UI Definition
# Date:        30 Nov 2024
# Version:     1

# load UI globals
source("mains/globals.R") 

# define UI elements
ui <- fluidPage(
  
  # app title
  titlePanel(title = div(icon("graduation-cap"), 
                         strong("Fuzu Students Banding"), 
                         style = "font-family: Cursive; font-size:24.5px"),
             windowTitle = "Fuzu Students Banding"),
  
  # sidebar with inputs
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      width = 3,
      style = "background-color:#B4CCDE",
      
      h4(style = "text-align:center", strong("WELCOME!")),
      
      p(style = "text-align:center",
        "Are you a university student in Kenya, and would you like to know where you lie in terms of banding for the award of Governmnet support towards your tuition and stay in school?", 
        strong("Fuzu Students Banding"), "does exacty that! Enter the details below and click", 
        strong("Generate Band")),
      
      hr(style = "border-top: 1px solid #000000;"),
      
      selectInput(inputId = "Gender",
                  label = "What is your sex?", 
                  choices = choices_sex,
                  selected = NULL),
      
      selectInput(inputId = "GeographicalLocation", 
                  label = "Select your home county.", 
                  choices = choices_counties,
                  selected = NULL),
      
      numericInput(inputId = "GrossFamilyIncome", 
                   label = "What is your family's gross monthly income (KES)?", 
                   min = 0,
                   value = 0),
      
      radioButtons(inputId = "Orphans", 
                   label = "Are you an Orphan or a Vulnerable Child (OVC)?",
                   choices = choices_yes_no,
                   selected = NULL,
                   inline = TRUE),
      
      radioButtons(inputId = "Disability",
                   label = "Are you a Person Living with Disability (PLWD)?", 
                   choices = choices_yes_no,
                   selected = NULL,
                   inline = TRUE),
      
      numericInput(inputId = "NumberOfDependents", 
                   label = "How many dependents are in your household?", 
                   min = 0,
                   value = 0),
      
      sliderInput(inputId = "PovertyProbabilityIndex", 
                  label = "On a scale of 1 to 100, what do you believe is your household poverty index? The smaller the value, the less likely it is that you are from a humble background.", 
                  value = 50,
                  min = 0,
                  max = 100,
                  step = 5),
      
      numericInput(inputId = "ProgramCostsKES", 
                   label = "What is the terminal total cost of the program you seek to pursue?", 
                   min = 0,
                   value = 0),
      
      shinyWidgets::actionBttn(inputId = "generate_bands",
                               label = "Generate Band",
                               icon = NULL,
                               style = "unite",
                               color = "primary",
                               size = "md",
                               block = TRUE,
                               no_outline = FALSE)

    ),
    
    # main page
    mainPanel = mainPanel(

      width = 9,
      
      p(tags$b("DISCLAIMER:"),
        "The training data was", tags$b(em("simulated")), "as described", 
        tags$a(href = "https://corneliustanui.rbind.io/content/posts/Simulation_2024-09-12/", "here"), 
        "and as such, the outcome does not reflect the reality."),
      
      p("© 2024", tags$a(href = "https://github.com/corneliustanui/FuzuStudentsBanding", "Cornelius Tanui")),
      
      hr(style = "border-top: 1px solid grey;"),
      
      # display the result
      textOutput("result")
    )
  )
)
