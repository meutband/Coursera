house <- read.table('household_power_consumption.txt', header=TRUE, sep=';', na.strings='?', 
                    colClasses=c('character','character','numeric','numeric','numeric',
                                 'numeric','numeric','numeric','numeric'))

#Convert the date column to Type Date, filter from dates 2007-02-01 and 2007-02-02
house$Date <- as.Date(house$Date, '%d/%m/%Y')
house <- subset(house, Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))
house <- house[complete.cases(house), ]

#Combine the date and time columns, replace combined column as Date in table, remove Time
dt <- paste(house$Date, house$Time)
house$Date <- dt
house <- subset(house, select = -Time)
house$Date <- as.POSIXct(house$Date)

#Create plot2
plot(house$Global_active_power~house$Date, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png,"images/plot2.png", width=480, height=480)
dev.off()
