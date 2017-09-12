## setwd('Desktop/Coursera/DataScienceSpecialization/ExploratoryDataAnalysis/Week4/')
library(ggplot2)

## import the data (changed the folder name to make it more readable)
NEI <- readRDS("FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("FNEI_data/Source_Classification_Code.rds")

## Find all coal comustion related sources
combustioncoal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
combustioncoalsources <- SCC[combustioncoal,]

## Find emissions, group by year
emissions <- NEI[(NEI$SCC %in% combustioncoalsources$SCC), ]
emissionsyear <- aggregate(Emissions ~ year, data=emissions, FUN=sum)

## Plot total emissions, save as 'plot4.png'
ggplot(emissionsyear, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity") +
  labs(x="Year", y="Total PM2.5 Emissions", title="Emissions from coal combustion-related sources") +
  ggsave('plot4.png')

## Emissions are decreasing between 1999 - 2008