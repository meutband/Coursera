best <- function(state, outcome) {
  
  ## Read data
  data <- read.csv('outcome-of-care-measures.csv', colClasses = 'character')

  ## Check that state and outcomes are valid
  if (!outcome %in% c('heart attack', 'heart failure', 'pneumonia')) {
    stop('invalid outcome')
  }
  if (!state %in% data$State)  {
    stop('invalid state')
  }
  
  ## Get the column index of the data based on the outcome
  if (outcome == 'heart attack') {
    index <- 11
  } else if (outcome == 'heart failure') {
    index <- 17 
  } else {
    index <- 23
  }
  
  ## Coerce index column to numeric (supress warnings) and remove NA's
  data[,index] <- suppressWarnings(as.numeric(data[,index]))
  data <- na.omit(data)
  
  ## Subset the data by the given state, sort by outcome and hospital
  data_sub <- subset(data, State==state)
  data_sub <- data_sub[order(data_sub[,index], data_sub$Hospital.Name, na.last=TRUE), 2]

  ## Get hospital name with lowest value
  return(data_sub[1])
  
}