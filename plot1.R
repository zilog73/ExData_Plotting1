library(dplyr)

#Reading the file provided with header, all columns as character and ; as separator 
dataPowerConsumption <- read.table(file = "./household_power_consumption.txt", colClasses = "character", sep = ";", header = TRUE)

#Creates a new variable DateTime with Date and Time merged
dataPowerConsumption$DateTime <- paste(dataPowerConsumption$Date, dataPowerConsumption$Time, sep= " ")

#Formats the new column DateTime to type Date/Time
dataPowerConsumption$DateTime <- strptime(dataPowerConsumption$DateTime, format = "%d/%m/%Y %H:%M:%S")

#Creates 2 variables to define the dates range. Every value earlier than 2007-02-03 will belong to 2007-02-02   
startDate <- as.POSIXlt("2007-02-01")
endDate <- as.POSIXlt("2007-02-03") 

#Filters the rows with DateTime within the dates range
dataPowerConsumption <- subset(dataPowerConsumption, DateTime > startDate & DateTime < endDate)

#Converts Filters the rows with DateTime within the dates range
dataPowerConsumption <- dataPowerConsumption %>% mutate_each(funs(as.numeric(.)), Global_active_power:Sub_metering_3)

#Create a PNG file as graphic device
png(filename = "plot1.png", width = 480, height = 480)

#Creates an histogram with variable Global_active_power
hist(dataPowerConsumption$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#Closes the graphic device
dev.off()