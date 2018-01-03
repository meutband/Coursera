## setwd('Desktop/Coursera/DataScienceSpecialization/ExploratoryDataAnalysis/Week4/')
library(ggplot2)

## import the data (changed the folder name to make it more readable)
NEI <- readRDS("FNEI_data/summarySCC_PM25.rds")

# Subset the data for Baltimore, MD (fips='24510')
BaltMD <- subset(NEI, fips=='24510')

## create array of the total emisions per year
BaltByYear <- tapply(BaltMD$Emissions, BaltMD$year, sum)

## plot the total emisions against the year, facet by type. save the plot as 'plot2.png'
ggplot(BaltMD, aes(factor(year), Emissions, fill=type)) +
  geom_bar(stat = "identity") + facet_grid(.~type) +
  labs(x='Year', y='Total Emissions (tons)') + 
  labs(title='The Total Emissions of PM2.5 per Year in Baltimore Maryland by Type (in tons)') +
  ggsave('images/plot3.png')

## All types decreased except for Point, which increased from 1999 to 2005, then decreased
