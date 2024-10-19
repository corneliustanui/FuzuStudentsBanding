# load UI globals
source("./mains/globals.R") 
more_info <- "This is machine learning application powered by a multinomial regression. The training data was simulated, and as such the outcome does not reflect the reality. © 2024 Cornelius Tanui"

# define UI elements
ui <- fluidPage(
  
  # app title
  titlePanel(title = div(icon("graduation-cap"), 
                         strong("Fuzu Students Banding"), 
                         style = "font-family: Cursive; font-size:24.5px", 
                         shinyBS::bsButton("more_info", 
                                           label = "", 
                                           icon = icon("info", lib = "font-awesome"), 
                                           style = "info", 
                                           size = "extra-small"))),
  
  shinyBS::bsPopover(
    id = "more_info",
    title = HTML("<b>About</b>"),
    content = HTML(more_info),
    placement = "right",
    trigger = "hover",
    options = list(container = "body")
  ),
  
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
      
      # display the result
      textOutput("result")
    )
  )
)