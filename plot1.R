# Plot 1 - Histogram of Global_active_power

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

# Create the first plot
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(twodaysTS$Global_active_power, 
     col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", 
     main = "Global Active Power")
dev.off()
