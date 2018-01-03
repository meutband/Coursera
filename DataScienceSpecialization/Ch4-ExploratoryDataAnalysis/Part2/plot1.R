## setwd('Desktop/Coursera/DataScienceSpecialization/ExploratoryDataAnalysis/Week4/')

## import the data (changed the folder name to make it more readable)
NEI <- readRDS("FNEI_data/summarySCC_PM25.rds")

## create array of the total emisions per year
TotalByYear <- tapply(NEI$Emissions, NEI$year, sum)

## plot the total emisions against the year, save the plot as 'plot1.png'
png("images/plot1.png")
plot(names(TotalByYear), TotalByYear, type='l', xlab='Year', ylab='Total Emissions (tons)', 
     main='The Total Emissions of PM2.5 per Year (in tons)')
dev.off()

## The total amount of pm2.5 emissions is decreasing between the years of 1999 and 2008.
