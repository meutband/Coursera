house <- read.table('household_power_consumption.txt', header=TRUE, sep=';', na.strings='?', 
                    colClasses=c('character','character','numeric','numeric','numeric',
                                 'numeric','numeric','numeric','numeric'))

#Convert the date column to Type Date, filter from dates 2007-02-01 and 2007-02-02
house$Date <- as.Date(house$Date, '%d/%m/%Y')
house <- subset(house, Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))

#Construct histogram, save as plot1.png
hist(house$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.copy(png,"images/plot1.png", width=480, height=480)
dev.off()
