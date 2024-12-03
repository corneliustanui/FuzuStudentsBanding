# load engine
multinom_fit <- readRDS("./mains/multinomial_regression_classifier.rds")

# define server side processing
server <- function(input, output, session){
  
  # define data frame
  new_student_data <- reactive({
    
    # all fields are mandatory
    req(input$Gender)
    req(input$GeographicalLocation)
    req(input$GrossFamilyIncome)
    req(input$Orphans)
    req(input$Disability)
    req(input$NumberOfDependents)
    req(input$PovertyProbabilityIndex)
    req(input$ProgramCostsKES)

    # enter data
    new_student_data <- data.frame(
      Gender = input$Gender,
      GeographicalLocation = input$GeographicalLocation,
      GrossFamilyIncome = input$GrossFamilyIncome,
      Orphans = input$Orphans,
      Disability = input$Disability,
      NumberOfDependents = input$NumberOfDependents,
      PovertyProbabilityIndex = input$PovertyProbabilityIndex,
      ProgramCostsKES = input$ProgramCostsKES
    )
    
    # return full data
    return(new_student_data)
    }
  )
  
  # run application
  observeEvent(
    eventExpr = input$generate_bands, 
    
    handlerExpr = {
      
      # generate bands
      new_student_band <- predict(object = multinom_fit,
                                  new_data = new_student_data(),
                                  type = "class")$.pred_class

      # send output to UI
      output$result <- renderText(paste("Hi there, you are in band: ", new_student_band))
    }
  )
}
