## setwd('Desktop/Coursera/DataScienceSpecialization/ExploratoryDataAnalysis/Week4/')
library(ggplot2)

## import the data (changed the folder name to make it more readable)
NEI <- readRDS("FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("FNEI_data/Source_Classification_Code.rds")

## get all baltimore and motor vehicle 
balt <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
baltemissions <- aggregate(Emissions ~ year, data=balt, FUN=sum)

# plot the total emissions, save as 'plot5.png'
ggplot(baltemissions, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity") +
  labs(x="year", y="Total PM2.5 Emissions", title="Emissions from motor vehicle sources in Baltimore City") +
  ggsave('plot5.png')

## Emissions are decreasing between 1999 - 2008