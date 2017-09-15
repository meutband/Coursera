library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Word Predictor"),
  h4("Mark Evans"),
  h4("John Hopkins Coursera Data Science Capstone", style="color:gray"),
  hr(),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      textInput("text", label = h3("Input"), value = "the little boy"),
      helpText("Type in a sentence above, hit enter (or press the button below), and the results will display to the right."),
      submitButton("Predict next"),
      hr()
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      br(),
      h2(textOutput("sentence"), align="center"),
      h1(textOutput("predicted"), align="center", style="color:blue")
    )
  )
  ))