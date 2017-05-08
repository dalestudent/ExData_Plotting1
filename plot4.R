# Plot 4 - Quad line chart

# Read the source data from the provided URL
# Need to replace all of the missing values ? with an NA
# Set the delimiter to a semi-colon ;
# Set the column classes
energy <- read.table("household_power_consumption.txt", 
                     header = TRUE, sep = ";", na.strings = "?", 
                     colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Subset to just the two days in question in d/m/yyyy format
twodays <- subset(energy, Date == "1/2/2007" | Date == "2/2/2007")

# Add a new column that combines the Date and Time columns as a Date Time value
twodaysTS <- within(twodays, { timestamp=strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S") })

# Create the fourth plot
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))

  # Plot 1 - Global active power vs time line chart
plot(twodaysTS$timestamp, twodaysTS$Global_active_power, 
     xlab = "", ylab = "Global Active Power", 
     type = "n")
lines(twodaysTS$timestamp, twodaysTS$Global_active_power)

  # Plot 2 - Voltage vs time line chart
plot(twodaysTS$timestamp, twodaysTS$Voltage, 
     xlab = "datetime", ylab = "Voltage", 
     type = "n")
lines(twodaysTS$timestamp, twodaysTS$Voltage)

  # Plot 3 - Energy sub metering vs time
plot(twodaysTS$timestamp, twodaysTS$Sub_metering_1, 
     xlab = "", ylab = "Energy sub metering", type = "n")
lines(twodaysTS$timestamp, twodaysTS$Sub_metering_1)
lines(twodaysTS$timestamp, twodaysTS$Sub_metering_2, col = "red")
lines(twodaysTS$timestamp, twodaysTS$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lwd = 1, bty = "n")

  # Plot 4 - Global reactive power vs time
plot(twodaysTS$timestamp, twodaysTS$Global_reactive_power, 
     xlab = "datetime", ylab = "Global_reactive_power", 
     type = "n")
lines(twodaysTS$timestamp, twodaysTS$Global_reactive_power)

dev.off()
