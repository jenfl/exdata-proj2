#NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")

emissions1999 <- sum(NEI[NEI$year == 1999,"Emissions"])
emissions2002 <- sum(NEI[NEI$year == 2002,"Emissions"])
emissions2005 <- sum(NEI[NEI$year == 2005,"Emissions"])
emissions2008 <- sum(NEI[NEI$year == 2008,"Emissions"])

x <- c(1999, 2002, 2005, 2008)
y <- c(emissions1999, emissions2002, emissions2005, emissions2008)
y <- y/1000000

#png(filename="plot1.png", width=480, height=480)
par(cex.axis=.75)
plot (x,y, pch=20, 
      xlab="Year of sample", 
      ylab="Total PM2.5 from all sources, millions of tons",
      type="n")
lines (x, y, col="red")