
#set the path to the data: 
        filepath <- "~/Desktop/Coursera_Courses/Exploratory_Data_Analysis/household_power_consumption.txt"
#read in the data, only rows corresponding to Feb 1st and Feb 2nd, 2007:         
        power_df <- read.table(filepath, header = FALSE, sep = ";", skip = 66637, nrows = 2880)
#add back in correct column names:        
        Lines <- readLines(filepath)
        temp_col_names <- Lines[1]
        col_names <- unlist(strsplit(temp_col_names, ";"))
        names(power_df) <- col_names
#convert the 'Date' and 'Time' variables to Date/Time classes and combine into a single column: 
        library(lubridate)
        power_df$Date <- as.character(power_df$Date)
        power_df$Time <- as.character(power_df$Time) 
        power_df <- data.frame((paste(power_df$Date, power_df$Time, sep = " ")), power_df)
        colnames(power_df)[1] <- "Date.Time"
        power_df <- subset(power_df, select = -c(2,3))
        power_df$Date.Time <- as.character(power_df$Date.Time)
        power_df$Date.Time <- dmy_hms(power_df$Date.Time) 

#code to create plot4.png:            
        #open png device:
                png(filename = "~/Desktop/Coursera_Courses/Exploratory_Data_Analysis/plot4.png",
                    width = 480, height = 480, units = "px", type = "quartz")
        #set multi-plot dimensions:
                par(mfrow = c(2,2))
        #top left:
                plot(power_df$Date.Time, power_df$Global_active_power, pch = ".",
                     xlab = "", ylab = "Global Active Power")
                lines(power_df$Date.Time, power_df$Global_active_power)
        #top right:
                plot(power_df$Date.Time, power_df$Voltage, pch = ".",
                     xlab = "datetime", ylab = "Voltage")
                lines(power_df$Date.Time, power_df$Voltage)
        #bottom left:
                plot(power_df$Date.Time, power_df$Sub_metering_1, 
                     type = "n", xlab = "", ylab = "Energy sub metering")
                        #sub_metering_1:
                        points(power_df$Date.Time, power_df$Sub_metering_1, pch = ".",
                               col = "black")
                        lines(power_df$Date.Time, power_df$Sub_metering_1, col = "black")
                        #sub_metering_2:
                        points(power_df$Date.Time, power_df$Sub_metering_2, pch = ".",
                               col = "red")
                        lines(power_df$Date.Time, power_df$Sub_metering_2, col = "red")
                        #sub_metering_3:
                        points(power_df$Date.Time, power_df$Sub_metering_3, pch = ".",
                               col = "blue")
                        lines(power_df$Date.Time, power_df$Sub_metering_3, col = "blue")
                legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                       col = c("black","red","blue"), lwd = 1, lty = 1, 
                       bty = "n")
        #bottom right:
                plot(power_df$Date.Time, power_df$Global_reactive_power, pch = ".",
                     xlab = "datetime", ylab = "Global_reactive_power")
                lines(power_df$Date.Time, power_df$Global_reactive_power)
        #close device:
                dev.off()
        
        
