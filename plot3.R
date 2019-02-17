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

png( filename = "./Coursera/Assignments/Exploratory Data Analysis Assngmt 1/plot3.png", width = 480, height = 480)

# plot Sub_Metering_1 and New_Date with given annotations:

plot(mydata$New_Date, mydata$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")

# add on Sub_Metering_2 and Sub_Metering_3 to the new plot by using points 

points(mydata$New_Date, mydata$Sub_metering_2, col="red", type = "l")
points(mydata$New_Date, mydata$Sub_metering_3, col="blue", type = "l")

# add legend to the plot as required:

legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty, lwd = 1, col=c( "black", "red", "blue"))


# close device

dev.off()


