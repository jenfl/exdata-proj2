# Across the United States, how have emissions from coal 
# combustion-related sources changed from 1998 to 2008?

# Read in our data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# Figure out which SCC codes relate to coal
coalSCC <- SCC[grep("Coal", SCC$EI.Sector), "SCC"]
# Pull out just coal-related data
coalNEI <- NEI[NEI$SCC %in% coalSCC,]

# Sum up the emissions for each year from our coal-only data frame
emissions1999 <- sum(coalNEI[coalNEI$year == 1999,"Emissions"])
emissions2002 <- sum(coalNEI[coalNEI$year == 2002,"Emissions"])
emissions2005 <- sum(coalNEI[coalNEI$year == 2005,"Emissions"])
emissions2008 <- sum(coalNEI[coalNEI$year == 2008,"Emissions"])

# Populate x and y vectors
x <- c(1999, 2002, 2005, 2008)
y <- c(emissions1999, emissions2002, emissions2005, emissions2008)
y <- y/1000 # Emissions are huge, divide by 1000 for easier display

# Plot to a png file, red line plot
png(filename="plot4.png", width=480, height=480)
par(cex.axis=.75)
plot (x,y, pch=20, 
      xlab="Year of sample", 
      ylab="Total PM2.5 from coal-related sources, thousands of tons",
      type="n")
title(main="Coal Combustion-Related PM2.5 Emissions Across the US")
lines(x, y, col="red")
dev.off()