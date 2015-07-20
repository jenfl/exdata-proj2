# Have total emissions from PM2.5 decreased in the United States
# from 1999 to 2008?  Show the *total* PM2.5 emission from all
# sources for each of the years 1999, 2002, 2005, and 2008.

# Read in the data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")

# Sum up the emissions for each year
emissions1999 <- sum(NEI[NEI$year == 1999,"Emissions"])
emissions2002 <- sum(NEI[NEI$year == 2002,"Emissions"])
emissions2005 <- sum(NEI[NEI$year == 2005,"Emissions"])
emissions2008 <- sum(NEI[NEI$year == 2008,"Emissions"])

# Populate x and y axis vectors
x <- c(1999, 2002, 2005, 2008)
y <- c(emissions1999, emissions2002, emissions2005, emissions2008)
y <- y/1000000 # Emissions values are huge, divide by a million for display

# Plot to a png file, line plot in red
png(filename="plot1.png", width=480, height=480)
par(cex.axis=.75)
plot (x,y, pch=20, 
      xlab="Year of sample", 
      ylab="Total PM2.5 from all sources, millions of tons",
      type="n")
title(main="Total PM2.5 Emissions across the US")
lines (x, y, col="red")
dev.off()