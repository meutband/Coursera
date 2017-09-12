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

#Create plot4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(house, {
  
  #Top Left
  plot(Global_active_power~Date, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  
  #Top Right
  plot(Voltage~Date, type="l", ylab="Voltage (volt)", xlab="")
  
  #Bottom Left
  plot(Sub_metering_1~Date, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Date,col='Red')
  lines(Sub_metering_3~Date,col='Blue') 
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  #Bottom Right
  plot(Global_reactive_power~Date, type="l", ylab="Global Reactive Power (kilowatts)", xlab="")
  
})
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()
