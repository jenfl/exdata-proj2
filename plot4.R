#NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
#SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

coalSCC <- SCC[grep("Coal", SCC$EI.Sector), "SCC"]
coalNEI <- NEI[NEI$SCC %in% coalSCC,]

emissions1999 <- sum(coalNEI[coalNEI$year == 1999,"Emissions"])
emissions2002 <- sum(coalNEI[coalNEI$year == 2002,"Emissions"])
emissions2005 <- sum(coalNEI[coalNEI$year == 2005,"Emissions"])
emissions2008 <- sum(coalNEI[coalNEI$year == 2008,"Emissions"])

x <- c(1999, 2002, 2005, 2008)
y <- c(emissions1999, emissions2002, emissions2005, emissions2008)
y <- y/1000

#png(filename="plot4.png", width=480, height=480)
par(cex.axis=.75)
plot (x,y, pch=20, 
      xlab="Year of sample", 
      ylab="Total PM2.5 from coal-related sources, thousands of tons",
      type="n")
lines(x, y, col="red")