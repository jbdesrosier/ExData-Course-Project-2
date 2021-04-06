
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "FNEI_data.csv")

library(tidyverse)
library(ggplot2)
library(bindrcpp)

NEI_data <- readRDS("summarySCC_PM25.rds")
SCC_data <- readRDS("Source_Classification_Code.rds")

baltdata <- NEI_data[NEI_data$fips=="24510", ]

baltYrTypEmm <- aggregate(Emissions ~ year+ type, baltdata, sum)

png("plot4.png", width=480, height=480)
chart2 <- ggplot(baltYrTypEmm, aes(factor(year), Emissions))
chart2 <- chart + geom_bar(stat="identity") +
  xlab("year") +  
  ylab(expression('Total Emissions')) +
  ggtitle('Total [2.5]* Coal Emissions From 1999 to 2008')
print(chart2)
dev.off()