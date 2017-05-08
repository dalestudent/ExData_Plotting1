# Plot 3 - Line chart of sub metering over time

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

# Create the third plot
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(twodaysTS$timestamp, twodaysTS$Sub_metering_1, 
     xlab = "", ylab = "Energy sub metering", type = "n")
lines(twodaysTS$timestamp, twodaysTS$Sub_metering_1)
lines(twodaysTS$timestamp, twodaysTS$Sub_metering_2, col = "red")
lines(twodaysTS$timestamp, twodaysTS$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lwd = 1)
dev.off()
