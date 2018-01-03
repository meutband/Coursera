rankall <- function(outcome, num = 'best') {
  
  ## Read data
  data <- read.csv('outcome-of-care-measures.csv', colClasses = 'character')
  
  ## Check that state and outcomes are valid
  if (!outcome %in% c('heart attack', 'heart failure', 'pneumonia')) {
    stop('invalid outcome')
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
  
  ## Sort by state, outcome, and hospital
  data_sub <- data[order(data$State, data[,index], data$Hospital.Name, na.last=TRUE), c(2,7)]
  data_sub <- na.omit(data_sub)
  
  ## Make dataframe for every num of hostipals in each state
  states <- unique(data_sub$State)
  rankings <- data.frame()
  
  for (s in states) {
    
    state <- subset(data_sub, State==s)
    
    if (num == 'best') {
      rankings <- rbind(rankings, state[1,])
    } else if(num == 'worst') {
      rankings <- rbind(rankings, tail(state,1))
    } else {
      rankings <- rbind(rankings, state[num,])
    }
  }
  
  return(rankings)
}