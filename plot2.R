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

png( filename = "./Coursera/Assignments/Exploratory Data Analysis Assngmt 1/plot2.png", width = 480, height = 480)

# plot frequency of Global Active Power with given annotations:

plot(mydata$New_Date, b$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# close device

dev.off()








