library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Predict Sales Price"),
  sidebarLayout(
    sidebarPanel(
      h3("Please answer the following questions"),
      numericInput("lot", "What is the lot size of the property (square feet)?", 
                   value=3000, min=0, max=100000, step=10),
      numericInput("bed", "How many bedrooms?", value=3, min=0, max=100, step=1),
      numericInput("bath", "How many bathrooms?", value=2, min=0, max=100, step=1),
      numericInput("stor", "How many stories?", value=1, min=1, max=10, step=1),
      numericInput("gar","How many spaces are in the garage?", value=2, min=0, max=100, step=1),
      checkboxInput("dri", "Is there a driveway?", value=TRUE),
      checkboxInput("rec","Is there a recreation room?", value=TRUE),
      checkboxInput("base","Is there a full finished basement?", value=TRUE),
      checkboxInput("gas","Does the house use gas for hot water heating?", value=TRUE),
      checkboxInput("air","Does the house have central air conditioning?", value=TRUE),
      checkboxInput("area","Is the house located in a preferred neighbourhood of the city?", value=TRUE)
    ),
    mainPanel(
      h2("Projected Sales Price"),
      textOutput("pred")
    )
  )
))