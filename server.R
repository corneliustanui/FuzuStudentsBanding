
# define server side processing

server <- function(input, output, session){
  
  # define data frame
  new_student_data <- reactive({
    
    # all fields are mandatory
    req(input$last_name)
    req(input$sex)
    req(input$geographical_location)
    req(input$university)
    req(input$gross_monthly_family_income)
    req(input$orphan_vulnerable_child)
    req(input$living_with_disability)
    req(input$number_of_dependents)
    req(input$poverty_probability_index)
    req(input$ProgramCostsKES)

    # enter data
    new_student_data <- data.frame(
      Name = paste(input$first_name, input$last_name),
      Sex = input$sex,
      County = input$geographical_location,
      University = input$university,
      FamilyIncome = input$gross_monthly_family_income,
      OrphanStatus = input$orphan_vulnerable_child,
      PwldStatus = input$living_with_disability,
      NumberOfDependents = input$number_of_dependents,
      PovertyProbabilityIndex = input$poverty_probability_index,
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
      
      # select relevant columns 
      
      new_data <- new_student_data() |>
        select(GrossFamilyIncome = FamilyIncome,
               GeographicalLocation = County,
               PovertyProbabilityIndex = PovertyProbabilityIndex,
               Orphans = OrphanStatus,
               Disability = PwldStatus,
               NumberOfDependents = NumberOfDependents,
               ProgramCostsKES = ProgramCostsKES,
               Gender = Sex)
      
      # generate bands
      new_student_band <- predict(object = multinom_fit,
                                  new_data = new_data,
                                  type = "class")$.pred_class

      
      # render data into a table
      output$new_student_data <- renderTable(new_student_data())
      output$result <- renderText(paste("Hey", 
                                        new_student_data()$Name, 
                                        "you are in band: ", 
                                        new_student_band))

    }
    
  )

}