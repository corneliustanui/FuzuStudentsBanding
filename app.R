
# load scripts
source("./ui.R")
source("./server.R")
source("./mains/globals.R")

# load engine
# source("./mains/engine.R")
multinom_fit <- readRDS("./mains/multinomial_regression_classifier.rds")

# Preview the app
shinyApp(ui = ui, server = server)
