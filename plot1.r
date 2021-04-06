

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "FNEI_data.csv")

library(tidyverse)
library(ggplot2)
library(bindrcpp)

NEI_data <- readRDS("summarySCC_PM25.rds")
SCC_data <- readRDS("Source_Classification_Code.rds")

yearly_emmissions <- aggregate(Emissions ~ year, NEI_data, sum)

png("plot1.png", width=480, height=480)
cols <- c("maroon", "orange", "yellow", "Aquamarine")
barplot(height=yearly_emmissions$Emissions/1000, names.arg=yearly_emmissions$year, 
        xlab="Year", ylab=expression('Aggregated Emission'),
        main=expression('Aggregated PM'[2.5]*' Emmissions by Year'), col = cols)
dev.off()