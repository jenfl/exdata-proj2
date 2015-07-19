#NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")

baltemissions <- NEI[NEI$fips == "24510",]

baltemissions1999 <- sum(baltemissions[baltemissions$year == 1999,"Emissions"])
baltemissions2002 <- sum(baltemissions[baltemissions$year == 2002,"Emissions"])
baltemissions2005 <- sum(baltemissions[baltemissions$year == 2005,"Emissions"])
baltemissions2008 <- sum(baltemissions[baltemissions$year == 2008,"Emissions"])

x <- c(1999, 2002, 2005, 2008)
y <- c(baltemissions1999, baltemissions2002, baltemissions2005, baltemissions2008)

#png(filename="plot2.png", width=480, height=480)
par(cex.axis=.75)
plot (x,y, pch=20, 
      xlab="Year of sample", 
      ylab="Total PM2.5 from all sources, Baltimore City, MD",
      type="n")
lines(x, y, col="red")