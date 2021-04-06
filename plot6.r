
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "FNEI_data.csv")

library(tidyverse)
library(ggplot2)
library(bindrcpp)

NEI_data <- readRDS("summarySCC_PM25.rds")
SCC_data <- readRDS("Source_Classification_Code.rds")

baltYrTypEmmFips <- summarise(group_by(filter(NEI_data, NEI_data$fips == "24510"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))
laYrTypEmmFips <- summarise(group_by(filter(NEI_data, NEI_data$fips == "06037"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))

baltYrTypEmmFips$County <- "Baltimore City, MD"
laYrTypEmmFips$County <- "Los Angeles County, CA"

baltLaEmissions <- rbind(baltYrTypEmmFips, laYrTypEmmFips)

png("plot6.png", width=480, height=480)
ggplot(baltLaEmissions, aes(x=factor(year), y=Emissions, fill=County,label = round(Emissions,2))) +
  geom_bar(stat="identity") + 
  facet_grid(County~., scales="free") +
  ylab(expression("total PM"[2.5]*" emissions in tons")) + 
  xlab("year") +
  ggtitle(expression("Baltimore City vs Los Angeles County Motor vehicle emission in tons"))+
  geom_label(aes(fill = County),colour = "yellow", fontface = "bold")
dev.off()

