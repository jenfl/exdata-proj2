# Have total emissions from PM2.5 decreased in Baltimore City, MD
# (fips 24510) from 1999 to 2008?

# Read in the data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")

# Pull out only Baltimore City data
baltemissions <- NEI[NEI$fips == "24510",]

# Sum up the emissions for each year in Baltimore City
baltemissions1999 <- sum(baltemissions[baltemissions$year == 1999,"Emissions"])
baltemissions2002 <- sum(baltemissions[baltemissions$year == 2002,"Emissions"])
baltemissions2005 <- sum(baltemissions[baltemissions$year == 2005,"Emissions"])
baltemissions2008 <- sum(baltemissions[baltemissions$year == 2008,"Emissions"])

# Populate x and y axis vectors
x <- c(1999, 2002, 2005, 2008)
y <- c(baltemissions1999, baltemissions2002, baltemissions2005, baltemissions2008)

# Plot to a png file with a red line
png(filename="plot2.png", width=480, height=480)
par(cex.axis=.75)
plot (x,y, pch=20, 
      xlab="Year of sample", 
      ylab="Total PM2.5 from all sources, in tons",
      type="n")
title(main="Total PM2.5 Emissions in Baltimore City, MD")
lines(x, y, col="red")
dev.off()