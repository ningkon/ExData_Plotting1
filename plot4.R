# download the file to working directory

mydf <- read.table("./Coursera/data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

# load and start dplyr package

library(dplyr)

# Load only the data from 1/2/2007 and 2/2/2007

mydata <- filter(mydf, mydf$Date == '1/2/2007' | mydf$Date == '2/2/2007')

# Convert Date column into date datatype using dplyr pipe

mydata <- mydata %>% 
  mutate(Temp_Date = factor(Date)) %>% 
  mutate(New_Date = as.Date(Temp_Date, format = "%d/%m/%Y")) %>% 
  mutate(Date = New_Date)

# Concatenate Date and Time columns and create New_Date column as date datatype

mydata <- mydata %>% 
  mutate(dt = paste(Date, Time, sep = " ")) %>% 
  mutate(New_Date = as.POSIXct(dt)) %>% 
  select(Date:Sub_metering_3, New_Date)

# create new png graphics device to render plot to desired directory; set file height = width = 480

png( filename = "./Coursera/Assignments/Exploratory Data Analysis Assngmt 1/plot4.png", width = 480, height = 480)

# declare parameter to create 2 by 2 plot filled in row-wise

par(mfrow=c(2,2))

# plot the first plot: global active power as in plot1.png

plot(mydata$New_Date, b$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# plot the second plot: voltage~NewDate

plot(mydata$New_Date, mydata$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

# plot the third plot: voltage~NewDate: Sub metering as in plot3.png

plot(mydata$New_Date, mydata$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")

points(mydata$New_Date, mydata$Sub_metering_2, col="red", type = "l")
points(mydata$New_Date, mydata$Sub_metering_3, col="blue", type = "l")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty, lwd = 1, col=c( "black", "red", "blue"))

# plot the fourth plot: Global_reactive_power~NewDate

plot(mydata$New_Date, mydata$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")


# close device

dev.off()


