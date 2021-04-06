
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "FNEI_data.csv")

library(tidyverse)
library(ggplot2)
library(bindrcpp)

NEI_data <- readRDS("summarySCC_PM25.rds")
SCC_data <- readRDS("Source_Classification_Code.rds")

baltdata <- NEI_data[NEI_data$fips=="24510", ]

baltYrEmm <- aggregate(Emissions ~ year, baltdata, sum)

png("plot2.png", width=480, height=480)
cols1 <- c("maroon", "yellow", "orange", "Aquamarine")
barplot(height=baltYrEmm$Emissions/1000, names.arg=baltYrEmm$year, 
        xlab="Year", ylab=expression('Aggregated Emission'),
        main=expression('Baltimore Aggregated PM'[2.5]*' Emmissions by Year'), col = cols1)
dev.off()