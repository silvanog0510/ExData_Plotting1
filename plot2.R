
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

#code to create plot2.png:            
        #open png device: 
                png(filename = "~/Desktop/Coursera_Courses/Exploratory_Data_Analysis/plot2.png",
                    width = 480, height = 480, units = "px", type = "quartz")
        #create plot:
                plot(power_df$Date.Time, power_df$Global_active_power, pch = ".",
                     xlab = "", ylab = "Global Active Power (kilowatts)")
                lines(power_df$Date.Time, power_df$Global_active_power)
        #close device: 
                dev.off()
        
