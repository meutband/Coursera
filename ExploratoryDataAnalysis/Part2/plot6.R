## setwd('Desktop/Coursera/DataScienceSpecialization/ExploratoryDataAnalysis/Week4/')
library(ggplot2)

## import the data (changed the folder name to make it more readable)
NEI <- readRDS("FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("FNEI_data/Source_Classification_Code.rds")

## get all baltimore/los angeles and motor vehicle 
balt <- NEI[(NEI$fips == "24510") & (NEI$type=="ON-ROAD"),]
bemissions <- aggregate(Emissions ~ year, data=balt, FUN=sum)
bemissions$City <- 'Baltimore, MD'

losang <- NEI[(NEI$fips == "06037") & (NEI$type=="ON-ROAD"),]
lemissions <- aggregate(Emissions ~ year, data=losang, FUN=sum)
lemissions$City <- 'Los Angeles, CA'

emissions <- rbind(bemissions, lemissions)

# plot the total emissions, save as 'plot6.png'
ggplot(emissions, aes(x=factor(year), y=Emissions, fill=City)) +
  geom_bar(stat="identity") + facet_grid(.~City)
  labs(x="year", y="Total PM2.5 Emissions", title="Emissions from motor vehicle sources in Baltimore City") +
  ggsave('plot6.png')

## Baltimore is decreasing for all years, Los Angeles is increasing between 1999 and 2005
## and then decreasing to 2008