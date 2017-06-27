library(Ecdat)
data(Housing)
library(shiny)

shinyServer(function(input, output) {
  
  ## Change 'yes'/'no' to TRUE/FALSE
  Housing$driveway <- ifelse(Housing$driveway=="yes", TRUE, FALSE)
  Housing$recroom <- ifelse(Housing$recroom=="yes", TRUE, FALSE)
  Housing$fullbase <- ifelse(Housing$fullbase=="yes", TRUE, FALSE)
  Housing$gashw <- ifelse(Housing$gashw=="yes", TRUE, FALSE)
  Housing$airco <- ifelse(Housing$airco=="yes", TRUE, FALSE)
  Housing$prefarea <- ifelse(Housing$prefarea=="yes", TRUE, FALSE)
  
  model <- lm(price~., data=Housing)
  
  modelpred <- reactive({
    
    ## Input all the data from the user
    lotInput <- input$lot
    bedInput <- input$bed
    bathInput <- input$bath
    storInput <- input$stor
    driInput <- input$dri
    recInput <- input$rec
    baseInput <- input$base
    gasInput <- input$gas
    airInput <- input$air
    garInput <- input$gar
    areaInput <- input$area
    
    ## Predict the sales price of a home from the user inputs
    predict(model, newdata = data.frame(lotsize=lotInput, bedrooms=bedInput, bathrms=bathInput, 
                                        stories=storInput, driveway=driInput, recroom=recInput,
                                        fullbase=baseInput, gashw=gasInput, airco=airInput,
                                        garagepl=garInput, prefarea=areaInput)) 
  })
  
  output$pred <- renderText({
    modelpred()
  })
  
})