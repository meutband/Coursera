## setwd('Desktop/Coursera/DataScienceSpecialization/ExploratoryDataAnalysis/Week4/')

## import the data (changed the folder name to make it more readable)
NEI <- readRDS("FNEI_data/summarySCC_PM25.rds")

# Subset the data for Baltimore, MD (fips='24510')
BaltMD <- subset(NEI, fips=='24510')

## create array of the total emisions per year
BaltByYear <- tapply(BaltMD$Emissions, BaltMD$year, sum)

## plot the total emisions against the year, save the plot as 'plot2.png'
png("plot2.png")
plot(names(BaltByYear), BaltByYear, type='l', xlab='Year', ylab='Total Emissions (tons)', 
     main='The Total Emissions of PM2.5 per Year in Baltimore Maryland (in tons)')
dev.off()

## decreased from 1999 to 2002, increased from 2002 to 2005, then decreased from 2005 to 2008.